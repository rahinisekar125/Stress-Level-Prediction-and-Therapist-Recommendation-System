package com.stress;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class FormServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String error = req.getParameter("error");
        if ("1".equals(error)) {
            req.setAttribute("error", "Invalid input. Please try again.");
        }

        req.getRequestDispatcher("form.jsp").forward(req, resp);
    }
}