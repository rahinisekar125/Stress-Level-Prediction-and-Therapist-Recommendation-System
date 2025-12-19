package com.stress;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

public class BookingServlet extends HttpServlet {

    private static final List<String> AVAILABLE_SLOTS = Arrays.asList(
            "9:00 AM", "10:00 AM", "11:00 AM", "2:00 PM", "3:00 PM", "4:00 PM");

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String therapist = req.getParameter("therapist");
        String slot = req.getParameter("slot");

        ServletContext context = getServletContext();
        Map<String, Set<String>> bookings = (Map<String, Set<String>>) context.getAttribute("bookings");

        if (bookings == null) {
            bookings = new HashMap<>();
            context.setAttribute("bookings", bookings);
        }

        // Check if slot is booked
        Set<String> therapistSlots = bookings.computeIfAbsent(therapist, k -> new HashSet<>());
        if (therapistSlots.contains(slot)) {
            // Find available alternative slots
            List<String> availableSlots = AVAILABLE_SLOTS.stream()
                    .filter(s -> !therapistSlots.contains(s))
                    .collect(java.util.stream.Collectors.toList());

            String alternativeSlots = availableSlots.isEmpty()
                    ? "No other slots available for today. Please try again tomorrow."
                    : "Available alternatives: " + String.join(", ", availableSlots);

            req.setAttribute("error",
                    "❌ The slot " + slot + " for " + therapist + " is already booked. " + alternativeSlots);
            req.getRequestDispatcher("therapist.jsp").forward(req, resp);
            return;
        }

        // Book the slot
        therapistSlots.add(slot);
        context.setAttribute("bookings", bookings);

        req.setAttribute("therapist", therapist);
        req.setAttribute("slot", slot);
        req.setAttribute("confirmation",
                "✅ Your appointment with " + therapist + " at " + slot
                        + " has been booked successfully! You will receive a confirmation email shortly.");
        req.getRequestDispatcher("confirmation.jsp").forward(req, resp);
    }
}