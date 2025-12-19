<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <style>
        body { font-family: Arial, sans-serif; background: linear-gradient(to right, #4facfe, #00f2fe); display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .container { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); width: 300px; text-align: center; }
        h1 { color: #27ae60; }
        input { width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 5px; }
        button { width: 100%; padding: 10px; background: #e67e22; color: white; border: none; border-radius: 5px; cursor: pointer; }
        button:hover { background: #d35400; }
        a { color: #e67e22; text-decoration: none; }
        .error { color: red; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Register</h1>
        <% if (request.getParameter("error") != null) {
            String error = request.getParameter("error");
            String errorMessage = "";
            if ("1".equals(error)) {
                errorMessage = "Registration failed. Please try again.";
            } else if ("2".equals(error)) {
                errorMessage = "Username already exists. Please choose a different username.";
            } else if ("3".equals(error)) {
                errorMessage = "All fields are required. Please fill in all information.";
            } else if ("4".equals(error)) {
                errorMessage = "Please enter a valid age (1-120).";
            }
            if (!errorMessage.isEmpty()) { %>
                <p class="error"><%= errorMessage %></p>
        <%   }
           } %>
        <p style="font-size: 14px; color: #666; margin-bottom: 20px;">Create your account to access the mental health assessment.</p>
        <form action="register" method="post">
            <input type="text" name="username" placeholder="Username" required><br>
            <input type="password" name="password" placeholder="Password" required><br>
            <input type="text" name="location" placeholder="Location" required><br>
            <input type="number" name="age" placeholder="Age" required><br>
            <button type="submit">Register</button>
        </form>
        <p><a href="login.jsp">Login</a></p>
    </div>
</body>
</html>