//Autor: Diane

package edu.thi.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

@WebServlet("/CheckEmailAvailability")
public class CheckEmailAvailabilityServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Resource(lookup = "java:jboss/datasources/MySqlThidbDS")
    private DataSource ds;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        
//     // E-Mail Format prüfen
//        if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
//            out.println("{\"available\": false, \"message\": \"Bitte geben Sie eine gültige E-Mail-Adresse ein.\"}");
//            return;
//        }
        
        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement("SELECT 1 FROM Benutzer WHERE email = ?")) {
            pstmt.setString(1, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // E-Mail ist bereits registriert
                    out.println("{\"available\": false}");
                } else {
                    // E-Mail ist verfügbar
                    out.println("{\"available\": true}");
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.println("{\"error\": \"" + ex.getMessage() + "\"}");
        }
    }
}
