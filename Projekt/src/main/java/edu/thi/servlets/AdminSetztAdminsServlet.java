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
public class AdminSetztAdminsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Resource(lookup="java:jboss/datasources/MySqlThidbDS")
	private DataSource ds;
	
    public AdminSetztAdminsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		Benutzer benutzer = new Benutzer();
		benutzer.setB_id(Long.valueOf(request.getParameter("id")));
		benutzer.setVorname(request.getParameter("vorname"));
		benutzer.setNachname(request.getParameter("nachname"));
		benutzer.setEmail(request.getParameter("email"));
		
		// DB-Zugriff
		persist(benutzer);
		request.setAttribute("benutzer", benutzer);
		
		// Weiterleiten an JSP
		final RequestDispatcher dispatcher = request.getRequestDispatcher("html/ServletAusgabe.jsp");
		dispatcher.forward(request, response);	
		
	}

	private void persist(Benutzer benutzer) throws ServletException {
		// DB-Zugriff
		try (Connection con = ds.getConnection();
		     PreparedStatement pstmt = con.prepareStatement("UPDATE benutzer "
		     		                                      + "SET admin = ? "
		     		                                      + "WHERE vorname = ?, nachname = ?, email = ? ")) {
			
			
			pstmt.setString(1, benutzer.getVorname());
			pstmt.setString(2, benutzer.getNachname());
			pstmt.setString(3, benutzer.getEmail());
			pstmt.setLong(4, benutzer.getB_id());
			pstmt.executeUpdate();
		} catch (Exception ex) {
			throw new ServletException(ex.getMessage());
		}
	}
	

}
