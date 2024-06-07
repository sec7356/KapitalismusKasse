package edu.thi.servlets;

import edu.thi.java.Transaktion;
import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.sql.DataSource;

@WebServlet("/VerlaufServlet")
public class VerlaufServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Resource(lookup = "java:jboss/datasources/MySqlThidbDS")
    private DataSource ds;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String iban = (String) session.getAttribute("IBAN");

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
                         "WHERE t.von = ? OR t.nach = ?";

            try (PreparedStatement pstmt = con.prepareStatement(sql)) {
                pstmt.setString(1, iban);
                pstmt.setString(2, iban);
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
            throw new ServletException(ex.getMessage());
        }

        Collections.sort(transaktionen, Comparator.comparing(Transaktion::getZeitstempel).reversed());

        request.setAttribute("transaktionen", transaktionen);
        request.getRequestDispatcher("html/verlauf.jsp").forward(request, response);
    }
}
