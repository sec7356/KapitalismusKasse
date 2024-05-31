package edu.thi.servlets;
import java.io.IOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.sql.DataSource;

import edu.thi.java.Benutzer;
import edu.thi.java.Konto;
import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Resource(lookup="java:jboss/datasources/MySqlThidbDS")
	private DataSource ds;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
    	
    	request.setCharacterEncoding("UTF-8");	
		
    	String email = request.getParameter("email");
    	String pinStr = request.getParameter("pin");
    	
    	// Überprüfen, ob die PIN nur aus Zahlen besteht
        if (!pinStr.matches("\\d+")) {
            request.setAttribute("errorMessage", "Die PIN darf nur aus Zahlen bestehen. Bitte korrigieren Sie Ihre Eingabe.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("html/Banking-Login.jsp");
            dispatcher.forward(request, response);
            return;
        }
    	
        int pin = Integer.parseInt(pinStr);

    	// Debugging-Ausgaben
        System.out.println("Email from form: " + email);
        System.out.println("PIN from form: " + pin);
        
		
		// DB-Zugriff
		Benutzer benutzer = readBenutzer(email, pin);
		
        if (benutzer == null || benutzer.getB_id() == null) {
            // Benutzer nicht gefunden oder falsche Eingaben
            request.setAttribute("errorMessage", "Diese Angaben sind ungültig. Bitte korrigieren Sie Ihre Eingabe.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("html/Banking-Login.jsp");
            dispatcher.forward(request, response);
            return;
        }
		
		
		Konto konto = new Konto();
		
		long b_id = benutzer.getB_id();
		
		konto.setBesitzer(b_id);
		konto.setIBAN(getIBAN(b_id));
		konto.setKontoStand(getKontostand(b_id));
		
		// Debugging-Ausgaben
	    System.out.println("Vorname: " + benutzer.getVorname());
	    System.out.println("Nachname: " + benutzer.getNachname());
	    System.out.println("Email: " + benutzer.getEmail());
	    System.out.println("Pin: " + benutzer.getPin());
		
		session.setAttribute("email", benutzer.getEmail());
		session.setAttribute("pin", benutzer.getPin());
		session.setAttribute("b_id", benutzer.getB_id());
		session.setAttribute("vorname", benutzer.getVorname());
		session.setAttribute("nachname", benutzer.getNachname());
		session.setAttribute("admin", benutzer.isAdmin());

		session.setAttribute("kontostand", konto.getKontoStand());
		session.setAttribute("IBAN", konto.getIBAN());
				
		// Umleitung basierend auf der E-Mail-Adresse
        if (email.equals("admin.admin@demo.org")|| benutzer.isAdmin() == true) {
            final RequestDispatcher dispatcher = request.getRequestDispatcher("html/adminFormular.jsp");  
            dispatcher.forward(request, response);
        } else {
            final RequestDispatcher dispatcher = request.getRequestDispatcher("html/UserStartseite.jsp");  
            dispatcher.forward(request, response);
        } 
    }
    
    private Benutzer readBenutzer(String email, int pin) throws ServletException {
        Benutzer benutzer = new Benutzer();
        benutzer.setEmail(email);
        benutzer.setPin(pin);

        // DB-Zugriff
        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement("SELECT * FROM benutzer WHERE email = ? AND pin = ?")) {

            pstmt.setString(1, email);
            pstmt.setInt(2, pin);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs != null && rs.next()) {
                    benutzer.setB_id(rs.getLong("b_id"));
                    benutzer.setVorname(rs.getString("vorname"));
                    benutzer.setNachname(rs.getString("nachname"));
                    benutzer.setEmail(rs.getString("email"));
                    benutzer.setPin(rs.getInt("pin")); 
                    benutzer.setAdmin(rs.getBoolean("admin"));
                    benutzer.setProfilbild(rs.getBytes("profilBild"));

                    // Debugging-Ausgaben
                    System.out.println("DB b_id: " + rs.getString("b_id"));
                    System.out.println("DB Vorname: " + rs.getString("vorname"));
                    System.out.println("DB Nachname: " + rs.getString("nachname"));
                    System.out.println("DB Email: " + rs.getString("email"));
                    System.out.println("DB Pin: " + rs.getInt("pin"));
                } else {
                    System.out.println("No user found with email: " + email + " and pin: " + pin);
                }
            }
        } catch (Exception ex) {
            throw new ServletException(ex.getMessage());
        }
        
        return benutzer;
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
