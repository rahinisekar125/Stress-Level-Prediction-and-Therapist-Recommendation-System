<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Confirmation</title>
    <style>
        body { font-family: Arial, sans-serif; background: linear-gradient(to right, #ffecd2, #fcb69f); display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .container { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); text-align: center; max-width: 500px; }
        h1 { color: #e67e22; }
        p { font-size: 18px; margin: 20px 0; }
        .success { color: #27ae60; font-weight: bold; }
        a { display: inline-block; margin: 10px; padding: 10px 20px; background: #3498db; color: white; text-decoration: none; border-radius: 5px; }
        a:hover { background: #2980b9; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Booking Confirmation</h1>
        <p class="success"><%= request.getAttribute("confirmation") %></p>
        <p>Thank you for taking this step towards better mental health. Your appointment is confirmed! 📅</p>
        <a href="index.jsp">Back to Home</a> | <a href="logout">Logout</a>
    </div>
</body>
</html>