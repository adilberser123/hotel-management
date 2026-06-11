<%--
  Created by IntelliJ IDEA.
  User: adil
  Date: 4/28/2026
  Time: 11:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Services - Luxury Stay Hospitality</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/partieServices.css"/>
</head>
<body>
<header class="header">
    <div class="nav-container">
        <div class="logo">
            <img src="images/logo.png" alt="Crowny">
        </div>

        <nav class="nav-center">
            <ul class="nav-links">
                <li><a href="navigates?page=profileCLient" >Home</a></li>
                <li><a href="${pageContext.request.contextPath}/roomss">Rooms</a></li>
                <li><a href="${pageContext.request.contextPath}/bookRoom">My Bookings</a></li>
                <li><a href="navigates?page=partieServices" class="active">Services</a></li>
                <li><a href="navigates?page=partieContact">Contact</a></li>
            </ul>
        </nav>

        <a href="Logout" class="login-btn">
            <i class="fas fa-sign-out-alt"></i>
            Logout
        </a>
    </div>
</header>

<!-- Footer -->
<footer class="footer-modern">
    <div class="footer-container">
        <div class="footer-about">
            <h3>Crowny Hotel</h3>
            <p>Creating extraordinary experiences through unparalleled luxury and exceptional service. Your comfort is our priority.</p>
            <div class="footer-social">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-linkedin-in"></i></a>
            </div>
        </div>

        <div class="footer-links">
            <h4>Quick Links</h4>
            <ul>
                <li><a href="#">Home</a></li>
                <li><a href="#">Rooms</a></li>
                <li><a href="#">Bookings</a></li>
                <li><a href="#">Services</a></li>
                <li><a href="#">Contact</a></li>
            </ul>
        </div>

        <div class="footer-links">
            <h4>Support</h4>
            <ul>
                <li><a href="#">FAQ</a></li>
                <li><a href="#">Privacy Policy</a></li>
                <li><a href="#">Terms of Service</a></li>
                <li><a href="#">Cancellation Policy</a></li>
            </ul>
        </div>

        <div class="footer-contact">
            <h4>Contact Us</h4>
            <p><i class="fas fa-map-marker-alt"></i> LOT SALAMA 2 KSAR EL KEBIR</p>
            <p><i class="fas fa-phone"></i> +212 682655914</p>
            <p><i class="fas fa-envelope"></i> contact@crownyhotel.com</p>
        </div>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2026 Crowny Hotel. All Rights Reserved.</p>
    </div>
</footer>

</body>

</html>
