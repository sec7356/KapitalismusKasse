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

@WebServlet("/LoeschenServlet")
public class LoeschenServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Resource(lookup="java:jboss/datasources/MySqlThidbDS")
	private DataSource ds;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Servlet zur Entgegennahme von Formularinhalten, Löschen der Daten in einer DB und Generierung
		// eines Feldes zur Weitergabe an eine JSP
		request.setCharacterEncoding("UTF-8");	// In diesem Format erwartet das Servlet jetzt die Formulardaten
		Long id = Long.valueOf(request.getParameter("id"));
		
		// DB-Zugriff
		delete(id);
				
		// Scope "Request"
		request.setAttribute("id", id);
		
		// Weiterleiten an JSP
		final RequestDispatcher dispatcher = request.getRequestDispatcher("html/ServletAusgabe.jsp");   //so korrekt?
		dispatcher.forward(request, response);	
	}
	
	private void delete(Long id) throws ServletException {
		// DB-Zugriff
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement("DELETE FROM Benutzer WHERE id = ?")){
			pstmt.setLong(1, id);
			pstmt.executeUpdate();
		} catch (Exception ex) {
			throw new ServletException(ex.getMessage());
		}
	}
}
