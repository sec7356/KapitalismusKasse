//Autor: Can

package edu.thi.servlets;

import edu.thi.java.Konto;
import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.io.IOException;
import javax.sql.DataSource;

@WebServlet("/UeberweisenServlet")
public class UeberweisenServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Resource(lookup = "java:jboss/datasources/MySqlThidbDS")
	private DataSource dataSource;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("UTF-8");

	    HttpSession session = request.getSession();
	    String vonIBAN = request.getParameter("von");
	    String nachIBAN = request.getParameter("nach");
	    String summeStr = request.getParameter("summe");
	    String verzweck = request.getParameter("verwendungszweck");

	    double summe = Double.parseDouble(summeStr);

	    Connection conn = null;

	    try {
	        conn = dataSource.getConnection();
	        conn.setAutoCommit(false);

	        // Kontostand und Dispo abfragen
	        Konto kontoInfo = getKontoInfo(conn, vonIBAN);
	        double vonKontostand = kontoInfo.getKontoStand();
	        double dispo = kontoInfo.getDispoStand();

	        System.out.println("Kontostand: " + kontoInfo.getKontoStand());
	        System.out.println("Dispo: " + dispo);


	        if (vonKontostand + dispo < summe) {
	            session.setAttribute("error", "Das verfügbare Guthaben und der Dispositionsrahmen sind für die Durchführung der Überweisung unzureichend.");
	            response.sendRedirect(request.getContextPath() + "/html/Ueberweisungen.jsp");
	            return;
	        }

	        // Betrag vom 'von'-Konto abziehen
	        updateKontostand(conn, vonIBAN, vonKontostand - summe);

	        // Betrag zum 'nach'-Konto hinzufügen
	        double nachKontostand = getKontostand(conn, nachIBAN);
	        updateKontostand(conn, nachIBAN, nachKontostand + summe);

	        // Transaktion in der DB speichern
	        speichereTransaktion(conn, vonIBAN, nachIBAN, summe, verzweck);

	        conn.commit();

	        double neuerVonKontostand = getKontostand(conn, vonIBAN);
	        session.setAttribute("kontostand", neuerVonKontostand);

	        response.sendRedirect("html/UeberweisungTeil3.jsp");

	    } catch (SQLException e) {
	        e.printStackTrace();
	        if (conn != null) {
	            try {
	                conn.rollback();
	            } catch (SQLException se) {
	                se.printStackTrace();
	            }
	        }
	        session.setAttribute("errorMessage", "Fehler bei der Überweisung");
	        response.sendRedirect("html/Ueberweisungen.jsp");
	    } finally {
	        if (conn != null) {
	            try {
	                conn.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }
	}


	private Konto getKontoInfo(Connection conn, String iban) throws SQLException {
		String query = "SELECT kontostand, dispo FROM konto WHERE IBAN = ?";
		try (PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setString(1, iban);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					return new Konto(iban, 0, "", rs.getDouble("kontostand"), rs.getDouble("dispo"));
				} else {
					throw new SQLException("Konto nicht gefunden: " + iban);
				}
			}
		}
	}

	private double getKontostand(Connection conn, String iban) throws SQLException {
		String query = "SELECT kontostand FROM konto WHERE IBAN = ?";
		try (PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setString(1, iban);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					return rs.getDouble("kontostand");
				} else {
					throw new SQLException("Konto nicht gefunden: " + iban);
				}
			}
		}
	}

	private void updateKontostand(Connection conn, String iban, double neuerKontostand) throws SQLException {
		String update = "UPDATE konto SET kontostand = ? WHERE IBAN = ?";
		try (PreparedStatement stmt = conn.prepareStatement(update)) {
			stmt.setDouble(1, neuerKontostand);
			stmt.setString(2, iban);
			stmt.executeUpdate();
		}
	}

	private void speichereTransaktion(Connection conn, String vonIBAN, String nachIBAN, double summe, String verzweck)
			throws SQLException {
		String insert = "INSERT INTO transaktion (von, nach, summe, zeitstempel, verzweck) VALUES (?, ?, ?, CURRENT_TIMESTAMP, ?)";
		try (PreparedStatement stmt = conn.prepareStatement(insert)) {
			stmt.setString(1, vonIBAN);
			stmt.setString(2, nachIBAN);
			stmt.setDouble(3, summe);
			stmt.setString(4, verzweck);
			stmt.executeUpdate();
		}
	}

}
