<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Assessment Result</title>
    <style>
        body { font-family: Arial, sans-serif; background: linear-gradient(to right, #a8e6cf, #dcedc8); display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .container { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); text-align: center; max-width: 500px; }
        h1 { color: #27ae60; }
        .score { font-size: 24px; margin: 20px 0; }
        .low { color: green; }
        .moderate { color: orange; }
        .high { color: red; }
        p { margin: 20px 0; }
        a { display: inline-block; margin: 10px; padding: 10px 20px; background: #3498db; color: white; text-decoration: none; border-radius: 5px; }
        a:hover { background: #2980b9; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Your Stress Assessment Result</h1>
        <div class="score <%= ((String)request.getAttribute("stressLevel")).toLowerCase() %>">
            Stress Level: <%= request.getAttribute("stressLevel") %>
        </div>
        <p>Total Score: <%= request.getAttribute("totalScore") %></p>
        <% String level = (String)request.getAttribute("stressLevel"); %>
        <% if ("Low".equals(level)) { %>
            <p>Great! Your stress level is low. Keep up the good work with regular exercise, balanced diet, and adequate sleep. 🌿</p>
        <% } else if ("Moderate".equals(level)) { %>
            <p>Your stress level is moderate. Consider talking to a professional for support. Remember, it's okay to ask for help. 🤝</p>
        <% } else { %>
            <p>Your stress level is high. Please seek professional help immediately. You're not alone in this. 💙</p>
        <% } %>
        <a href="form">Take Assessment Again</a> | <a href="logout">Logout</a>
    </div>
</body>
</html>