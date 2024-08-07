//Autor: @Diane, @Selim, @Can

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

        // Namensprüfung
        String vorname = request.getParameter("vorname");
        String nachname = request.getParameter("nachname");
        if (vorname == null || !vorname.matches("[a-zA-ZäöüÄÖÜß]+")) {
            session.setAttribute("errorMessage", "Der Vorname darf nur aus Buchstaben bestehen.");
            response.sendRedirect(request.getContextPath() + "/html/Registrierung.jsp");
            return;
        }
        if (nachname == null || !nachname.matches("[a-zA-ZäöüÄÖÜß]+")) {
            session.setAttribute("errorMessage", "Der Nachname darf nur aus Buchstaben bestehen.");
            response.sendRedirect(request.getContextPath() + "/html/Registrierung.jsp");
            return;
        }

        // Emailprüfung
        String email = request.getParameter("email");
        if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            session.setAttribute("errorMessage", "Bitte geben Sie eine gültige E-Mail-Adresse ein.");
            response.sendRedirect(request.getContextPath() + "/html/Registrierung.jsp");
            return;
        }

        // PIN-prüfung
        String pin1 = request.getParameter("pin1");
        String pin2 = request.getParameter("pin2");

        if (!pin1.matches("\\d+") || !pin2.matches("\\d+")) {
            session.setAttribute("errorMessage", "Die PIN darf nur aus Zahlen bestehen.");
            response.sendRedirect(request.getContextPath() + "/html/Registrierung.jsp");
            return;
        }

        // Überprüfen, ob die PINS übereinstimmen
        if (!pin1.equals(pin2)) {
            session.setAttribute("errorMessage", "Die Eingaben müssen übereinstimmen.");
            response.sendRedirect(request.getContextPath() + "/html/Registrierung.jsp");
            return;
        }

        // Benutzerregistrierungsinformationen aus dem Formular erhalten
        benutzer.setVorname(vorname);
        benutzer.setNachname(nachname);
        benutzer.setEmail(email);
        benutzer.setAdmin(false);
        benutzer.setPin(Integer.valueOf(pin1));

        // DB-Zugriff
        try {
            persistBenutzer(benutzer, response);
            erstelleKonto(benutzer, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }

        long b_id = benutzer.getB_id();
        konto.setIBAN(getIBAN(b_id));
        konto.setKontoStand(getKontostand(b_id));

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

        // PRG-Pattern anwenden
        response.sendRedirect(request.getContextPath() + "/html/UserStartseite.jsp");
    }

    private void persistBenutzer(Benutzer benutzer, HttpServletResponse response) throws ServletException {
        // DB-Zugriff
        String[] generatedKeys = new String[] { "b_id" }; // Name der Spalte(n), die automatisch generiert wird(werden)

        try (Connection con = ds.getConnection()) {
            // Überprüfen, ob E-Mail bereits im System registriert, bevor es in DB
            // geschrieben wird
            try (PreparedStatement statementCheckEmail = con
                    .prepareStatement("SELECT 1 FROM Benutzer WHERE email = ?")) {
                statementCheckEmail.setString(1, benutzer.getEmail());
                try (ResultSet resultSetCheckEmail = statementCheckEmail.executeQuery()) {
                    if (resultSetCheckEmail.next()) {
                        response.sendRedirect("html/fehlermeldungEmail.jsp");
                        return;
                    }
                }
            }

            // Registrierungs Infos von Benutzer-Bean in die DB schreiben
            try (PreparedStatement pstmt = con.prepareStatement(
                    "INSERT INTO Benutzer (vorname, nachname, email, pin, admin) VALUES (?,?,?,?,?)", generatedKeys)) {
                // Zugriff über Klasse java.sql.PreparedStatement
                pstmt.setString(1, benutzer.getVorname());
                pstmt.setString(2, benutzer.getNachname());
                pstmt.setString(3, benutzer.getEmail());
                pstmt.setInt(4, benutzer.getPin());
                pstmt.setBoolean(5, benutzer.isAdmin());

                pstmt.executeUpdate();

                // Generierte(n) Schlüssel auslesen (funktioniert nur mit PreparedStatement)
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        benutzer.setB_id(rs.getLong(1));
                    }
                }
            }
        } catch (Exception ex) {
            throw new ServletException(ex.getMessage());
        }
    }

    private void erstelleKonto(Benutzer benutzer, HttpServletResponse response) throws ServletException {
        // DB-Zugriff
        String IBAN;
        boolean isUnique = false;

        try (Connection con = ds.getConnection()) {
            while (!isUnique) {
                IBAN = IBANGenerator.generateIBAN();

                // Prüfen, ob die IBAN bereits in der Tabelle 'Konto' vorhanden ist
                try (PreparedStatement checkStmt = con.prepareStatement("SELECT COUNT(*) FROM Konto WHERE IBAN = ?")) {
                    checkStmt.setString(1, IBAN);
                    try (ResultSet rs = checkStmt.executeQuery()) {
                        if (rs.next() && rs.getInt(1) == 0) {
                            isUnique = true;
                        }
                    }
                }

                // Wenn die IBAN eindeutig ist, Konto erstellen
                if (isUnique) {
                    try (PreparedStatement pstmt = con
                            .prepareStatement("INSERT INTO Konto (IBAN, besitzer, kontoStand) VALUES (?,?,?)")) {
                        pstmt.setString(1, IBAN);
                        pstmt.setLong(2, benutzer.getB_id());
                        pstmt.setDouble(3, 100);

                        pstmt.executeUpdate();
                    }
                }
            }
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

    // Methode zur IBAN-Formatierung
    private String formatIban(String iban) {
        return iban.replaceAll("(.{4})(?!$)", "$1 ");
    }
}
