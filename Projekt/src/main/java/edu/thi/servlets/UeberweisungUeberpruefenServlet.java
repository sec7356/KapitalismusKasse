//Autor: Can

package edu.thi.servlets;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/UeberweisungUeberpruefenServlet")
public class UeberweisungUeberpruefenServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Resource(lookup = "java:jboss/datasources/MySqlThidbDS")
    private DataSource ds;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
	    HttpSession session = request.getSession();

    	
    	String von = (String) request.getSession().getAttribute("IBAN");
        String nach = request.getParameter("nach");
        String summe = request.getParameter("summe");
        String verwendungszweck = request.getParameter("verwendungszweck");
        String nachVorname = null;
        String nachNachname = null;
        
        // Überprüfen, ob versucht wird, an die eigene IBAN zu überweisen
        if (von.equals(nach)) {
            session.setAttribute("error", "Überweisungen auf die eigene IBAN sind nicht zulässig.");
            response.sendRedirect(request.getContextPath() + "/html/Ueberweisungen.jsp");
            return;
        }
        
        // Datenbankzugriff, um den Vor- und Nachnamen des Empfängers zu erhalten
        try (Connection con = ds.getConnection()) {
            String checkIbanQuery = "SELECT COUNT(*) AS count FROM konto WHERE IBAN = ?";
            try (PreparedStatement checkIbanStmt = con.prepareStatement(checkIbanQuery)) {
                checkIbanStmt.setString(1, nach);
                try (ResultSet checkIbanResult = checkIbanStmt.executeQuery()) {
                    if (checkIbanResult.next()) {
                        int count = checkIbanResult.getInt("count");
                        if (count == 0) {
                            // Empfänger-IBAN nicht gefunden
                            session.setAttribute("error", "Der Empfänger mit der angegebenen IBAN ist kein Kunde unseres Instituts.");
                            response.sendRedirect(request.getContextPath() + "/html/Ueberweisungen.jsp");
                            return; // Beende die Methode, um die Weiterleitung zu verhindern
                        }
                    }
                }
            }

            // IBAN gefunden, hole Vor- und Nachnamen des Empfängers
            String getNameQuery = "SELECT vorname, nachname FROM benutzer WHERE b_id = (SELECT besitzer FROM konto WHERE IBAN = ?)";
            try (PreparedStatement pstmt = con.prepareStatement(getNameQuery)) {
                pstmt.setString(1, nach);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        nachVorname = rs.getString("vorname");
                        nachNachname = rs.getString("nachname");
                    }
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }

        // Setze Attribute für die Weiterleitung
        request.setAttribute("von", von);
        request.setAttribute("nach", nach);
        request.setAttribute("summe", summe);
        request.setAttribute("verwendungszweck", verwendungszweck);
        request.setAttribute("nachVorname", nachVorname);
        request.setAttribute("nachNachname", nachNachname);

        // Weiterleitung an die nächste Seite
        request.getRequestDispatcher("/html/UeberweisungTeil2.jsp").forward(request, response);

    }
}
