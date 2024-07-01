// Autor: Diane

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
        session.removeAttribute("error"); // Fehlermeldung zurücksetzen
        
        String vorname = (String) session.getAttribute("vorname");
        String nachname = (String) session.getAttribute("nachname");
        String email = (String) session.getAttribute("email");
        
        Benutzer benutzer = new Benutzer();
        benutzer.setB_id((Long) session.getAttribute("b_id"));
        benutzer.setVorname(vorname);
        benutzer.setNachname(nachname);
        benutzer.setEmail(email);
        
        String neuerVorname = request.getParameter("vorname");
        if (neuerVorname != null && !neuerVorname.isEmpty()) {
            benutzer.setVorname(neuerVorname);
            session.setAttribute("vorname", neuerVorname);
        }
        
        String neuerNachname = request.getParameter("nachname");
        if (neuerNachname != null && !neuerNachname.isEmpty()) {
            benutzer.setNachname(neuerNachname);
            session.setAttribute("nachname", neuerNachname);
        }
        
        String pin1 = request.getParameter("pin1");
        String pin2 = request.getParameter("pin2");

        Integer pin = null;
        if (pin1 != null && pin2 != null && pin1.equals(pin2) && pin1.matches("\\d+")) {
            pin = Integer.parseInt(pin1);
        }
        
        Part filePart = request.getPart("profilbild");
        InputStream fileContent = null;
        if (filePart != null && filePart.getSize() > 0) {
            fileContent = filePart.getInputStream();
        }

        boolean updateSuccessful = persist(benutzer, pin, fileContent);

        if (!updateSuccessful) {
            session.setAttribute("error", "Die Größe des Profilbildes überschreitet das zulässige Limit von 1 MB.");
            response.sendRedirect(request.getContextPath() + "/html/benutzerverwaltung.jsp");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/html/UserStartseite.jsp");
    }

    private boolean persist(Benutzer benutzer, Integer pin, InputStream fileContent) throws ServletException {
        StringBuilder sqlBuilder = new StringBuilder("UPDATE benutzer SET vorname = ?, nachname = ?, email = ?");
        if (pin != null) {
            sqlBuilder.append(", pin = ?");
        }
        if (fileContent != null) {
            sqlBuilder.append(", profilbild = ?");
        }
        sqlBuilder.append(" WHERE b_id = ?");
        
        String sql = sqlBuilder.toString();

        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            int paramIndex = 1;

            pstmt.setString(paramIndex++, benutzer.getVorname());
            pstmt.setString(paramIndex++, benutzer.getNachname());
            pstmt.setString(paramIndex++, benutzer.getEmail());

            if (pin != null) {
                pstmt.setInt(paramIndex++, pin);
            }

            if (fileContent != null) {
                // Überprüfen, ob das Bild größer als 1.048.576 Bytes ist (entspricht 1 MB)
                if (fileContent.available() > 1048576 ) {
                    return false; 
                }
                pstmt.setBlob(paramIndex++, fileContent);
            }

            pstmt.setLong(paramIndex, benutzer.getB_id());

            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0; // Rückgabe true, wenn Update erfolgreich war
        } catch (SQLException | IOException ex) {
            throw new ServletException(ex.getMessage());
        }
    }
}
