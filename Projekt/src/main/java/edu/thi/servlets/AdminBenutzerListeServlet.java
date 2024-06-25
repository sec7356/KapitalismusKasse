//Autor: 

package edu.thi.servlets;

import edu.thi.java.Benutzer;
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
import java.util.List;

import javax.sql.DataSource;

@WebServlet("/AdminBenutzerListeServlet")
public class AdminBenutzerListeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Resource(lookup = "java:jboss/datasources/MySqlThidbDS")
    private DataSource ds;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("vorname") == null &&
            request.getParameter("nachname") == null &&
            request.getParameter("email") == null) {
            ladeAlleEintraege(request, response);
        } else {
            doSearch(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ladeAlleEintraege(request, response);
    }

    private void ladeAlleEintraege(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Benutzer> konten = new ArrayList<>();

        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement("SELECT * FROM benutzer");
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Benutzer benutzer = new Benutzer();
                benutzer.setB_id(rs.getLong("b_id"));
                benutzer.setVorname(rs.getString("vorname"));
                benutzer.setNachname(rs.getString("nachname"));
                benutzer.setEmail(rs.getString("email"));
                benutzer.setPin(rs.getInt("pin"));
                benutzer.setAdmin(rs.getBoolean("admin"));

                konten.add(benutzer);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new ServletException("Datenbankfehler: " + ex.getMessage());
        }

        request.setAttribute("konten", konten);

        request.getRequestDispatcher("/html/adminFormular.jsp").forward(request, response);
    }

    private void doSearch(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vorname = request.getParameter("vorname");
        String nachname = request.getParameter("nachname");
        String email = request.getParameter("email");

        List<Benutzer> konten = new ArrayList<>();

        try (Connection con = ds.getConnection()) {
            StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM benutzer WHERE 1 = 1");

            if (vorname != null && !vorname.isEmpty()) {
                sqlBuilder.append(" AND vorname LIKE ?");
            }

            if (nachname != null && !nachname.isEmpty()) {
                sqlBuilder.append(" AND nachname LIKE ?");
            }

            if (email != null && !email.isEmpty()) {
                sqlBuilder.append(" AND email LIKE ?");
            }

            try (PreparedStatement pstmt = con.prepareStatement(sqlBuilder.toString())) {
                int parameterIndex = 1;
                if (vorname != null && !vorname.isEmpty()) {
                    pstmt.setString(parameterIndex++, "%" + vorname + "%");
                }
                if (nachname != null && !nachname.isEmpty()) {
                    pstmt.setString(parameterIndex++, "%" + nachname + "%");
                }
                if (email != null && !email.isEmpty()) {
                    pstmt.setString(parameterIndex++, "%" + email + "%");
                }

                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        Benutzer benutzer = new Benutzer();
                        benutzer.setB_id(rs.getLong("b_id"));
                        benutzer.setVorname(rs.getString("vorname"));
                        benutzer.setNachname(rs.getString("nachname"));
                        benutzer.setEmail(rs.getString("email"));
                        benutzer.setPin(rs.getInt("pin"));
                        benutzer.setAdmin(rs.getBoolean("admin"));

                        konten.add(benutzer);
                    }
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new ServletException("Datenbankfehler: " + ex.getMessage());
        }

        request.setAttribute("konten", konten);
        request.getRequestDispatcher("/html/adminFormular.jsp").forward(request, response);
    }
}
