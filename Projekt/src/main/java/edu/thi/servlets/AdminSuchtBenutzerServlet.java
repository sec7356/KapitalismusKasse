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
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import edu.thi.java.Benutzer;

/**
 * Servlet implementation class AdminSuchtBenutzer
 */
@WebServlet("/AdminSuchtBenutzerServlet")
public class AdminSuchtBenutzerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	@Resource(lookup="java:jboss/datasources/MySqlThidbDS")
	private DataSource ds;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminSuchtBenutzerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		request.setCharacterEncoding("UTF-8");	// In diesem Format erwartet das Servlet jetzt die Formulardaten
		String vorname = request.getParameter("vorname");
		String nachname = request.getParameter("nachname");
		
		List<Benutzer> benutzer = search(vorname, nachname);
		
		// Scope "Request"
		request.setAttribute("benutzer", benutzer);
				
		// Weiterleiten an JSP
		final RequestDispatcher dispatcher = request.getRequestDispatcher("html/ServletAusgabe.jsp");
		dispatcher.forward(request, response);
		
	}

	private List<Benutzer> search(String vorname, String nachname) throws ServletException {
		vorname = (vorname == null || vorname == "") ? "%" : "%" + vorname + "%";
		nachname = (nachname == null || nachname == "") ? "%" : "%" + nachname + "%";

		List<Benutzer> benutzerList = new ArrayList<Benutzer>();
		
		// DB-Zugriff
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement("SELECT * FROM products WHERE vorname LIKE ? AND nachname LIKE ?")) {

			pstmt.setString(1, vorname);
			pstmt.setString(2, nachname);

			try (ResultSet rs = pstmt.executeQuery()) {
			
				while (rs.next()) {
					Benutzer benutzer = new Benutzer();
					benutzer.setB_id(rs.getLong("b_id"));
					benutzer.setVorname(rs.getString("vorname"));
					benutzer.setNachname(rs.getString("nachname"));
					benutzer.setEmail(rs.getString("email"));
					benutzer.setAdmin(rs.getBoolean("admin"));
					
					benutzerList.add(benutzer);
				} // while rs.next()
			}
		} catch (Exception ex) {
			throw new ServletException(ex.getMessage());
		}
		
		return benutzerList;
	}

}
