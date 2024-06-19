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

@WebServlet("/EditKontoServlet")
public class EditKontoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Resource(lookup = "java:jboss/datasources/MySqlThidbDS")
    private DataSource ds;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String benutzer_id = request.getParameter("b_id");
        List<Konto> konto = getKonto(benutzer_id);  // Hier werden die Kontoinformationen abgerufen

        if (!konto.isEmpty()) {  // Überprüfen, ob Kontoinformationen vorhanden sind
            Benutzer benutzer = getBenutzerDetails(benutzer_id);
            List<Transaktion> transaktionen = getTransaktionen(benutzer_id);

            request.setAttribute("benutzer", benutzer);
            request.setAttribute("konto", konto.get(0));  // Nehmen wir an, es gibt nur ein Konto pro Benutzer
            request.setAttribute("transaktionen", transaktionen);

            request.getRequestDispatcher("/html/editKonto.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Kontoinformationen nicht gefunden");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String benutzerId = request.getParameter("b_id");

        // Eingaben aus dem Formular lesen
        String kontoStandStr = request.getParameter("kontoStand");
        String dispoStr = request.getParameter("dispoStand");
        String iban = request.getParameter("iban");

        // Aktuelle Kontodaten abrufen
        List<Konto> kontoList = getKonto(benutzerId);
        if (kontoList.isEmpty()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Kontoinformationen nicht gefunden");
            return;
        }
        Konto konto = kontoList.get(0);

        // Überprüfen, ob Eingaben gemacht wurden und diese nur dann aktualisieren
        if (kontoStandStr != null && !kontoStandStr.isEmpty() && dispoStr != null && !dispoStr.isEmpty()) {
            try {
                double kontoStand = Double.parseDouble(kontoStandStr);
                double dispo = Double.parseDouble(dispoStr);

                if (kontoStand != konto.getKontoStand() || dispo != konto.getDispoStand()) {
                    updateKonto(iban, kontoStand, dispo);
                    request.setAttribute("message", "Kontodaten erfolgreich aktualisiert.");
                } else {
                    request.setAttribute("message", "Keine Änderungen vorgenommen.");
                }
            } catch (NumberFormatException ex) {
                ex.printStackTrace();
                request.setAttribute("error", "Ungültige Eingabe für Kontostand oder Disporahmen.");
            }
        } else {
            request.setAttribute("error", "Fehlende Eingaben für Kontodaten.");
        }

        // Benutzer- und Transaktionsdaten wie zuvor abrufen und anzeigen
        Benutzer benutzer = getBenutzerDetails(benutzerId);
        List<Transaktion> transaktionen = getTransaktionen(benutzerId);

        request.setAttribute("benutzer", benutzer);
        request.setAttribute("konto", konto);
        request.setAttribute("transaktionen", transaktionen);

        request.getRequestDispatcher("/BenutzerDetailsServlet?b_id=" + benutzerId).forward(request, response);
    }

    private void updateKonto(String iban, double kontoStand, double dispo) throws ServletException {
        try (Connection con = ds.getConnection()) {
            String updateSQL = "UPDATE Konto SET kontoStand = ?, Dispo = ? WHERE IBAN = ?";
            try (PreparedStatement pstmt = con.prepareStatement(updateSQL)) {
                pstmt.setDouble(1, kontoStand);
                pstmt.setDouble(2, dispo);
                pstmt.setString(3, iban);

                pstmt.executeUpdate();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new ServletException("Datenbankfehler: " + ex.getMessage());
        }
    }

    private Benutzer getBenutzerDetails(String b_id) throws ServletException {
        Benutzer benutzer = null;
        System.out.println("b_id aus Funktion:" + b_id);

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
