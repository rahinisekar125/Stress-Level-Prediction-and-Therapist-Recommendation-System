package com.stress;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;

public class DatabaseTestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html><head><title>Database Test</title></head><body>");
        out.println("<h1>Database Connection Test</h1>");

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            out.println("<p>Attempting to connect to Neon PostgreSQL database...</p>");

            conn = DatabaseUtil.getConnection();
            out.println("<p style='color: green;'>✅ Database connection successful!</p>");

            stmt = conn.createStatement();

            // Test SELECT query
            rs = stmt.executeQuery("SELECT COUNT(*) as user_count FROM users");
            if (rs.next()) {
                int userCount = rs.getInt("user_count");
                out.println("<p>📊 Current users in database: " + userCount + "</p>");
            }

            // Test INSERT query (optional - you can remove this)
            // stmt.execute("INSERT INTO users (username, password, location, age) VALUES
            // ('test_user', 'test_pass', 'Test City', 25)");
            // out.println("<p style='color: blue;'>✅ Test user inserted
            // successfully!</p>");

        } catch (SQLException e) {
            out.println("<p style='color: red;'>❌ Database error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            DatabaseUtil.closeConnection(conn);
        }

        out.println("<br><a href='index.jsp'>Back to Home</a>");
        out.println("</body></html>");
    }
}