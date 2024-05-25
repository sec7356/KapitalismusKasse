package edu.thi.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/UeberweisenServlet")
public class UeberweisenServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(UeberweisenServlet.class.getName());

    public UeberweisenServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String von = request.getParameter("von");
        String nach = request.getParameter("nach");
        String summeStr = request.getParameter("summe");

        try {
            BigDecimal summe = new BigDecimal(summeStr);
            if (summe.scale() > 2 || summe.precision() > 15) {
                throw new NumberFormatException("Invalid sum format");
            }

            if (!isValidIBAN(von) || !isValidIBAN(nach)) {
                throw new IllegalArgumentException("Invalid IBAN format");
            }

            if (von.equals(nach)) {
                throw new IllegalArgumentException("Source and destination accounts cannot be the same");
            }

            if (!isAccountExists(von) || !isAccountExists(nach)) {
                throw new IllegalArgumentException("One or both accounts do not exist");
            }

            if (!isBalanceSufficient(von, summe)) {
                // Kontostand ist nicht ausreichend, zeige eine Fehlermeldung an
                String errorMessage = "Die Überweisung konnte nicht durchgeführt werden, da der Kontostand des Absenderkontos nicht ausreicht.";
                request.setAttribute("errorMessage", errorMessage);
                request.setAttribute("showMessage", true); // Attribute, um die Popup-Nachricht anzuzeigen
            }


            performTransaction(von, nach, summe);

            response.sendRedirect("html/UserStartseite.jsp"); // Weiterleitung bei Erfolg
        } catch (NumberFormatException e) {
            logger.log(Level.SEVERE, "Error during money transfer", e);
            response.sendRedirect("html/fehlermeldungAllgemein.jsp"); // Weiterleitung bei Fehler
        } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    private boolean isValidIBAN(String iban) {
        // Implement logic to check IBAN syntax validity
        return true; // Placeholder, implement your logic here
    }

    private boolean isAccountExists(String iban) {
        // Implement logic to check if account exists in the database
        return true; // Placeholder, implement your logic here
    }

    private boolean isBalanceSufficient(String iban, BigDecimal amount) {
        // Implement logic to check if balance is sufficient for the transaction
        return true; // Placeholder, implement your logic here
    }

    private void performTransaction(String von, String nach, BigDecimal summe) throws SQLException {
        // Connect to the database
        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database", "username", "password")) {
            String insertQuery = "INSERT INTO Transaktion (von, nach, summe, zeitstempel) VALUES (?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(insertQuery)) {
                statement.setString(1, von);
                statement.setString(2, nach);
                statement.setBigDecimal(3, summe);
                statement.setTimestamp(4, Timestamp.valueOf(LocalDateTime.now()));
                statement.executeUpdate();
            }

            // Update account balances
            // Subtract amount from 'von' account
            String updateVonQuery = "UPDATE Konto SET Kontostand = Kontostand - ? WHERE IBAN = ?";
            try (PreparedStatement statement = connection.prepareStatement(updateVonQuery)) {
                statement.setBigDecimal(1, summe);
                statement.setString(2, von);
                statement.executeUpdate();
            }

            // Add amount to 'nach' account
            String updateNachQuery = "UPDATE Konto SET Kontostand = Kontostand + ? WHERE IBAN = ?";
            try (PreparedStatement statement = connection.prepareStatement(updateNachQuery)) {
                statement.setBigDecimal(1, summe);
                statement.setString(2, nach);
                statement.executeUpdate();
            }
        }
    }
}
