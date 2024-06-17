package edu.thi.servlets;

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

import edu.thi.java.Benutzer;
import edu.thi.java.Konto;
import edu.thi.java.Transaktion;

@WebServlet("/BenutzerDetailsServlet/*")
public class BenutzerDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Resource(lookup = "java:jboss/datasources/MySqlThidbDS")
    private DataSource ds;
       
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String benutzer_id = request.getParameter("b_id");

        if (benutzer_id == null) {
            response.getWriter().write("Fehler: Keine b_id angegeben");
            return;
        }

        System.out.println("BenutzerDetailsServlet.doGet() aufgerufen mit b_id: " + benutzer_id);

        List<Konto> konto = getKonto(benutzer_id);
        List<Benutzer> benutzer = getBenutzer(benutzer_id);
        List<Transaktion> transaktionen = getTransaktionen(benutzer_id);

        request.setAttribute("kontoinformationen", konto);
        request.setAttribute("benutzerinformationen", benutzer);
        request.setAttribute("transaktionen", transaktionen);

        System.out.println("Weiterleiten an BenutzerInformationen.jsp mit allen Informationen.");
        request.getRequestDispatcher("html/benutzerInformationen.jsp").forward(request, response);
    }

    private List<Benutzer> getBenutzer(String b_id) throws ServletException {
        List<Benutzer> benutzer = new ArrayList<>();

        try (Connection con = ds.getConnection()) {
            String sql = "SELECT vorname, nachname, email, pin, admin, profilBild FROM Benutzer WHERE b_id = ?";
            System.out.println("SQL-Abfrage für Benutzer: " + sql);

            try (PreparedStatement pstmt = con.prepareStatement(sql)) {
                pstmt.setString(1, b_id);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        Benutzer benutzerinformationen = new Benutzer();
                        benutzerinformationen.setEmail(rs.getString("email"));
                        benutzerinformationen.setVorname(rs.getString("vorname"));
                        benutzerinformationen.setNachname(rs.getString("nachname"));
                        benutzerinformationen.setPin(rs.getInt("pin"));
                        benutzerinformationen.setAdmin(rs.getBoolean("admin"));

                        benutzer.add(benutzerinformationen);
                        System.out.println("Benutzerinformationen abgerufen: " + benutzerinformationen);
                    }
                }
            }
        } catch (Exception ex) {
            System.err.println("Fehler beim Abrufen der Benutzerinformationen: " + ex.getMessage());
            throw new ServletException(ex.getMessage());
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
                        System.out.println("Kontoinformationen abgerufen: " + kontoinformationen);
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
            System.out.println("SQL-Abfrage für Transaktion: " + sql);

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
                        System.out.println("Transaktionsinformationen abgerufen: " + transaktion);
                    }
                }
            }
        } catch (Exception ex) {
            System.err.println("Fehler beim Abrufen der Transaktionsinformationen: " + ex.getMessage());
            throw new ServletException(ex.getMessage());
        }

        // Transaktionen nach Zeitstempel sortieren (neuestes zuerst)
        Collections.sort(transaktionen, Comparator.comparing(Transaktion::getZeitstempel).reversed());
        System.out.println("Transaktionen nach Zeitstempel sortiert: " + transaktionen);

        return transaktionen;
    }


}
