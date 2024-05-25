package edu.thi.servlets;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDateTime;

import javax.sql.DataSource;

import edu.thi.java.Transaktion;

@WebServlet("/UeberweisenServlet")
public class UeberweisenServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Resource(lookup="java:jboss/datasources/MySqlThidbDS")
    private DataSource ds;

    public UeberweisenServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
       
        Transaktion transaktion = new Transaktion();
               
        String von = request.getParameter("von");
        String nach = request.getParameter("nach");
        String summeStr = request.getParameter("summe");
        
        try {
            BigDecimal summe = new BigDecimal(summeStr);
            if (summe.scale() > 2 || summe.precision() > 15) {
                // Falsches Format der Summe
                String errorMessage = "Die Überweisung konnte nicht durchgeführt werden, da die Summe nicht korrekt angegeben wurde.";
                request.setAttribute("errorMessage", errorMessage);
                request.setAttribute("showMessage", true); // Attribute, um die Popup-Nachricht anzuzeigen
            }
                        
            if (!isValidIBAN(von) || !isValidIBAN(nach)) {
                // Falsches Format der IBAN
                String errorMessage = "Die Überweisung konnte nicht durchgeführt werden, da die IBAN nicht korrekt angegeben wurde.";
                request.setAttribute("errorMessage", errorMessage);
                request.setAttribute("showMessage", true); // Attribute, um die Popup-Nachricht anzuzeigen
            }

            if (von.equals(nach)) {
                // Falsches Format der Summe
                String errorMessage = "Die Überweisung konnte nicht durchgeführt werden, da die beiden IBAN die selben sind.";
                request.setAttribute("errorMessage", errorMessage);
                request.setAttribute("showMessage", true); // Attribute, um die Popup-Nachricht anzuzeigen
            }

            if (!AccountExists(von)) {
                // Falsches Format der Summe
                String errorMessage = "Die Überweisung konnte nicht durchgeführt werden, da das \"Von\" Konto nicht existiert.";
                request.setAttribute("errorMessage", errorMessage);
                request.setAttribute("showMessage", true); // Attribute, um die Popup-Nachricht anzuzeigen
            }
            
            if (!AccountExists(nach)) {
                // Falsches Format der Summe
                String errorMessage = "Die Überweisung konnte nicht durchgeführt werden, da das \"Nach\" Konto nicht existiert.";
                request.setAttribute("errorMessage", errorMessage);
                request.setAttribute("showMessage", true); // Attribute, um die Popup-Nachricht anzuzeigen
            }

            if (!isBalanceSufficient(von, summe)) {
                // Kontostand ist nicht ausreichend, zeige eine Fehlermeldung an
                String errorMessage = "Die Überweisung konnte nicht durchgeführt werden, da der Kontostand des Absenderkontos nicht ausreicht.";
                request.setAttribute("errorMessage", errorMessage);
                request.setAttribute("showMessage", true); // Attribute, um die Popup-Nachricht anzuzeigen
            }
            
            transaktion.setVon(request.getParameter("von"));
            transaktion.setNach(request.getParameter("nach"));
            transaktion.setSumme(Double.valueOf(request.getParameter("summe")));

            performTransaction(transaktion, response);

            response.sendRedirect("html/UserStartseite.jsp"); // Weiterleitung bei Erfolg
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("html/fehlermeldungAllgemein.jsp"); // Weiterleitung bei Fehler
        } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    private boolean isValidIBAN(String iban) {
        // Entfernen von Leerzeichen und Sonderzeichen
        iban = iban.replaceAll("\\s", "");

        // Überprüfen der Länge (mindestens 4 Zeichen)
        if (iban.length() < 4) {
            return false;
        }

        // Überprüfen, ob die ersten beiden Zeichen Buchstaben sind
        for (int i = 0; i < 2; i++) {
            if (!Character.isLetter(iban.charAt(i))) {
                return false;
            }
        }

        // Überprüfen, ob die restlichen Zeichen Ziffern oder Buchstaben sind
        for (int i = 2; i < iban.length(); i++) {
            if (!Character.isLetterOrDigit(iban.charAt(i))) {
                return false;
            }
        }

        return true;
    }


    private boolean AccountExists(String iban) throws SQLException {
        // DB-Zugriff
        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement("SELECT * FROM Konto WHERE iban = ?")) {

            pstmt.setString(1, iban);
            ResultSet rs = pstmt.executeQuery();

            // Wenn ein Ergebnis gefunden wurde, gibt es einen Eintrag mit dieser IBAN
            return rs.next();
            
        }
    }

    private boolean isBalanceSufficient(String iban, BigDecimal summe) throws SQLException {
        // DB-Zugriff
        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement("SELECT kontoStand FROM Konto WHERE iban = ?")) {

            pstmt.setString(1, iban);
            ResultSet rs = pstmt.executeQuery();

            // Wenn ein Ergebnis gefunden wurde
            if (rs.next()) {
                BigDecimal kontostand = rs.getBigDecimal("kontoStand");
                // Überprüfen, ob der Kontostand mindestens gleich der Summe ist
                return kontostand.compareTo(summe) >= 0;
            } else {
                // Wenn kein Ergebnis gefunden wurde, ist der Kontostand nicht ausreichend
                return false;
            }
        }
    }



    private void performTransaction(Transaktion transaktion, HttpServletResponse response) throws ServletException, SQLException {
    	// DB-Zugriff
	    String[] generatedKeys = new String[] { "t_id" }; // Name der Spalte(n), die automatisch generiert wird(werden)    
	    
    	// Connect to the database
        try (Connection con = ds.getConnection()) {
        	String insertQuery = "INSERT INTO Transaktion (von, nach, summe, zeitstempel) VALUES (?, ?, ?, ?)";
            try (PreparedStatement pstmt = con.prepareStatement(insertQuery, generatedKeys)) {
                pstmt.setString(1, transaktion.getVon());
        		pstmt.setString(2, transaktion.getNach());
        		pstmt.setDouble(3, transaktion.getSumme());
        		pstmt.setTimestamp(4, Timestamp.valueOf(LocalDateTime.now()));
        		
        		pstmt.executeUpdate();
        		
        		// Generierte(n) Schlüssel auslesen (funktioniert nur mit PreparedStatement)
	            try (ResultSet rs = pstmt.getGeneratedKeys()) {
	                if (rs.next()) {
	                    transaktion.setT_id(rs.getLong(1));
	                }
	            }
            }

            // Update account balances
            // Subtract amount from 'von' account
            String updateVonQuery = "UPDATE Konto SET Kontostand = Kontostand - ? WHERE IBAN = ?";
            try (PreparedStatement pstmt = con.prepareStatement(updateVonQuery)) {
            	pstmt.setDouble(1, transaktion.getSumme());
            	pstmt.setString(2, transaktion.getVon());
            	pstmt.executeUpdate();
            }

            // Add amount to 'nach' account
            String updateNachQuery = "UPDATE Konto SET Kontostand = Kontostand + ? WHERE IBAN = ?";
            try (PreparedStatement pstmt = con.prepareStatement(updateNachQuery)) {
            	pstmt.setDouble(1, transaktion.getSumme());
            	pstmt.setString(2, transaktion.getNach());
            	pstmt.executeUpdate();
            }
        }
    }
}
