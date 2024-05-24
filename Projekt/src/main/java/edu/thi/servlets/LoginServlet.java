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
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Resource(lookup="java:jboss/datasources/MySqlThidbDS")
	private DataSource ds;

    /*protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.getRequestDispatcher("html/fehlermeldungAllgemein.jsp").forward(request, response);
    }*/
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
    	
    	request.setCharacterEncoding("UTF-8");	
		
    	String email = request.getParameter("email");
    	int pin = Integer.valueOf(request.getParameter("pin"));
		
		// DB-Zugriff
		Benutzer benutzer = read(email, pin);
		
		
		session.setAttribute("email", benutzer.getEmail());
		session.setAttribute("pin", benutzer.getEmail());
		session.setAttribute("b_id", benutzer.getB_id());
		session.setAttribute("vorname", benutzer.getVorname());
		session.setAttribute("nachname", benutzer.getNachname());
				
		final RequestDispatcher dispatcher = request.getRequestDispatcher("html/UserStartseite.jsp");  
			
     	dispatcher.forward(request, response); 
    }
    
    private Benutzer read(String email, int pin) throws ServletException {
    	Benutzer benutzer = new Benutzer();
		benutzer.setEmail(email);
		benutzer.setPin(pin);

		// DB-Zugriff
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement("SELECT * FROM Benutzer WHERE email = ? AND pin = ?")) {

			pstmt.setString(1, email);
			pstmt.setInt(2, pin);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs != null && rs.next()) {
					benutzer.setB_id(rs.getLong("b_id"));
					benutzer.setVorname(rs.getString("vorname"));
					benutzer.setNachname(rs.getString("nachname"));
					benutzer.setEmail(rs.getString("email"));
					benutzer.setPin(Integer.valueOf(rs.getString("pin")));
				}
			}
		} catch (Exception ex) {
			throw new ServletException(ex.getMessage());
		}
		
		return benutzer;
	}
}
