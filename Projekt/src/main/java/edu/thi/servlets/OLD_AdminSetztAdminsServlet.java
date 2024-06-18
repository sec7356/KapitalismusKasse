package edu.thi.servlets;

import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import edu.thi.java.Benutzer;

/**
 * Servlet implementation class AdminSetztAdminsServlet
 */
@WebServlet("/AdminSetztAdminsServlet")
public class OLD_AdminSetztAdminsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Resource(lookup="java:jboss/datasources/MySqlThidbDS")
	private DataSource ds;
	
    public OLD_AdminSetztAdminsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		Benutzer benutzer = new Benutzer();
		benutzer.setVorname(request.getParameter("vorname"));
		benutzer.setNachname(request.getParameter("nachname"));
		benutzer.setEmail(request.getParameter("email"));

		String adminParam = request.getParameter("admin");

		if (adminParam != null && adminParam.equals("on")) {
		    benutzer.setAdmin(true); // Checkbox wurde ausgewählt
		} else {
		    benutzer.setAdmin(false); // Checkbox wurde nicht ausgewählt
		}

		
		// DB-Zugriff
		persist(benutzer);
		request.setAttribute("benutzer", benutzer);
		
		// Weiterleiten an JSP
		final RequestDispatcher dispatcher = request.getRequestDispatcher("html/adminFormular.jsp");
		dispatcher.forward(request, response);	
		
	}

	private void persist(Benutzer benutzer) throws ServletException {
		// DB-Zugriff
		try (Connection con = ds.getConnection();
		     PreparedStatement pstmt = con.prepareStatement("UPDATE benutzer "
		     		                                      + "SET admin = ? "
		     		                                      + "WHERE vorname = ? AND nachname = ? AND email = ? ")) {
			
			pstmt.setBoolean(1, benutzer.isAdmin());
			pstmt.setString(2, benutzer.getVorname());
			pstmt.setString(3, benutzer.getNachname());
			pstmt.setString(4, benutzer.getEmail());
			pstmt.executeUpdate();
			
		} catch (Exception ex) {
			throw new ServletException(ex.getMessage());
		}
	}
	

}