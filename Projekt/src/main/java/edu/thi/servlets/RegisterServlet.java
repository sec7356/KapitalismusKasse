package edu.thi.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.sql.DataSource;

import edu.thi.java.Benutzer;
import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Resource(lookup = "java:jboss/datasources/MySqlThidbDS")
	private DataSource ds;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		Benutzer benutzer = new Benutzer();

		// Benutzerregistrierungsinformationen aus dem Formular erhalten
		benutzer.setVorname(request.getParameter("vorname"));
		benutzer.setNachname(request.getParameter("nachname"));
		benutzer.setEmail(request.getParameter("email"));
		
		// Überprüfen, ob die E-Mail bereits im System registriert ist
	    
	    
	    

		
		

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
		persist(benutzer, response);

		// Scope "Request"
		request.setAttribute("benutzer", benutzer); // wofür der String anfangs?

		// Weiterleiten an JSP
		final RequestDispatcher dispatcher = request.getRequestDispatcher("html/UserStartseite.jsp"); // so korrekt?
		dispatcher.forward(request, response);
	}

	private void persist(Benutzer benutzer, HttpServletResponse response) throws ServletException {
		// DB-Zugriff
		String[] generatedKeys = new String[] { "b_id" }; // Name der Spalte(n), die automatisch generiert wird(werden)		
		
		try (Connection con = ds.getConnection();
				/* final Statement stmt = con.createStatement() */
				PreparedStatement pstmt = con.prepareStatement(
						"INSERT INTO Benutzer (vorname,nachname,email,pin) VALUES (?,?,?,?)", generatedKeys)) {

			// Zugriff über Klasse java.sql.PreparedStatement
			pstmt.setString(1, benutzer.getVorname());
			pstmt.setString(2, benutzer.getNachname());
			pstmt.setString(3, benutzer.getEmail());
			pstmt.setInt(4, benutzer.getPin());
			
			
			// Überprüfen, ob E-Mail bereits im System registriert, bevor es in DB geschrieben wird
		    PreparedStatement statementCheckEmail = con.prepareStatement(
		    		"SELECT 1 FROM Benutzer WHERE email = ?");
		    statementCheckEmail.setString(1, benutzer.getEmail());
		    ResultSet resultSetCheckEmail = statementCheckEmail.executeQuery();
		    boolean isEmail = resultSetCheckEmail.next();

		    if (isEmail) {
		    	response.sendRedirect("html/fehlermeldungEmail.jsp");
				return; // Beende die Methode
		    }
			
			pstmt.executeUpdate();

			// Generierte(n) Schlüssel auslesen (funktioniert nur mit PreparedStatement)
			try (ResultSet rs = pstmt.getGeneratedKeys()) {
				while (rs.next()) {
					benutzer.setB_id(rs.getLong(1));
				}
			}
		} catch (Exception ex) {
			throw new ServletException(ex.getMessage());
		}
	}
}
