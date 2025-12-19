<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Mental Health Assessment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #667eea, #764ba2);
            color: white;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: rgba(255,255,255,0.9);
            padding: 30px;
            border-radius: 10px;
            color: #333;
        }
        h2 {
            text-align: center;
            color: #8e44ad;
            margin-bottom: 30px;
        }
        p {
            font-size: 18px;
            margin: 20px 0 10px 0;
            font-weight: bold;
        }
        input[type="radio"] {
            margin-right: 10px;
        }
        label {
            margin-right: 20px;
            cursor: pointer;
        }
        hr {
            border: 1px solid #ddd;
            margin: 30px 0;
        }
        button {
            display: block;
            width: 100%;
            padding: 15px;
            background: #27ae60;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            margin-top: 30px;
        }
        button:hover {
            background: #229954;
        }
        .error {
            color: red;
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <% if (request.getAttribute("error") != null) { %>
            <div class="error">Please answer all questions before submitting.</div>
        <% } %>

        <form action="stress" method="post" class="assessment-form">
            <h2>Mental Health Assessment</h2>

            <!-- Question 1 -->
            <p>1. How often do you feel overwhelmed by your daily responsibilities?</p>
            <input type="radio" name="q1" value="0" required> <label>Never</label>
            <input type="radio" name="q1" value="1"> <label>Sometimes</label>
            <input type="radio" name="q1" value="2"> <label>Often</label>
            <input type="radio" name="q1" value="3"> <label>Always</label>

            <hr>

            <!-- Question 2 -->
            <p>2. How well are you able to relax after a busy day?</p>
            <input type="radio" name="q2" value="0" required> <label>Very well</label>
            <input type="radio" name="q2" value="1"> <label>Fairly well</label>
            <input type="radio" name="q2" value="2"> <label>Not very well</label>
            <input type="radio" name="q2" value="3"> <label>Not at all</label>

            <hr>

            <!-- Question 3 -->
            <p>3. How frequently do you feel anxious without a clear reason?</p>
            <input type="radio" name="q3" value="0" required> <label>Never</label>
            <input type="radio" name="q3" value="1"> <label>Occasionally</label>
            <input type="radio" name="q3" value="2"> <label>Frequently</label>
            <input type="radio" name="q3" value="3"> <label>Almost always</label>

            <hr>

            <!-- Question 4 -->
            <p>4. How would you describe your sleep quality recently?</p>
            <input type="radio" name="q4" value="0" required> <label>Very good</label>
            <input type="radio" name="q4" value="1"> <label>Good</label>
            <input type="radio" name="q4" value="2"> <label>Poor</label>
            <input type="radio" name="q4" value="3"> <label>Very poor</label>

            <hr>

            <!-- Question 5 -->
            <p>5. How often do you feel mentally or physically exhausted?</p>
            <input type="radio" name="q5" value="0" required> <label>Rarely</label>
            <input type="radio" name="q5" value="1"> <label>Sometimes</label>
            <input type="radio" name="q5" value="2"> <label>Often</label>
            <input type="radio" name="q5" value="3"> <label>Always</label>

            <br><br>

            <button type="submit">Get My Assessment Results</button>
        </form>
    </div>
</body>
</html>