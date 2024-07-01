package edu.thi.servlets;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;
import edu.thi.java.Benutzer;

@WebServlet("/UpdateServlet")
@MultipartConfig
public class UpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Resource(lookup = "java:jboss/datasources/MySqlThidbDS")
    private DataSource ds;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        session.removeAttribute("errorMessage"); // Fehlermeldung zurücksetzen
        
        String vorname = (String) session.getAttribute("vorname");
        String nachname = (String) session.getAttribute("nachname");
        Long b_id = (Long) session.getAttribute("b_id");
        
        Benutzer benutzer = new Benutzer();
        benutzer.setB_id(b_id);
        benutzer.setVorname(vorname);
        benutzer.setNachname(nachname);
        
        // Eingaben für Namen validieren & ggf. überschreiben
        String neuerVorname = request.getParameter("neuerVorname");
        if (neuerVorname != null && !neuerVorname.isBlank() && !neuerVorname.matches("[a-zA-ZäöüÄÖÜß ]+")) {
            session.setAttribute("errorMessage", "Der Vorname darf nur aus Buchstaben bestehen.");
            response.sendRedirect(request.getContextPath() + "/html/benutzerverwaltung.jsp");  
            return;
        } else if (neuerVorname != null && !neuerVorname.isBlank()) {
            benutzer.setVorname(neuerVorname);
            session.setAttribute("vorname", neuerVorname);
        }
        
        String neuerNachname = request.getParameter("neuerNachname");
        if (neuerNachname != null && !neuerNachname.isBlank() && !neuerNachname.matches("[a-zA-ZäöüÄÖÜß ]+")) {
            session.setAttribute("errorMessage", "Der Nachname darf nur aus Buchstaben bestehen.");
            response.sendRedirect(request.getContextPath() + "/html/benutzerverwaltung.jsp");  
            return;
        } else if (neuerNachname != null && !neuerNachname.isBlank()) {
            benutzer.setNachname(neuerNachname);
            session.setAttribute("nachname", neuerNachname);
        }
        
        String pin1 = request.getParameter("neuepin1");
        String pin2 = request.getParameter("neuepin2");

        Integer neuerPin = null;
        if (pin1 != null && !pin1.isBlank() && pin1.equals(pin2) && pin1.matches("\\d+")) {
            neuerPin = Integer.parseInt(pin1);
        } else if (pin1 != null && !pin1.isBlank()) {
            session.setAttribute("errorMessage", "Die PIN darf nur aus Zahlen bestehen und muss bestätigt werden.");
            response.sendRedirect(request.getContextPath() + "/html/benutzerverwaltung.jsp");  
            return;
        } else if (pin2 != null && !pin2.isBlank() && pin1.isBlank()) {
            session.setAttribute("errorMessage", "Die PIN muss zur Bestätigung zweimal angegeben werden.");
            response.sendRedirect(request.getContextPath() + "/html/benutzerverwaltung.jsp");  
            return;
        }
        
        Part filePart = request.getPart("profilbild");
        InputStream fileContent = null;
        if (filePart != null && filePart.getSize() > 0) {
            if (filePart.getSize() > 1048576) {
                session.setAttribute("errorMessage", "Die Größe des Profilbildes überschreitet das zulässige Limit von 1 MB.");
                response.sendRedirect(request.getContextPath() + "/html/benutzerverwaltung.jsp");
                return; 
            }
            fileContent = filePart.getInputStream();
        }

        persist(benutzer, neuerPin, fileContent);

        response.sendRedirect(request.getContextPath() + "/html/benutzerverwaltung.jsp");
    }

    private boolean persist(Benutzer benutzer, Integer pin, InputStream fileContent) throws ServletException {
        StringBuilder sqlBuilder = new StringBuilder("UPDATE benutzer SET ");
        List<Object> params = new ArrayList<>();
        
        boolean hasUpdates = false;
        
        if (benutzer.getVorname() != null) {
            sqlBuilder.append("vorname = ?, ");
            params.add(benutzer.getVorname());
            hasUpdates = true;
        }
        if (benutzer.getNachname() != null) {
            sqlBuilder.append("nachname = ?, ");
            params.add(benutzer.getNachname());
            hasUpdates = true;
        }
        if (pin != null) {
            sqlBuilder.append("pin = ?, ");
            params.add(pin);
            hasUpdates = true;
        }
        if (fileContent != null) {
            sqlBuilder.append("profilbild = ?, ");
            params.add(fileContent);
            hasUpdates = true;
        }
        
        if (!hasUpdates) {
            return true; // Keine Änderungen zu speichern
        }
        
        // Remove the last ", " from the sqlBuilder
        sqlBuilder.setLength(sqlBuilder.length() - 2);
        sqlBuilder.append(" WHERE b_id = ?");
        
        String sql = sqlBuilder.toString();

        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            int paramIndex = 1;

            for (Object param : params) {
                if (param instanceof InputStream) {
                    pstmt.setBlob(paramIndex++, (InputStream) param);
                } else {
                    pstmt.setObject(paramIndex++, param);
                }
            }

            pstmt.setLong(paramIndex, benutzer.getB_id());

            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0; // Rückgabe true, wenn Update erfolgreich war
        } catch (SQLException ex) {
            throw new ServletException(ex.getMessage());
        }
    }
}
