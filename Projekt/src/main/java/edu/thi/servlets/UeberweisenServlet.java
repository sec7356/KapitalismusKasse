package edu.thi.servlets;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDateTime;

import javax.sql.DataSource;

import edu.thi.java.Benutzer;
import edu.thi.java.Konto;
import edu.thi.java.Transaktion;

@WebServlet("/UeberweisenServlet")
public class UeberweisenServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Resource(lookup="java:jboss/datasources/MySqlThidbDS")
    private DataSource ds;

    public UeberweisenServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Transaktion transaktion = new Transaktion();
        
        Benutzer benutzer = new Benutzer();          
        benutzer.setB_id(session.getAttribute("b_id") != null ? Long.valueOf(session.getAttribute("b_id").toString()) : null);
        benutzer.setAdmin((boolean) session.getAttribute("admin"));
		benutzer.setB_id(session.getAttribute("b_id") != null ? Long.valueOf(session.getAttribute("b_id").toString()) : null);
		benutzer.setAdmin(session.getAttribute("admin") != null ? Boolean.valueOf(session.getAttribute("admin").toString()) : null);
		benutzer.setEmail(session.getAttribute("email") != null ? session.getAttribute("email").toString() : null);
		benutzer.setVorname(session.getAttribute("vorname") != null ? session.getAttribute("vorname").toString() : null);
		benutzer.setNachname(session.getAttribute("nachname") != null ? session.getAttribute("nachname").toString() : null);
		benutzer.setPin(session.getAttribute("pin") != null ? Integer.parseInt(session.getAttribute("pin").toString()) : 0);
		
		Konto konto = new Konto();
		konto.setBesitzer(session.getAttribute("b_id") != null ? Long.valueOf(session.getAttribute("b_id").toString()) : null);
		konto.setIBAN(session.getAttribute("IBAN") != null ? session.getAttribute("IBAN").toString() : null);
		konto.setKontoStand(session.getAttribute("kontostand") != null ? Double.valueOf(session.getAttribute("kontostand").toString()) : null);

        String von = konto.getIBAN();
        String nach = request.getParameter("nach"); // IBAN des Empfängers aus der Anfrage holen
        String summeStr = request.getParameter("summe");

        try {
            double summe = Double.parseDouble(summeStr);
            if (summe <= 0 || summe * 100 != Math.floor(summe * 100)) {
                // Falsches Format der Summe
                String errorMessage = "Die Überweisung konnte nicht durchgeführt werden, da die Summe nicht korrekt angegeben wurde.";
                request.setAttribute("errorMessage", errorMessage);
                request.setAttribute("showMessage", true); // Attribute, um die Popup-Nachricht anzuzeigen
                request.getRequestDispatcher("html/fehlermeldungAllgemein.jsp").forward(request, response);
                return;
            }

            if (von.equals(nach)) {
                // Gleiche IBAN
                String errorMessage = "Die Überweisung konnte nicht durchgeführt werden, da die beiden IBANs dieselben sind.";
                request.setAttribute("errorMessage", errorMessage);
                request.setAttribute("showMessage", true); // Attribute, um die Popup-Nachricht anzuzeigen
                request.getRequestDispatcher("html/fehlermeldungAllgemein.jsp").forward(request, response);
                return;
            }

            if (!AccountExists(von)) {
                // "Von" Konto existiert nicht
                String errorMessage = "Die Überweisung konnte nicht durchgeführt werden, da das 'Von' Konto nicht existiert.";
                request.setAttribute("errorMessage", errorMessage);
                request.setAttribute("showMessage", true); // Attribute, um die Popup-Nachricht anzuzeigen
                request.getRequestDispatcher("html/fehlermeldungAllgemein.jsp").forward(request, response);
                return;
            }

            if (!AccountExists(nach)) {
                // "Nach" Konto existiert nicht
                String errorMessage = "Die Überweisung konnte nicht durchgeführt werden, da das 'Nach' Konto nicht existiert.";
                request.setAttribute("errorMessage", errorMessage);
                request.setAttribute("showMessage", true); // Attribute, um die Popup-Nachricht anzuzeigen
                request.getRequestDispatcher("html/fehlermeldungAllgemein.jsp").forward(request, response);
                return;
            }

            if (!isBalanceSufficient(von, summe)) {
                // Kontostand nicht ausreichend
                String errorMessage = "Die Überweisung konnte nicht durchgeführt werden, da der Kontostand des Absenderkontos nicht ausreicht.";
                request.setAttribute("errorMessage", errorMessage);
                request.setAttribute("showMessage", true); // Attribute, um die Popup-Nachricht anzuzeigen
                request.getRequestDispatcher("html/fehlermeldungAllgemein.jsp").forward(request, response);
                return;
            }

            transaktion.setVon(von);
            transaktion.setNach(nach);
            transaktion.setSumme(summe);

            performTransaction(transaktion, response);

            response.sendRedirect("html/UserStartseite.jsp"); // Weiterleitung bei Erfolg
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("html/fehlermeldungAllgemein.jsp"); // Weiterleitung bei Fehler
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("html/fehlermeldungAllgemein.jsp"); // Weiterleitung bei Fehler
        }
    }

    private boolean AccountExists(String iban) throws SQLException {
        // DB-Zugriff
        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement("SELECT * FROM Konto WHERE iban = ?")) {

            pstmt.setString(1, iban);
            ResultSet rs = pstmt.executeQuery();

            // Wenn ein Ergebnis gefunden wurde, gibt es einen Eintrag mit dieser IBAN
            return rs.next();
        }
    }

    private boolean isBalanceSufficient(String iban, double summe) throws SQLException {
        // DB-Zugriff
        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement("SELECT kontostand FROM Konto WHERE iban = ?")) {

            pstmt.setString(1, iban);
            ResultSet rs = pstmt.executeQuery();

            // Wenn ein Ergebnis gefunden wurde
            if (rs.next()) {
                double kontostand = rs.getDouble("kontostand");
                // Überprüfen, ob der Kontostand mindestens gleich der Summe ist
                return kontostand >= summe;
            } else {
                // Wenn kein Ergebnis gefunden wurde, ist der Kontostand nicht ausreichend
                return false;
            }
        }
    }

    private void performTransaction(Transaktion transaktion, HttpServletResponse response) throws ServletException, SQLException {
        // DB-Zugriff
        String[] generatedKeys = new String[] { "t_id" }; // Name der Spalte(n), die automatisch generiert wird(werden)

        // Connect to the database
        try (Connection con = ds.getConnection()) {
            String insertQuery = "INSERT INTO Transaktion (von, nach, summe, zeitstempel) VALUES (?, ?, ?, ?)";
            try (PreparedStatement pstmt = con.prepareStatement(insertQuery, generatedKeys)) {
                pstmt.setString(1, transaktion.getVon());
                pstmt.setString(2, transaktion.getNach());
                pstmt.setDouble(3, transaktion.getSumme());
                pstmt.setTimestamp(4, Timestamp.valueOf(LocalDateTime.now()));

                pstmt.executeUpdate();

                // Generierte(n) Schlüssel auslesen (funktioniert nur mit PreparedStatement)
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        transaktion.setT_id(rs.getLong(1));
                    }
                }
            }

            // Update account balances
            // Subtract amount from 'von' account
            String updateVonQuery = "UPDATE Konto SET kontostand = kontostand - ? WHERE iban = ?";
            try (PreparedStatement pstmt = con.prepareStatement(updateVonQuery)) {
                pstmt.setDouble(1, transaktion.getSumme());
                pstmt.setString(2, transaktion.getVon());
                pstmt.executeUpdate();
            }

            // Add amount to 'nach' account
            String updateNachQuery = "UPDATE Konto SET kontostand = kontostand + ? WHERE iban = ?";
            try (PreparedStatement pstmt = con.prepareStatement(updateNachQuery)) {
                pstmt.setDouble(1, transaktion.getSumme());
                pstmt.setString(2, transaktion.getNach());
                pstmt.executeUpdate();
            }
        }
    }
}
