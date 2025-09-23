package com.petweb.servlet;

import com.petweb.database.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/test-db")
public class TestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<html><head><title>Database Test</title></head><body>");
        out.println("<h1>Database Connection Test</h1>");
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            if (conn != null && !conn.isClosed()) {
                out.println("<p style='color: green;'>✅ Database connection successful!</p>");
                out.println("<p>Connection URL: " + conn.getMetaData().getURL() + "</p>");
                out.println("<p>Database Product: " + conn.getMetaData().getDatabaseProductName() + "</p>");
                out.println("<p>Database Version: " + conn.getMetaData().getDatabaseProductVersion() + "</p>");
                conn.close();
            } else {
                out.println("<p style='color: red;'>❌ Database connection failed!</p>");
            }
        } catch (SQLException e) {
            out.println("<p style='color: red;'>❌ SQL Exception: " + e.getMessage() + "</p>");
            out.println("<p>Error Code: " + e.getErrorCode() + "</p>");
            out.println("<p>SQL State: " + e.getSQLState() + "</p>");
            e.printStackTrace();
        } catch (Exception e) {
            out.println("<p style='color: red;'>❌ General Exception: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
        
        out.println("</body></html>");
    }
}
