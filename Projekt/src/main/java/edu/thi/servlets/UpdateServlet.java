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
        benutzer.setVorname(request.getParameter("vorname"));
        benutzer.setNachname(request.getParameter("nachname"));
        benutzer.setEmail(request.getParameter("email"));
        
        // PINs prüfen
        String pin1 = request.getParameter("pin1");
        String pin2 = request.getParameter("pin2");

        if (!pin1.matches("\\d+") || !pin2.matches("\\d+")) {
            response.sendRedirect("html/fehlermeldungPIN.jsp");
            return;
        }

        if (!pin1.equals(pin2)) {
            response.sendRedirect("html/fehlermeldungPIN.jsp");
            return;
        }
        benutzer.setPin(Integer.valueOf(request.getParameter("pin1")));
        
        // Profilbild hochladen
        Part filePart = request.getPart("profilbild");
        InputStream fileContent = null;
        if (filePart != null && filePart.getSize() > 0) {
            fileContent = filePart.getInputStream();
        }
        
        // DB-Zugriff
        persist(benutzer, fileContent);
        
        // Setzen der Session-Attribute
        session.setAttribute("vorname", benutzer.getVorname());
        session.setAttribute("nachname", benutzer.getNachname());
                
        // Weiterleiten an JSP
        final RequestDispatcher dispatcher = request.getRequestDispatcher("html/UserStartseite.jsp");
        dispatcher.forward(request, response);    
    }

    private void persist(Benutzer benutzer, InputStream fileContent) throws ServletException {
        String sql = "UPDATE benutzer SET vorname = ?, nachname = ?, email = ?, pin = ?, profilBild = ? WHERE b_id = ?";
        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            
            pstmt.setString(1, benutzer.getVorname());
            pstmt.setString(2, benutzer.getNachname());
            pstmt.setString(3, benutzer.getEmail());
            pstmt.setInt(4, benutzer.getPin());
            if (fileContent != null) {
                pstmt.setBlob(5, fileContent);
            } else {
                pstmt.setNull(5, java.sql.Types.BLOB);
            }
            pstmt.setLong(6, benutzer.getB_id());
            pstmt.executeUpdate();
        } catch (Exception ex) {
            throw new ServletException(ex.getMessage());
        }
    }
}
