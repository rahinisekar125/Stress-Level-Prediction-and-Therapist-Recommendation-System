package com.stress;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        ServletContext context = getServletContext();

        Map<String, String> users = (Map<String, String>) context.getAttribute("users");

        if (users == null) {
            users = new HashMap<>();
        }

        users.put(username, password);
        context.setAttribute("users", users);

        response.sendRedirect("login.jsp");
    }
}