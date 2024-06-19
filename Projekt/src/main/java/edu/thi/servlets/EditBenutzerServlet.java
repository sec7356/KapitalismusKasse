package edu.thi.servlets;

import edu.thi.java.Benutzer;
import edu.thi.java.Konto;
import edu.thi.java.Transaktion;
import jakarta.annotation.Resource;
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
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import javax.sql.DataSource;

@WebServlet("/EditBenutzerServlet")
public class EditBenutzerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Resource(lookup = "java:jboss/datasources/MySqlThidbDS")
    private DataSource ds;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String benutzer_id = request.getParameter("b_id");
        Benutzer benutzer = getBenutzerDetails(benutzer_id);

        if (benutzer != null) {
            List<Konto> konto = getKonto(benutzer_id);
            List<Transaktion> transaktionen = getTransaktionen(benutzer_id);

            request.setAttribute("benutzer", benutzer); 
            request.setAttribute("kontoinformationen", konto);
            request.setAttribute("transaktionen", transaktionen);

            request.getRequestDispatcher("/html/editBenutzer.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Benutzer nicht gefunden");
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String benutzerId = request.getParameter("b_id");
        String vorname = request.getParameter("vorname");
        String nachname = request.getParameter("nachname");
        String email = request.getParameter("email");
        String pin = request.getParameter("pin");
        String admin = request.getParameter("admin");

        Benutzer currentBenutzer = getBenutzerDetails(benutzerId);

        if (currentBenutzer == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Benutzer nicht gefunden");
            return;
        }

        // Prüfen und aktualisieren nur der geänderten Felder
        boolean isUpdated = false;
        if (vorname != null && !vorname.isEmpty() && !vorname.equals(currentBenutzer.getVorname())) {
            currentBenutzer.setVorname(vorname);
            isUpdated = true;
        }
        if (nachname != null && !nachname.isEmpty() && !nachname.equals(currentBenutzer.getNachname())) {
            currentBenutzer.setNachname(nachname);
            isUpdated = true;
        }
        if (email != null && !email.isEmpty() && !email.equals(currentBenutzer.getEmail())) {
            currentBenutzer.setEmail(email);
            isUpdated = true;
        }
        if (pin != null && !pin.isEmpty()) {
            try {
                int pinValue = Integer.parseInt(pin);
                if (pinValue != currentBenutzer.getPin()) {
                    currentBenutzer.setPin(pinValue);
                    isUpdated = true;
                }
            } catch (NumberFormatException ex) {
                ex.printStackTrace();
                throw new ServletException("Ungültiger PIN-Wert: " + ex.getMessage());
            }
        }
        if (admin != null && !admin.isEmpty()) {
            try {
                boolean adminValue = Boolean.parseBoolean(admin);
                if (adminValue != currentBenutzer.isAdmin()) {
                    currentBenutzer.setAdmin(adminValue);
                    isUpdated = true;
                }
            } catch (Exception ex) {
                ex.printStackTrace();
                throw new ServletException("Ungültiger Admin-Wert: " + ex.getMessage());
            }
        }

        // Nur aktualisieren, wenn tatsächlich Änderungen vorgenommen wurden
        if (isUpdated) {
            updateBenutzer(currentBenutzer);

            request.setAttribute("message", "Benutzer erfolgreich aktualisiert.");
        } else {
            request.setAttribute("message", "Keine Änderungen vorgenommen.");
        }

        request.getRequestDispatcher("/BenutzerDetailsServlet?b_id=" + benutzerId).forward(request, response);
    }

    private Benutzer getBenutzerDetails(String b_id) throws ServletException {
        Benutzer benutzer = null;

        try (Connection con = ds.getConnection()) {
            String selectSQL = "SELECT * FROM benutzer WHERE b_id = ?";
            try (PreparedStatement pstmt = con.prepareStatement(selectSQL)) {
                pstmt.setLong(1, Long.parseLong(b_id));
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        benutzer = new Benutzer();
                        benutzer.setB_id(rs.getLong("b_id"));
                        benutzer.setVorname(rs.getString("vorname"));
                        benutzer.setNachname(rs.getString("nachname"));
                        benutzer.setEmail(rs.getString("email"));
                        benutzer.setPin(rs.getInt("pin"));
                        benutzer.setAdmin(rs.getBoolean("admin"));
                    }
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new ServletException("Datenbankfehler: " + ex.getMessage());
        }

        return benutzer;
    }

    private void updateBenutzer(Benutzer benutzer) throws ServletException {
        try (Connection con = ds.getConnection()) {
            String updateSQL = "UPDATE benutzer SET vorname = ?, nachname = ?, email = ?, pin = ?, admin = ? WHERE b_id = ?";
            try (PreparedStatement pstmt = con.prepareStatement(updateSQL)) {
                pstmt.setString(1, benutzer.getVorname());
                pstmt.setString(2, benutzer.getNachname());
                pstmt.setString(3, benutzer.getEmail());
                pstmt.setInt(4, benutzer.getPin());
                pstmt.setBoolean(5, benutzer.isAdmin());
                pstmt.setLong(6, benutzer.getB_id());

                pstmt.executeUpdate();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new ServletException("Datenbankfehler: " + ex.getMessage());
        }
    }


    private List<Konto> getKonto(String b_id) throws ServletException {
        List<Konto> konto = new ArrayList<>();

        try (Connection con = ds.getConnection()) {
            String sql = "SELECT IBAN, kontoStand, Dispo FROM Konto WHERE besitzer = ?";
            System.out.println("SQL-Abfrage für Konto: " + sql);

            try (PreparedStatement pstmt = con.prepareStatement(sql)) {
                pstmt.setString(1, b_id);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        Konto kontoinformationen = new Konto();
                        kontoinformationen.setIBAN(rs.getString("IBAN"));
                        kontoinformationen.setKontoStand(rs.getDouble("kontoStand"));
                        kontoinformationen.setDispoStand(rs.getDouble("Dispo"));

                        konto.add(kontoinformationen);
                    }
                }
            }
        } catch (Exception ex) {
            System.err.println("Fehler beim Abrufen der Kontoinformationen: " + ex.getMessage());
            throw new ServletException(ex.getMessage());
        }

        return konto;
    }

    private List<Transaktion> getTransaktionen(String b_id) throws ServletException {
        List<Transaktion> transaktionen = new ArrayList<>();

        try (Connection con = ds.getConnection()) {
            String sql = "SELECT t.t_id, t.von, t.nach, t.summe, t.verzweck, t.zeitstempel, " +
                         "sender.vorname AS sender_vorname, sender.nachname AS sender_nachname, " +
                         "empfaenger.vorname AS empfaenger_vorname, empfaenger.nachname AS empfaenger_nachname " +
                         "FROM transaktion t " +
                         "JOIN konto sender_konto ON t.von = sender_konto.IBAN " +
                         "JOIN benutzer sender ON sender_konto.Besitzer = sender.b_id " +
                         "JOIN konto empfaenger_konto ON t.nach = empfaenger_konto.IBAN " +
                         "JOIN benutzer empfaenger ON empfaenger_konto.Besitzer = empfaenger.b_id " +
                         "WHERE sender.b_id = ? OR empfaenger.b_id = ?";

            try (PreparedStatement pstmt = con.prepareStatement(sql)) {
                pstmt.setString(1, b_id);
                pstmt.setString(2, b_id);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        Transaktion transaktion = new Transaktion();
                        transaktion.setT_id(rs.getInt("t_id"));
                        transaktion.setVon(rs.getString("von"));
                        transaktion.setNach(rs.getString("nach"));
                        transaktion.setSumme(rs.getDouble("summe"));
                        transaktion.setZeitstempel(rs.getTimestamp("zeitstempel"));
                        transaktion.setVerzweck(rs.getString("verzweck"));
                        transaktion.setSenderVorname(rs.getString("sender_vorname"));
                        transaktion.setSenderNachname(rs.getString("sender_nachname"));
                        transaktion.setEmpfaengerVorname(rs.getString("empfaenger_vorname"));
                        transaktion.setEmpfaengerNachname(rs.getString("empfaenger_nachname"));

                        transaktionen.add(transaktion);
                    }
                }
            }
        } catch (Exception ex) {
            System.err.println("Fehler beim Abrufen der Transaktionsinformationen: " + ex.getMessage());
            throw new ServletException(ex.getMessage());
        }

        // Transaktionen nach Zeitstempel sortieren (neuestes zuerst)
        Collections.sort(transaktionen, Comparator.comparing(Transaktion::getZeitstempel).reversed());

        return transaktionen;
    }
}
