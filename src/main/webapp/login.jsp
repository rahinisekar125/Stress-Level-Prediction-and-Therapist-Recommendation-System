<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        body { font-family: Arial, sans-serif; background: linear-gradient(to right, #f093fb, #f5576c); display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .container { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); width: 300px; text-align: center; }
        h1 { color: #e74c3c; }
        input { width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 5px; }
        button { width: 100%; padding: 10px; background: #3498db; color: white; border: none; border-radius: 5px; cursor: pointer; }
        button:hover { background: #2980b9; }
        a { color: #3498db; text-decoration: none; }
        .error { color: red; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Login</h1>
        <% if (request.getAttribute("error") != null) { %>
            <p class="error">
                <%= request.getAttribute("error") %>
            </p>
        <% } %>
        <p style="font-size: 14px; color: #666; margin-bottom: 20px;">Login to access your mental health assessment.<br><small>Demo: username: <strong>user</strong>, password: <strong>pass</strong></small></p>
        <form action="login" method="post">
            <input type="text" name="username" placeholder="Username" required><br>
            <input type="password" name="password" placeholder="Password" required><br>
            <button type="submit">Login</button>
        </form>
        <p><a href="register.jsp">Register</a></p>
    </div>
</body>
</html>