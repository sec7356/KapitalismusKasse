//Autor: 

package edu.thi.servlets;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.sql.DataSource;


@WebServlet("/DisplayImageServlet")
public class DisplayImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
	@Resource(lookup = "java:jboss/datasources/MySqlThidbDS")
    private DataSource ds;

    public DisplayImageServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long b_id = (Long) request.getSession().getAttribute("b_id");
        if (b_id == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No user ID found in session");
            return;
        }

        String sql = "SELECT profilbild FROM benutzer WHERE b_id = ?";
        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setLong(1, b_id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // Überprüfe, ob das Blob nicht null ist
                    if (rs.getBlob("profilbild") != null) {
                        InputStream inputStream = rs.getBlob("profilbild").getBinaryStream();
                        response.setContentType("image/jpeg");
                        OutputStream outputStream = response.getOutputStream();

                        byte[] buffer = new byte[1024];
                        int bytesRead = -1;
                        while ((bytesRead = inputStream.read(buffer)) != -1) {
                            outputStream.write(buffer, 0, bytesRead);
                        }
                        inputStream.close();
                        outputStream.close();
                    } else {
                        // Wenn das Blob null ist, sende eine benutzerdefinierte Fehlermeldung
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "No profile picture found for the user");
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
                }
            }
        } catch (Exception ex) {
            throw new ServletException(ex.getMessage());
        }
    }

}
