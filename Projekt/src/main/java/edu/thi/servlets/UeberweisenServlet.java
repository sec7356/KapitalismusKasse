package edu.thi.servlets;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.io.IOException;

import javax.sql.DataSource;

@WebServlet("/UeberweisenServlet")
public class UeberweisenServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Resource(lookup="java:jboss/datasources/MySqlThidbDS")
    private DataSource dataSource;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String vonIBAN = (String) session.getAttribute("IBAN");
        String nachIBAN = request.getParameter("nach");
        String summeStr = request.getParameter("summe");
        double summe = Double.parseDouble(summeStr);
        
        Connection conn = null;
        // Zur INFO: Transaktionsmanagement über ChatGPT generiert 

        try {
            conn = dataSource.getConnection();
            // Transaktion starten
            conn.setAutoCommit(false);

            // Überprüfen, ob 'von' und 'nach' IBAN unterschiedlich sind
            if (vonIBAN.equals(nachIBAN)) {
                session.setAttribute("showMessage", "true");		// Fehlermeldungen erscheinen noch nicht, eventuell über PopUp oder über Alert Boxen mitteilen
                session.setAttribute("errorMessage", "Überweisung an dasselbe Konto nicht erlaubt");
                response.sendRedirect("html/Ueberweisungen.jsp");
                return;
            }

            // Überprüfen, ob genügend Guthaben auf dem 'von'-Konto vorhanden ist
            double vonKontostand = getKontostand(conn, vonIBAN);
            if (vonKontostand < summe) {
                session.setAttribute("showMessage", "true");	// Fehlermeldungen erscheinen noch nicht, eventuell über PopUp oder über Alert Boxen mitteilen
                session.setAttribute("errorMessage", "Nicht genügend Guthaben");
                response.sendRedirect("html/Ueberweisungen.jsp");
                return;
            }

            // Betrag vom 'von'-Konto abziehen
            updateKontostand(conn, vonIBAN, vonKontostand - summe);

            // Betrag zum 'nach'-Konto hinzufügen
            double nachKontostand = getKontostand(conn, nachIBAN);
            updateKontostand(conn, nachIBAN, nachKontostand + summe);

            // Transaktion in der DB speichern
            speichereTransaktion(conn, vonIBAN, nachIBAN, summe);

            // Transaktion abschließen
            conn.commit();
            
            // Aktualisierten Saldo abrufen und in der Sitzung speichern
            double neuerVonKontostand = getKontostand(conn, vonIBAN);
            session.setAttribute("kontostand", neuerVonKontostand);

            // Erfolgsmeldung setzen und weiterleiten
            session.setAttribute("showMessage", "true");
            session.setAttribute("successMessage", "Überweisung erfolgreich");	// statt auf die UserStartseite.jsp auf eine Überblick.jsp 
            										//weiterleiten, wo alle Eingaben nochmal stehen, bzw. auch die Daten von der Transaktion Tabelle
            response.sendRedirect("html/UserStartseite.jsp");
            
        } 
        catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }
            session.setAttribute("showMessage", "true");
            session.setAttribute("errorMessage", "Fehler bei der Überweisung");	// Fehlermeldungen erscheinen noch nicht, eventuell über PopUp oder über Alert Boxen mitteilen
            response.sendRedirect("html/Ueberweisungen.jsp");
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private double getKontostand(Connection conn, String iban) throws SQLException {
        String query = "SELECT kontostand FROM konto WHERE IBAN = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, iban);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("kontostand");
                } else {
                    throw new SQLException("Konto nicht gefunden: " + iban);
                }
            }
        }
    }

    private void updateKontostand(Connection conn, String iban, double neuerKontostand) throws SQLException {
        String update = "UPDATE konto SET kontostand = ? WHERE IBAN = ?";
        try (PreparedStatement stmt = conn.prepareStatement(update)) {
            stmt.setDouble(1, neuerKontostand);
            stmt.setString(2, iban);
            stmt.executeUpdate();
        }
    }

    private void speichereTransaktion(Connection conn, String vonIBAN, String nachIBAN, double summe) throws SQLException {
        String insert = "INSERT INTO transaktion (von, nach, summe, zeitstempel) VALUES (?, ?, ?, CURRENT_TIMESTAMP)";
        try (PreparedStatement stmt = conn.prepareStatement(insert)) {
            stmt.setString(1, vonIBAN);
            stmt.setString(2, nachIBAN);
            stmt.setDouble(3, summe);
            stmt.executeUpdate();
        }
    }
}
