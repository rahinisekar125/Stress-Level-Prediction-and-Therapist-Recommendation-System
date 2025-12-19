package com.stress;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String location = request.getParameter("location");
        String ageStr = request.getParameter("age");

        // Basic validation
        if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            response.sendRedirect("register.jsp?error=3");
            return;
        }

        int age = 0;
        try {
            age = Integer.parseInt(ageStr);
            if (age < 1 || age > 120) {
                response.sendRedirect("register.jsp?error=4");
                return;
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("register.jsp?error=4");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DatabaseUtil.getConnection();

            // Check if username already exists
            String checkUserSql = "SELECT username FROM users WHERE username = ?";
            stmt = conn.prepareStatement(checkUserSql);
            stmt.setString(1, username);
            var rs = stmt.executeQuery();

            if (rs.next()) {
                response.sendRedirect("register.jsp?error=2");
                return;
            }

            // Insert new user
            String insertUserSql = "INSERT INTO users (username, password, location, age) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(insertUserSql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, location);
            stmt.setInt(4, age);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("login.jsp");
            } else {
                response.sendRedirect("register.jsp?error=1");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=1");
        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            DatabaseUtil.closeConnection(conn);
        }
    }
}