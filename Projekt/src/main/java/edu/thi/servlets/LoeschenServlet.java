package edu.thi.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.sql.DataSource;

import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoeschenServlet")
public class LoeschenServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Resource(lookup="java:jboss/datasources/MySqlThidbDS")
	private DataSource ds;
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Long id = (Long) session.getAttribute("b_id");

        // Überprüfe den Kontostand, bevor du das Konto bzw. den Benutzer löschst
        if (!isKontostandNull(id)) {
            // Kontostand ist nicht null, zeige eine Fehlermeldung an
            String errorMessage = "Konto kann nicht gelöscht werden, da der Kontostand nicht 0 € beträgt.";
            request.setAttribute("errorMessage", errorMessage);
            request.setAttribute("showMessage", true); // Attribute, um die Popup-Nachricht anzuzeigen
        } else {
            // Lösche zuerst die Konten, um die referenzielle Integrität sicherzustellen
            deleteKonto(id);
            deleteBenutzer(id);

            // Setze eine Erfolgsmeldung, die auf der Benutzerverwaltung.jsp angezeigt wird
            String successMessage = "Konto und Benutzer erfolgreich gelöscht.";
            request.setAttribute("successMessage", successMessage);
        }

        // Leite zurück zur Benutzerverwaltung.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("html/benutzerverwaltung.jsp");
        dispatcher.forward(request, response);
    }

    private boolean isKontostandNull(Long id) throws ServletException {
        boolean kontostandNull = true;
        try (Connection con = ds.getConnection();
                PreparedStatement pstmt = con.prepareStatement("SELECT kontostand FROM Konto WHERE besitzer = ?")) {
            pstmt.setLong(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    double kontostand = rs.getDouble("kontostand");
                    // Überprüfe, ob der Kontostand null ist
                    kontostandNull = (kontostand == 0);
                }
            }
        } catch (Exception ex) {
            throw new ServletException(ex.getMessage());
        }
        return kontostandNull;
    }

    private void deleteBenutzer(Long id) throws ServletException {
        try (Connection con = ds.getConnection();
                PreparedStatement pstmt = con.prepareStatement("DELETE FROM Benutzer WHERE b_id = ?")) {
            pstmt.setLong(1, id);
            pstmt.executeUpdate();
        } catch (Exception ex) {
            throw new ServletException(ex.getMessage());
        }
    }

    private void deleteKonto(Long id) throws ServletException {
        try (Connection con = ds.getConnection();
                PreparedStatement pstmt = con.prepareStatement("DELETE FROM Konto WHERE besitzer = ?")) {
            pstmt.setLong(1, id);
            pstmt.executeUpdate();
        } catch (Exception ex) {
            throw new ServletException(ex.getMessage());
        }
    }

	
}
