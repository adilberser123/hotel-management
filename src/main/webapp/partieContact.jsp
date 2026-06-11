<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Luxury Stay Hospitality</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/partieContact.css"/>

</head>
<body>

<!-- Header -->
<header class="header">
    <div class="nav-container">
        <div class="logo">
            <div class="logo-icon">
                <i class="fas fa-gem"></i>
            </div>
            <div class="logo">
                <img src="images/logo.png" alt="Crowny">
            </div>
        </div>
        <nav>
            <ul class="nav-links">
                <li><a href="navigates?page=profileCLient">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/roomss">Rooms</a></li>
                <li><a href="${pageContext.request.contextPath}/bookRoom">My Bookings</a></li>
                <li><a href="navigates?page=partieServices">Services</a></li>
                <li><a href="navigates?page=partieContact" class="active">Contact</a></li>
            </ul>
        </nav>
        <a href="Logout" class="login-btn" id="auth-btn">
            <i class="fas fa-sign-out-alt"></i>
            Logout
        </a>
    </div>
</header>


<!-- Contact Section -->
<section id="contact" class="section">
    <div class="contact-section">
        <div style="height: 120px;"></div>
        <h2 class="section-title">Get In Touch</h2>
        <p class="section-subtitle">Have questions or special requests? Our team is here to assist you in planning the perfect stay.</p>

        <div class="contact-form">
            <form onsubmit="handleContact(event)">
                <div class="form-row">
                    <input type="text" placeholder="First Name" required>
                    <input type="text" placeholder="Last Name" required>
                </div>
                <div class="form-row">
                    <input type="email" placeholder="Email Address" required>
                    <input type="tel" placeholder="Phone Number" required>
                </div>
                <input type="text" placeholder="Subject" required style="margin-bottom: 25px;">
                <textarea placeholder="How can we assist you? Please share your questions, special requests, or feedback..." required style="margin-bottom: 25px;"></textarea>
                <button type="submit" class="submit-btn">
                    <i class="fas fa-paper-plane"></i>
                    Send Message
                </button>
            </form>
        </div>
    </div>
</section>

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

<script>
    function handleContact(event) {
        event.preventDefault();

        // Show success message
        const button = event.target.querySelector('.submit-btn');
        const originalText = button.innerHTML;

        button.innerHTML = '<i class="fas fa-check"></i> Message Sent!';
        button.style.background = '#28a745';

        setTimeout(() => {
            button.innerHTML = originalText;
            button.style.background = '';
            event.target.reset();
        }, 3000);
    }
</script>
</body>
</html>