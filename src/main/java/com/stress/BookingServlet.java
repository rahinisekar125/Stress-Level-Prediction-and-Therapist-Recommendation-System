package com.stress;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class BookingServlet extends HttpServlet {

    private static final List<String> AVAILABLE_SLOTS = Arrays.asList(
            "9:00 AM", "10:00 AM", "11:00 AM", "2:00 PM", "3:00 PM", "4:00 PM");

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("user");
        String therapist = req.getParameter("therapist");
        String slot = req.getParameter("slot");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseUtil.getConnection();

            // Check if slot is already booked
            String checkBookingSql = "SELECT id FROM bookings WHERE therapist = ? AND slot = ?";
            stmt = conn.prepareStatement(checkBookingSql);
            stmt.setString(1, therapist);
            stmt.setString(2, slot);

            rs = stmt.executeQuery();

            if (rs.next()) {
                // Find available alternative slots
                List<String> availableSlots = new ArrayList<>();
                String findAvailableSql = "SELECT slot FROM bookings WHERE therapist = ?";
                stmt = conn.prepareStatement(findAvailableSql);
                stmt.setString(1, therapist);

                rs = stmt.executeQuery();
                Set<String> bookedSlots = new HashSet<>();
                while (rs.next()) {
                    bookedSlots.add(rs.getString("slot"));
                }

                for (String availableSlot : AVAILABLE_SLOTS) {
                    if (!bookedSlots.contains(availableSlot)) {
                        availableSlots.add(availableSlot);
                    }
                }

                String alternativeSlots = availableSlots.isEmpty()
                        ? "No other slots available for today. Please try again tomorrow."
                        : "Available alternatives: " + String.join(", ", availableSlots);

                req.setAttribute("error",
                        "❌ The slot " + slot + " for " + therapist + " is already booked. " + alternativeSlots);
                req.getRequestDispatcher("therapist.jsp").forward(req, resp);
                return;
            }

            // Book the slot
            String insertBookingSql = "INSERT INTO bookings (username, therapist, slot) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(insertBookingSql);
            stmt.setString(1, username);
            stmt.setString(2, therapist);
            stmt.setString(3, slot);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                req.setAttribute("therapist", therapist);
                req.setAttribute("slot", slot);
                req.setAttribute("confirmation",
                        "✅ Your appointment with " + therapist + " at " + slot
                                + " has been booked successfully! You will receive a confirmation email shortly.");
                req.getRequestDispatcher("confirmation.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "❌ Failed to book appointment. Please try again.");
                req.getRequestDispatcher("therapist.jsp").forward(req, resp);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error", "❌ Database error. Please try again later.");
            req.getRequestDispatcher("therapist.jsp").forward(req, resp);
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
    }
}