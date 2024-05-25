package edu.thi.servlets;

import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import edu.thi.java.Benutzer;

@WebServlet("/UpdateServlet")
public class UpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	@Resource(lookup="java:jboss/datasources/MySqlThidbDS")
	private DataSource ds;

    public UpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		
		Benutzer benutzer = new Benutzer();
		
		benutzer.setB_id((Long)session.getAttribute("b_id"));    
		
		benutzer.setVorname(request.getParameter("vorname"));
		benutzer.setNachname(request.getParameter("nachname"));
		benutzer.setEmail(request.getParameter("email"));
		
		//PINs prüfen
		String pin1 = request.getParameter("pin1");
		String pin2 = request.getParameter("pin2");

		// Überprüfen, ob mindestens einer der PINS nicht nur aus Zahlen besteht
		if (!pin1.matches("\\d+") || !pin2.matches("\\d+")) {
			// Wenn mindestens einer der PINS nicht nur aus Zahlen besteht
			// Weiterleitung zu einer Fehlerseite oder entsprechende Fehlerbehandlung
			response.sendRedirect("html/fehlermeldungPIN.jsp");
			return; // Beende die Methode
		}

		// Überprüfen, ob die PINS übereinstimmen
		if (!pin1.equals(pin2)) {
			// Wenn die PINS nicht übereinstimmen
			// Weiterleitung zu einer Fehlerseite oder entsprechende Fehlerbehandlung
			response.sendRedirect("html/fehlermeldungPIN.jsp");
			return; // Beende die Methode
		}
		benutzer.setPin(Integer.valueOf(request.getParameter("pin1")));
		
		// DB-Zugriff
		persist(benutzer);
				
		// Weiterleiten an JSP
		final RequestDispatcher dispatcher = request.getRequestDispatcher("html/UserStartseite.jsp");
		dispatcher.forward(request, response);	
		
	}

	private void persist(Benutzer benutzer) throws ServletException {
		// DB-Zugriff
		try (Connection con = ds.getConnection();
		     PreparedStatement pstmt = con.prepareStatement("UPDATE benutzer "
		     		                                      + "SET vorname = ?, nachname = ?, email = ?, pin "
		     		                                      + "WHERE b_id = ?")) {
			
			pstmt.setString(1, benutzer.getVorname());
			pstmt.setString(2, benutzer.getNachname());
			pstmt.setString(3, benutzer.getEmail());
			pstmt.setInt(4, benutzer.getPin());
			pstmt.setLong(5, benutzer.getB_id());
			pstmt.executeUpdate();
		} catch (Exception ex) {
			throw new ServletException(ex.getMessage());
		}
	}
	

}
