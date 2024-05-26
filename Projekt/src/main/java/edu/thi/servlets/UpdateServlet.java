package edu.thi.servlets;

import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
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

    public UpdateServlet() {
        super();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        
        Benutzer benutzer = new Benutzer();
        
        benutzer.setB_id((Long) session.getAttribute("b_id"));
        
        // Profilbild hochladen
        Part filePart = request.getPart("profilbild");
        InputStream fileContent = null;
        if (filePart != null && filePart.getSize() > 0) {
            fileContent = filePart.getInputStream();
        }
        
        // DB-Zugriff
        persist(benutzer, fileContent);
        
        // Weiterleiten an JSP
        final RequestDispatcher dispatcher = request.getRequestDispatcher("html/UserStartseite.jsp");
        dispatcher.forward(request, response);    
    }



    private void persist(Benutzer benutzer, InputStream fileContent) throws ServletException {
        String sql = "UPDATE benutzer SET ";
        boolean first = true;

        if (benutzer.getVorname() != null) {
            sql += "vorname = ?";
            first = false;
        }
        if (benutzer.getNachname() != null) {
            if (!first) sql += ", ";
            sql += "nachname = ?";
            first = false;
        }

        if (fileContent != null) {
            if (!first) sql += ", ";
            sql += "profilbild = ?";
        }

        sql += " WHERE b_id = ?";
        
        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            
            int paramIndex = 1;

            if (benutzer.getVorname() != null) {
                pstmt.setString(paramIndex++, benutzer.getVorname());
            }
            if (benutzer.getNachname() != null) {
                pstmt.setString(paramIndex++, benutzer.getNachname());
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
