<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Stress Level Analyzer - Home</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
        }
        .hero {
            max-width: 800px;
            padding: 40px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }
        h1 {
            font-size: 3em;
            margin-bottom: 20px;
            background: linear-gradient(45deg, #fff, #f0f8ff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        p {
            font-size: 1.2em;
            line-height: 1.6;
            margin: 20px 0;
        }
        .features {
            display: flex;
            justify-content: space-around;
            margin: 40px 0;
            flex-wrap: wrap;
        }
        .feature {
            background: rgba(255, 255, 255, 0.2);
            padding: 20px;
            border-radius: 10px;
            margin: 10px;
            flex: 1;
            min-width: 200px;
            backdrop-filter: blur(5px);
        }
        .feature h3 {
            margin-top: 0;
            color: #ffd700;
        }
        .cta-button {
            display: inline-block;
            padding: 15px 30px;
            background: linear-gradient(45deg, #ff6b6b, #ffa500);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-size: 1.2em;
            font-weight: bold;
            transition: transform 0.3s, box-shadow 0.3s;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
        .cta-buttons {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
        }
        .footer {
            margin-top: 40px;
            font-size: 0.9em;
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <div class="hero">
        <h1>🧠 Stress Level Analyzer</h1>
        <p>Welcome to your personal mental health companion. Our intelligent system helps you assess your stress levels through a simple, interactive questionnaire and connects you with professional support when needed.</p>

        <div class="features">
            <div class="feature">
                <h3>📊 Quick Assessment</h3>
                <p>Answer 5 simple questions to get an instant stress level analysis.</p>
            </div>
            <div class="feature">
                <h3>👨‍⚕️ Professional Support</h3>
                <p>Get connected with nearby therapists and book appointments easily.</p>
            </div>
        </div>

        <div class="cta-buttons">
            <a href="login.jsp" class="cta-button">Login</a>
            <a href="register.jsp" class="cta-button">Register</a>
        </div>

        <div class="footer">
            <p>Take the first step towards better mental well-being today!</p>
        </div>
    </div>
</body>
</html>