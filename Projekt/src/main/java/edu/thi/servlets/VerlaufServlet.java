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
import java.util.List;

import javax.sql.DataSource;

@WebServlet("/VerlaufServlet")
public class VerlaufServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Resource(lookup = "java:jboss/datasources/MySqlThidbDS")
    private DataSource ds;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	   	
        HttpSession session = request.getSession();
        String iban = (String) session.getAttribute("IBAN");

        List<Transaktion> transaktionen = new ArrayList<>();

        try (Connection con = ds.getConnection()) {
            String sql = "SELECT t_id, von, nach, summe, zeitstempel FROM transaktion WHERE von = ?";
            try (PreparedStatement pstmt = con.prepareStatement(sql)) {
                pstmt.setString(1, iban);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        Transaktion transaktion = new Transaktion();
                        transaktion.setT_id(rs.getLong("t_id"));
                        transaktion.setVon(rs.getString("von"));
                        transaktion.setNach(rs.getString("nach"));
                        transaktion.setSumme(rs.getDouble("summe"));
                        transaktion.setZeitstempel(rs.getTimestamp("zeitstempel"));
                        transaktionen.add(transaktion);
                    }
                }
            }
        } catch (Exception ex) {
            throw new ServletException(ex.getMessage());
        }

        request.setAttribute("transaktionen", transaktionen);
        request.getRequestDispatcher("html/verlauf.jsp").forward(request, response);
    }
}