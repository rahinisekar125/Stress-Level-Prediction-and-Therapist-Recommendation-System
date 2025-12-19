package com.stress;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class StressServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int q1 = Integer.parseInt(request.getParameter("q1"));
            int q2 = Integer.parseInt(request.getParameter("q2"));
            int q3 = Integer.parseInt(request.getParameter("q3"));
            int q4 = Integer.parseInt(request.getParameter("q4"));
            int q5 = Integer.parseInt(request.getParameter("q5"));

            int totalScore = q1 + q2 + q3 + q4 + q5;
            request.setAttribute("totalScore", totalScore);

            String stressLevel;
            String advice;
            String redirectPage;
            if (totalScore <= 5) {
                stressLevel = "Low";
                advice = "🌿 Excellent! Your stress levels are low. Keep maintaining your healthy lifestyle with regular exercise, balanced nutrition, and good sleep habits. You're doing great!";
                redirectPage = "result.jsp";
            } else if (totalScore <= 10) {
                stressLevel = "Moderate";
                advice = "🤝 Your stress levels are moderate. Consider incorporating more relaxation techniques like meditation or yoga. Talking to a professional can provide additional support and strategies.";
                redirectPage = "therapist.jsp";
            } else {
                stressLevel = "High";
                advice = "💙 Your stress levels are high. It's important to seek professional help. A therapist can provide you with coping strategies and support. Remember, asking for help is a sign of strength!";
                redirectPage = "therapist.jsp";
            }

            request.setAttribute("stressLevel", stressLevel);
            request.setAttribute("advice", advice);

            // Store assessment results in session for persistence across requests
            session.setAttribute("stressLevel", stressLevel);
            session.setAttribute("totalScore", totalScore);
            session.setAttribute("advice", advice);

            // Redirect based on stress level
            request.getRequestDispatcher(redirectPage).forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("form?error=1");
        }
    }
}