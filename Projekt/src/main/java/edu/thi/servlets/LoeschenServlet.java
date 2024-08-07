//Autor: Diane

package edu.thi.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.sql.DataSource;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoeschenServlet")
public class LoeschenServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Resource(lookup = "java:jboss/datasources/MySqlThidbDS")
    private DataSource ds;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Long id = (Long) session.getAttribute("b_id");

        // Überprüfe den Kontostand, bevor du das Konto bzw. den Benutzer löschst
        Double kontostand = getKontostand(id);
        if (kontostand != null && kontostand != 0) {
            // Kontostand ist nicht null, zeige eine Fehlermeldung mit dem genauen Kontostand an
            String errorMessage = String.format("Konto kann nicht gelöscht werden, da der Kontostand %.2f € beträgt.", kontostand);
            session.setAttribute("errorMessage", errorMessage);
            response.sendRedirect(request.getContextPath() + "/html/benutzerverwaltung.jsp");
            return;
        } else {
            // Lösche zuerst die Konten, um die referenzielle Integrität sicherzustellen
            deleteKonto(id);
            deleteBenutzer(id);

            // Setze eine Erfolgsmeldung, die auf der Benutzerverwaltung.jsp angezeigt wird
            String successMessage = "Konto und Benutzer erfolgreich gelöscht.";
            session.setAttribute("successMessage", successMessage);
        }

        // Session ungültig machen und umleiten
        session.invalidate();
        response.sendRedirect(request.getContextPath() + "/html/Banking-Login.jsp?message=success");
    }

    private Double getKontostand(Long id) throws ServletException {
        Double kontostand = null;
        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement("SELECT kontostand FROM Konto WHERE besitzer = ?")) {
            pstmt.setLong(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    kontostand = rs.getDouble("kontostand");
                }
            }
        } catch (Exception ex) {
            throw new ServletException(ex.getMessage());
        }
        return kontostand;
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
