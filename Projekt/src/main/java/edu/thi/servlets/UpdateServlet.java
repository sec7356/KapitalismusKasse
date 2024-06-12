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
        
        String vorname = (String) session.getAttribute("vorname");
        String nachname = (String) session.getAttribute("nachname");
        String email = (String) session.getAttribute("email");
        boolean isAdmin = (boolean) session.getAttribute("admin");
        
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

        // Debugging-Ausgaben hinzufügen
        System.out.println("Vorname: " + benutzer.getVorname());
        System.out.println("Nachname: " + benutzer.getNachname());
        System.out.println("Email: " + benutzer.getEmail());
        System.out.println("PIN1: " + pin1);
        System.out.println("PIN2: " + pin2);
        System.out.println("PIN: " + pin);

        
        
        Part filePart = request.getPart("profilbild");
        InputStream fileContent = null;
        if (filePart != null && filePart.getSize() > 0) {
            fileContent = filePart.getInputStream();
        }

        persist(benutzer, pin, fileContent);

        if (!isAdmin) {
            response.sendRedirect(request.getContextPath() + "/html/UserStartseite.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/AdminBenutzerListeServlet");
        }
    }

    private void persist(Benutzer benutzer, Integer pin, InputStream fileContent) throws ServletException {
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

            
            // Debugging-Ausgaben hinzufügen
            System.out.println("SQL: " + sql);
            System.out.println("Vorname: " + benutzer.getVorname());
            System.out.println("Nachname: " + benutzer.getNachname());
            System.out.println("Email: " + benutzer.getEmail());
            
            if (pin != null) {
                pstmt.setInt(paramIndex++, pin);
            }

            if (fileContent != null) {
                pstmt.setBlob(paramIndex++, fileContent);
            }

            pstmt.setLong(paramIndex, benutzer.getB_id());

            pstmt.executeUpdate();
        } catch (Exception ex) {
            throw new ServletException(ex.getMessage());
        }
    }
}
