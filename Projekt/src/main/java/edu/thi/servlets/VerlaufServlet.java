package edu.thi.servlets;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import javax.sql.DataSource;


//Stiehl Skript mehrere Einträge Suchen-Servlet mit While schleife, hier implementieren

@WebServlet("/VerlaufServlet")
public class VerlaufServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Resource(lookup="java:jboss/datasources/MySqlThidbDS")
    private DataSource ds;

    public VerlaufServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
       
        
    }

}
