<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>🧠 Your Assessment Results & Therapist Booking</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 20px;
            min-height: 100vh;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }
        .results-section {
            background: linear-gradient(135deg, #a8e6cf 0%, #dcedc8 100%);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 40px;
            text-align: center;
            border: 3px solid #fff;
        }
        .stress-level {
            font-size: 48px;
            font-weight: bold;
            margin: 20px 0;
        }
        .low { color: #27ae60; }
        .moderate { color: #f39c12; }
        .high { color: #e74c3c; }
        .score-display {
            font-size: 24px;
            color: #2c3e50;
            margin: 15px 0;
        }
        .advice-text {
            font-size: 18px;
            line-height: 1.6;
            color: #34495e;
            margin: 20px 0;
        }
        .therapists-section h2 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
            font-size: 32px;
        }
        .therapists-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }
        .therapist-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: 2px solid transparent;
        }
        .therapist-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }
        .therapist-card.selected {
            border-color: #667eea;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }
        .therapist-name {
            font-size: 24px;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 10px;
        }
        .therapist-specialty {
            color: #7f8c8d;
            font-size: 16px;
            margin-bottom: 15px;
        }
        .therapist-rating {
            color: #f39c12;
            font-size: 18px;
            margin-bottom: 15px;
        }
        .booking-section {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 30px;
            border: 2px solid #e9ecef;
        }
        .booking-section h3 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 25px;
            font-size: 24px;
        }
        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }
        .form-group {
            flex: 1;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #2c3e50;
        }
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e8ed;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }
        .form-control:focus {
            outline: none;
            border-color: #667eea;
        }
        .book-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .book-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }
        .error-message {
            background: #fee;
            color: #e74c3c;
            padding: 15px;
            border-radius: 8px;
            text-align: center;
            margin-bottom: 20px;
            border: 1px solid #fcd0d0;
        }
        .success-message {
            background: #efe;
            color: #27ae60;
            padding: 15px;
            border-radius: 8px;
            text-align: center;
            margin-bottom: 20px;
            border: 1px solid #d4edda;
        }
        .alternative-slots {
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            border-radius: 8px;
            padding: 15px;
            margin-top: 15px;
        }
        .alternative-slots h4 {
            color: #856404;
            margin-bottom: 10px;
        }
        .slot-suggestion {
            display: inline-block;
            background: #667eea;
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            margin: 5px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .slot-suggestion:hover {
            background: #5a67d8;
        }
        .nav-links {
            text-align: center;
            margin-top: 30px;
        }
        .nav-links a {
            display: inline-block;
            margin: 0 15px;
            padding: 10px 20px;
            background: #95a5a6;
            color: white;
            text-decoration: none;
            border-radius: 25px;
            transition: background 0.3s ease;
        }
        .nav-links a:hover {
            background: #7f8c8d;
        }
        @media (max-width: 768px) {
            .form-row {
                flex-direction: column;
            }
            .therapists-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Results Section -->
        <div class="results-section">
            <h1>🧠 Your Mental Health Assessment Results</h1>
            <%
                String stressLevel = (String) session.getAttribute("stressLevel");
                if (stressLevel == null) {
                    stressLevel = "Unknown";
                }
            %>
            <div class="stress-level <%= stressLevel.toLowerCase() %>">
                <%= stressLevel %> Stress Level
            </div>
            <div class="score-display">
                📊 Your Score: <%= session.getAttribute("totalScore") != null ? session.getAttribute("totalScore") : "N/A" %>/20
            </div>
            <div class="advice-text">
                <%= session.getAttribute("advice") != null ? session.getAttribute("advice") : "Please complete the stress assessment first." %>
            </div>
        </div>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message">
                ⚠️ <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <% if (request.getAttribute("confirmation") != null) { %>
            <div class="success-message">
                ✅ <%= request.getAttribute("confirmation") %>
            </div>
        <% } %>

        <!-- Therapists Section -->
        <div class="therapists-section">
            <h2>👨‍⚕️ Available Therapists</h2>
            <div class="therapists-grid">
                <div class="therapist-card" data-therapist="Dr. Smith">
                    <div class="therapist-name">Dr. Sarah Smith</div>
                    <div class="therapist-specialty">Anxiety & Stress Management</div>
                    <div class="therapist-rating">⭐⭐⭐⭐⭐ (4.8/5)</div>
                    <div>📍 Downtown Clinic</div>
                    <div>💼 8+ years experience</div>
                </div>
                <div class="therapist-card" data-therapist="Dr. Johnson">
                    <div class="therapist-name">Dr. Michael Johnson</div>
                    <div class="therapist-specialty">Depression & Mood Disorders</div>
                    <div class="therapist-rating">⭐⭐⭐⭐⭐ (4.9/5)</div>
                    <div>📍 Wellness Center</div>
                    <div>💼 12+ years experience</div>
                </div>
                <div class="therapist-card" data-therapist="Dr. Lee">
                    <div class="therapist-name">Dr. Emily Lee</div>
                    <div class="therapist-specialty">CBT & Mindfulness Therapy</div>
                    <div class="therapist-rating">⭐⭐⭐⭐⭐ (4.7/5)</div>
                    <div>📍 Mindful Living Institute</div>
                    <div>💼 10+ years experience</div>
                </div>
            </div>

            <!-- Booking Section -->
            <div class="booking-section">
                <h3>📅 Book Your Appointment</h3>
                <form action="book" method="post" id="bookingForm">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="therapist">👨‍⚕️ Select Therapist</label>
                            <select name="therapist" id="therapist" class="form-control" required>
                                <option value="">Choose a therapist...</option>
                                <option value="Dr. Smith">Dr. Sarah Smith (Anxiety & Stress)</option>
                                <option value="Dr. Johnson">Dr. Michael Johnson (Depression & Mood)</option>
                                <option value="Dr. Lee">Dr. Emily Lee (CBT & Mindfulness)</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="slot">🕐 Select Time Slot</label>
                            <select name="slot" id="slot" class="form-control" required>
                                <option value="">Choose a time...</option>
                                <option value="9:00 AM">🌅 9:00 AM</option>
                                <option value="10:00 AM">☕ 10:00 AM</option>
                                <option value="11:00 AM">🌤️ 11:00 AM</option>
                                <option value="2:00 PM">🌞 2:00 PM</option>
                                <option value="3:00 PM">🕒 3:00 PM</option>
                                <option value="4:00 PM">🌆 4:00 PM</option>
                            </select>
                        </div>
                    </div>
                    <button type="submit" class="book-btn">📝 Book Appointment</button>
                </form>
            </div>
        </div>

        <div class="nav-links">
            <a href="form">🔄 Retake Assessment</a>
            <a href="logout">🚪 Logout</a>
        </div>
    </div>

    <script>
        // Therapist card selection
        document.querySelectorAll('.therapist-card').forEach(card => {
            card.addEventListener('click', () => {
                document.querySelectorAll('.therapist-card').forEach(c => c.classList.remove('selected'));
                card.classList.add('selected');

                const therapistValue = card.dataset.therapist;
                document.getElementById('therapist').value = therapistValue;
            });
        });

        // Form submission handling
        document.getElementById('bookingForm').addEventListener('submit', function(e) {
            const therapist = document.getElementById('therapist').value;
            const slot = document.getElementById('slot').value;

            if (!therapist || !slot) {
                e.preventDefault();
                alert('Please select both a therapist and time slot.');
                return false;
            }
        });
    </script>
</body>
</html>