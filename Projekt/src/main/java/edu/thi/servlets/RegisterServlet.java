package edu.thi.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.sql.DataSource;

import edu.thi.java.Benutzer;
import edu.thi.java.IBANGenerator;
import edu.thi.java.Konto;
import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Resource(lookup = "java:jboss/datasources/MySqlThidbDS")
	private DataSource ds;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		request.setCharacterEncoding("UTF-8");

		Benutzer benutzer = new Benutzer();
		Konto konto = new Konto();

		// Benutzerregistrierungsinformationen aus dem Formular erhalten
		benutzer.setVorname(request.getParameter("vorname"));
		benutzer.setNachname(request.getParameter("nachname"));
		benutzer.setEmail(request.getParameter("email"));

		String pin1 = request.getParameter("pin1");
		String pin2 = request.getParameter("pin2");
		
		// Debugging-Ausgaben
	    System.out.println("Vorname: " + benutzer.getVorname());
	    System.out.println("Nachname: " + benutzer.getNachname());
	    System.out.println("Email: " + benutzer.getEmail());
	    System.out.println("Pin: " + benutzer.getPin());

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
		persistBenutzer(benutzer, response);
		persistKonto(benutzer, response);
		
		long b_id = benutzer.getB_id();
		konto.setIBAN(getIBAN(b_id));
		konto.setKontoStand(getKontostand(b_id));

		session.setAttribute("email", benutzer.getEmail());
		session.setAttribute("pin", benutzer.getPin());
		session.setAttribute("b_id", benutzer.getB_id());
		session.setAttribute("vorname", benutzer.getVorname());
		session.setAttribute("nachname", benutzer.getNachname());
		session.setAttribute("kontostand", konto.getKontoStand());
		session.setAttribute("IBAN", konto.getIBAN());
		
		// Weiterleiten an JSP
		final RequestDispatcher dispatcher = request.getRequestDispatcher("html/UserStartseite.jsp"); 
		
		// Debugging-Ausgaben
	    System.out.println("Vorname: " + benutzer.getVorname());
	    System.out.println("Nachname: " + benutzer.getNachname());
	    System.out.println("Email: " + benutzer.getEmail());
	    System.out.println("Pin: " + benutzer.getPin());
		
		
		dispatcher.forward(request, response);
		
		
	}

	private void persistBenutzer(Benutzer benutzer, HttpServletResponse response) throws ServletException {
		// DB-Zugriff
		String[] generatedKeys = new String[] { "b_id" }; // Name der Spalte(n), die automatisch generiert wird(werden)		
		
		try (Connection con = ds.getConnection();
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
	
	private void persistKonto(Benutzer benutzer, HttpServletResponse response) throws ServletException {
		// DB-Zugriff
				String IBAN = IBANGenerator.generateIBAN();;
				
				try (Connection con = ds.getConnection();
						PreparedStatement pstmt = con.prepareStatement(
								"INSERT INTO Konto (IBAN,besitzer,kontoStand) VALUES (?,?,?)")) {
					pstmt.setString(1, IBAN);
					pstmt.setLong(2, benutzer.getB_id());
					pstmt.setDouble(3, 100);
					
					pstmt.executeUpdate();
				} catch (Exception ex) {
					throw new ServletException(ex.getMessage());
				}
	}
	
	private double getKontostand(long b_id) throws ServletException {
	    double kontostand = 0.0;

	    try (Connection con = ds.getConnection();
	         PreparedStatement pstmt = con.prepareStatement("SELECT kontoStand FROM Konto WHERE besitzer = ?")) {
	        pstmt.setLong(1, b_id);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs != null && rs.next()) {
	                kontostand = rs.getDouble("kontoStand");
	            }
	        }
	    } catch (Exception ex) {
	        throw new ServletException(ex.getMessage());
	    }

	    return kontostand;
	}

	private String getIBAN(long b_id) throws ServletException {
	    String IBAN = "";

	    try (Connection con = ds.getConnection();
	         PreparedStatement pstmt = con.prepareStatement("SELECT IBAN FROM Konto WHERE besitzer = ?")) {
	        pstmt.setLong(1, b_id);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs != null && rs.next()) {
	            	IBAN = rs.getString("IBAN");
	            }
	        }
	    } catch (Exception ex) {
	        throw new ServletException(ex.getMessage());
	    }

	    return IBAN;
	}
	
	
}
