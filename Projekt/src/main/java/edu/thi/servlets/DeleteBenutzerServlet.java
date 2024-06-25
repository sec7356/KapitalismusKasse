//Autor: Diane

package edu.thi.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.sql.DataSource;

import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteBenutzerServlet")
public class DeleteBenutzerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Resource(lookup = "java:jboss/datasources/MySqlThidbDS")
    private DataSource ds;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        Long id = Long.parseLong(request.getParameter("b_id"));

        	deleteTransaktion(id);
            deleteKonto(id);
            deleteBenutzer(id);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/AdminBenutzerListeServlet");
        dispatcher.forward(request, response);
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
    
    private void deleteTransaktion(Long id) throws ServletException {
        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(
                     "DELETE FROM Transaktion WHERE von IN (SELECT IBAN FROM Konto WHERE besitzer = ?)")) {
            
            pstmt.setLong(1, id);
            pstmt.executeUpdate();
            
        } catch (Exception ex) {
            throw new ServletException(ex.getMessage());
        }
    }

	
}
