package edu.thi.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.sql.DataSource;

import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoeschenServlet")
public class LoeschenServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Resource(lookup="java:jboss/datasources/MySqlThidbDS")
	private DataSource ds;
	
	/*protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("html/fehlermeldungAllgemein.jsp").forward(request, response);
	}*/
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Servlet zur Entgegennahme von Formularinhalten, Löschen der Daten in einer DB und Generierung
		// eines Feldes zur Weitergabe an eine JSP
		request.setCharacterEncoding("UTF-8");	// In diesem Format erwartet das Servlet jetzt die Formulardaten
		
		HttpSession session = request.getSession();
		Long id = (Long)session.getAttribute("b_id");
		
		// DB-Zugriff
		deleteKonto(id);
		deleteBenutzer(id);
				
		// Weiterleiten an JSP
		final RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");  
		dispatcher.forward(request, response);	
	}
	
	private void deleteKonto(Long id) throws ServletException {
		// DB-Zugriff
		try(Connection con = ds.getConnection();
		         PreparedStatement selectStmt = con.prepareStatement("SELECT kontostand FROM Konto WHERE besitzer = ?");
		         PreparedStatement deleteStmt = con.prepareStatement("DELETE FROM Konto WHERE besitzer = ?")) {
			
			// Den Kontostand abfragen
			selectStmt.setLong(1, id);
			ResultSet resultSet = selectStmt.executeQuery();
			
			if(resultSet.next()) {
				double kontoStand = resultSet.getDouble("kontoStand");
				
				// Überprüfen, ob der Kontostand größer als 0 ist
				if(kontoStand > 0) {
					// Kontostand ist größer als 0, Konto kann nicht gelöscht werden
					throw new ServletException("Das Konto kann nicht gelöscht werden, da der Kontostand größer als 0 ist.");
				}
				else if(kontoStand < 0) {
					throw new ServletException("Das Konto kann nicht gelöscht werden, da Sie momentan im Disporahmen sind. Begleichen sie ihre Schulden!");
				}
				else {
					deleteStmt.setLong(1,  id);
					deleteStmt.executeUpdate();
				}
			}
		} catch (Exception ex) {
			throw new ServletException(ex.getMessage());
		}
	}
	private void deleteBenutzer(Long id) throws ServletException {
		// DB-Zugriff
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement("DELETE FROM Benutzer WHERE b_id = ?")){
			pstmt.setLong(1, id);
			pstmt.executeUpdate();
		} catch (Exception ex) {
			throw new ServletException(ex.getMessage());
		}
	}
	
}
