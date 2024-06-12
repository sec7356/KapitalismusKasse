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

    @Resource(lookup = "java:jboss/datasources/MySqlThidbDS")
    private DataSource ds;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String pinStr = request.getParameter("pin");

        // Überprüfen, ob die E-Mail und die PIN korrekt eingegeben wurden
        if (email == null || email.isEmpty() || pinStr == null || !pinStr.matches("\\d+")) {
            request.setAttribute("errorMessage",
                    "Die E-Mail-Adresse und die PIN müssen korrekt eingegeben werden. Die PIN darf nur aus Zahlen bestehen.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/html/Banking-Login.jsp");
            dispatcher.forward(request, response);
            return;
        }

        int pin = Integer.parseInt(pinStr);

        // DB-Zugriff
        Benutzer benutzer = readBenutzer(email, pin);

        if (benutzer == null || benutzer.getB_id() == null) {
            // Benutzer nicht gefunden oder falsche Eingaben
            request.setAttribute("errorMessage", "Diese Angaben sind ungültig. Bitte korrigieren Sie Ihre Eingabe.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/html/Banking-Login.jsp");
            dispatcher.forward(request, response);
            return;
        }

        Konto konto = new Konto();
        long b_id = benutzer.getB_id();
        konto.setBesitzer(b_id);
        konto.setIBAN(getIBAN(b_id));
        konto.setKontoStand(getKontostand(b_id));
        konto.setDispoStand(getDispoStand(b_id));

        session.setAttribute("email", benutzer.getEmail());
        session.setAttribute("pin", benutzer.getPin());
        session.setAttribute("b_id", benutzer.getB_id());
        session.setAttribute("vorname", benutzer.getVorname());
        session.setAttribute("nachname", benutzer.getNachname());
        session.setAttribute("admin", benutzer.isAdmin());
        session.setAttribute("kontostand", konto.getKontoStand());
        session.setAttribute("IBAN", konto.getIBAN());
        session.setAttribute("dispo", konto.getDispoStand());
        
        // Formatieren der IBAN
        String formattedIban = formatIban(konto.getIBAN());
        session.setAttribute("formattedIban", formattedIban);

        // Umleitung basierend auf der E-Mail-Adresse und Admin-Status
        RequestDispatcher dispatcher;
        if ("admin@demo.org".equals(email) || benutzer.isAdmin()) {
            // Weiterleitung zum Admin-Servlet
            dispatcher = request.getRequestDispatcher("/AdminBenutzerListeServlet");  // Sicherstellen, dass das Mapping korrekt ist
        } else {
            dispatcher = request.getRequestDispatcher("/html/UserStartseite.jsp");
        }
        dispatcher.forward(request, response);
    }

    private Benutzer readBenutzer(String email, int pin) throws ServletException {
        Benutzer benutzer = null;

        // DB-Zugriff
        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement("SELECT * FROM Benutzer WHERE email = ? AND pin = ?")) {

            pstmt.setString(1, email);
            pstmt.setInt(2, pin);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs != null && rs.next()) {
                    benutzer = new Benutzer();
                    benutzer.setB_id(rs.getLong("b_id"));
                    benutzer.setVorname(rs.getString("vorname"));
                    benutzer.setNachname(rs.getString("nachname"));
                    benutzer.setEmail(rs.getString("email"));
                    benutzer.setPin(rs.getInt("pin"));
                    benutzer.setAdmin(rs.getBoolean("admin"));
                    benutzer.setProfilbild(rs.getBytes("profilBild"));

                    // Debugging-Ausgaben zur Überprüfung der Benutzerdaten aus der DB
                    System.out.println("DB b_id: " + rs.getLong("b_id"));
                    System.out.println("DB Vorname: " + rs.getString("vorname"));
                    System.out.println("DB Nachname: " + rs.getString("nachname"));
                    System.out.println("DB Email: " + rs.getString("email"));
                    System.out.println("DB Pin: " + rs.getInt("pin"));
                } else {
                    System.out.println("No user found with email: " + email + " and pin: " + pin);
                }
            }
        } catch (Exception ex) {
            throw new ServletException(ex.getMessage(), ex);
        }

        return benutzer;
    }

    // Die restlichen Methoden wurden beibehalten
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
            throw new ServletException(ex.getMessage(), ex);
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
            throw new ServletException(ex.getMessage(), ex);
        }

        return IBAN;
    }
    
    private double getDispoStand(long b_id) throws ServletException {
        double dispoStand = 0.0;

        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement("SELECT dispo FROM Konto WHERE besitzer = ?")) {
            pstmt.setLong(1, b_id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs != null && rs.next()) {
                    dispoStand = rs.getDouble("dispo");
                }
            }
        } catch (Exception ex) {
            throw new ServletException(ex.getMessage(), ex);
        }

        return dispoStand;
    }
    
    // Methode zur IBAN-Formatierung
    private String formatIban(String iban) {
        return iban.replaceAll("(.{4})(?!$)", "$1 ");
    }
}
