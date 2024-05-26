package edu.thi.servlets;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.sql.DataSource;
import edu.thi.java.Benutzer;



@WebServlet("/UpdateServlet")
@MultipartConfig
public class UpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Resource(lookup = "java:jboss/datasources/MySqlThidbDS")
    private DataSource ds;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        
        // Abrufen der Vornamen und Nachnamen aus der vorherigen Sitzung
        String vorname = (String) session.getAttribute("vorname");
        String nachname = (String) session.getAttribute("nachname");
        
        Benutzer benutzer = new Benutzer();
        
        benutzer.setB_id((Long) session.getAttribute("b_id"));
        
        // Setzen des Vornamens und Nachnamens
        benutzer.setVorname(vorname);
        benutzer.setNachname(nachname);
        
        // Aktualisieren der Vornamen und Nachnamen, wenn sie im Formular geändert wurden
        String neuerVorname = request.getParameter("vorname");
        if (neuerVorname != null && !neuerVorname.isEmpty()) {
            benutzer.setVorname(neuerVorname);
            session.setAttribute("vorname", neuerVorname); // Aktualisieren der Sitzungsattribut
        }
        
        String neuerNachname = request.getParameter("nachname");
        if (neuerNachname != null && !neuerNachname.isEmpty()) {
            benutzer.setNachname(neuerNachname);
            session.setAttribute("nachname", neuerNachname); // Aktualisieren der Sitzungsattribut
        }
        
        benutzer.setEmail(request.getParameter("email"));
        
        // PINs prüfen und setzen
        String pin1 = request.getParameter("pin1");
        String pin2 = request.getParameter("pin2");

        if (pin1 != null && pin2 != null && pin1.matches("\\d{6}") && pin1.equals(pin2)) {
            benutzer.setPin(Integer.parseInt(pin1));
        } else {
            // Fehlerbehandlung für ungültige PINs, falls erforderlich
        }
        
     // Profilbild hochladen
        Part filePart = request.getPart("profilbild");
        InputStream fileContent = null;
        if (filePart != null && filePart.getSize() > 0) {
            fileContent = filePart.getInputStream();
        }

        // DB-Zugriff nur wenn ein Profilbild hochgeladen wurde
        if (fileContent != null) {
            persist(benutzer, fileContent);
        }
        
        // Weiterleitung zur Benutzerseite, um das aktualisierte Profilbild anzuzeigen
        response.sendRedirect(request.getContextPath() + "/html/UserStartseite.jsp");
    }


    private void persist(Benutzer benutzer, InputStream fileContent) throws ServletException {
        // SQL-Anweisung zum Aktualisieren des Profilbilds
        String sql = "UPDATE benutzer SET profilbild = ?";
        // Überprüfen, ob Vorname und Nachname geändert wurden
        boolean hasNameUpdates = false;
        if (benutzer.getVorname() != null && !benutzer.getVorname().isEmpty()) {
            sql += ", vorname = ?";
            hasNameUpdates = true;
        }
        if (benutzer.getNachname() != null && !benutzer.getNachname().isEmpty()) {
            sql += ", nachname = ?";
            hasNameUpdates = true;
        }
        // Wenn keine Änderungen an Vorname und Nachname vorgenommen wurden,
        // wird das Update nur für das Profilbild durchgeführt
        sql += " WHERE b_id = ?";
        
        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            // Setze das Profilbild
            pstmt.setBlob(1, fileContent);
            int paramIndex = 2;

            // Setze den Wert von Vorname und Nachname, wenn sie geändert wurden
            if (hasNameUpdates) {
                if (benutzer.getVorname() != null && !benutzer.getVorname().isEmpty()) {
                    pstmt.setString(paramIndex++, benutzer.getVorname());
                }
                if (benutzer.getNachname() != null && !benutzer.getNachname().isEmpty()) {
                    pstmt.setString(paramIndex++, benutzer.getNachname());
                }
            }

            // Setze den Wert von b_id
            pstmt.setLong(paramIndex, benutzer.getB_id());

            pstmt.executeUpdate();
        } catch (Exception ex) {
            throw new ServletException(ex.getMessage());
        }
    }
}
