package com.stress;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Map;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        HttpSession session = request.getSession();

        // Default demo login
        if ("user".equals(username) && "pass".equals(password)) {
            session.setAttribute("user", username);
            response.sendRedirect("form");
            return;
        }

        // Check registered users
        ServletContext context = getServletContext();
        Map<String, String> users = (Map<String, String>) context.getAttribute("users");

        if (users != null && users.containsKey(username) && users.get(username).equals(password)) {
            session.setAttribute("user", username);
            response.sendRedirect("form");
        } else {
            request.setAttribute("error", "User not found. Please check your credentials.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}