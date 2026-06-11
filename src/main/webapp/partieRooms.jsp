<%--
  Created by IntelliJ IDEA.
  User: adil
  Date: 4/28/2026
  Time: 11:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Services - Luxury Stay Hospitality</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/partieRooms.css"/>
</head>
<body>
<header class="header">
    <div class="nav-container">
        <div class="logo">
            <img src="images/logo.png" alt="Crowny">
        </div>

        <nav class="nav-center">
            <ul class="nav-links">
                <li><a href="navigates?page=profileCLient">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/roomss" class="active">Rooms</a></li>
                <li><a href="${pageContext.request.contextPath}/bookRoom">My Bookings</a></li>
                <li><a href="navigates?page=partieServices">Services</a></li>
                <li><a href="navigates?page=partieContact">Contact</a></li>
            </ul>
        </nav>

        <a href="Logout" class="login-btn">
            <i class="fas fa-sign-out-alt"></i>
            Logout
        </a>
    </div>
</header>

<!-- Rooms Section -->
<section id="rooms" class="section active">
    <div class="rooms-section">
        <h2 class="section-title">Discover Our Rooms</h2>
        <p class="section-subtitle">Profitez de chambres confortables et élégantes, équipées de tout le nécessaire pour un séjour parfait.
        </p>

        <div class="rooms-grid">
            <c:choose>
                <c:when test="${not empty rooms}">
                    <c:forEach items="${rooms}" var="room">
                        <div class="room-card">
                            <div class="room-image"
                                 style="background-image: url('${pageContext.request.contextPath}/images/${room.image}');
                                         background-size: cover;
                                         background-position: center;">

                                <c:if test="${room.type == 'Suite'}">
                                    <div class="room-badge">Popular</div>
                                </c:if>

                            </div>

                            <div class="room-content">
                                <h3 class="room-title">${room.type} Room</h3>
                                <p class="room-price">
                                    From ${room.prix} DH
                                    <span style="font-size: 0.8em; color: var(--text-light);">/night</span>
                                </p>

                                <p class="room-capacity">
                                    <i class="fas fa-users"></i>
                                    <c:choose>
                                        <c:when test="${room.type == 'Single'}">1 Guest</c:when>
                                        <c:when test="${room.type == 'Double'}">2 Guests</c:when>
                                        <c:otherwise>Up to 4 Guests</c:otherwise>
                                    </c:choose>
                                </p>

                                <div class="room-features">
                                    <div class="feature-icon"><i class="fas fa-wifi" title="Wi-Fi"></i></div>
                                    <div class="feature-icon"><i class="fas fa-tv" title="TV"></i></div>
                                    <div class="feature-icon"><i class="fas fa-snowflake" title="Air Conditioning"></i></div>
                                </div>

                                <a href="roomDetails?action=detail&id=${room.id}" class="view-details-btn">
                                    <i class="fas fa-eye"></i>
                                    View Details
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>

                <c:otherwise>
                    <div style="text-align: center; width: 100%; padding: 40px; background: white; border-radius: 20px; box-shadow: var(--shadow);">
                        <i class="fas fa-exclamation-triangle" style="font-size: 3em; color: #ffc107; margin-bottom: 20px;"></i>
                        <h3 style="color: var(--text-dark); margin-bottom: 15px;">Aucune chambre disponible</h3>
                        <p style="font-size: 1.2em; color: var(--text-light);">
                            Aucun hébergement disponible pour le moment.
                        </p>
                        <p style="font-size: 1em; color: var(--text-light); margin-top: 10px;">
                            Vérifiez que l'attribut 'rooms' est correctement défini dans votre servlet.
                        </p>
                    </div>
                </c:otherwise>
            </c:choose>
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
            <p><i class="fas fa-map-marker-alt"></i> 123 Luxury Avenue, City</p>
            <p><i class="fas fa-phone"></i> +212 5XX XXX XXX</p>
            <p><i class="fas fa-envelope"></i> contact@crownyhotel.com</p>
        </div>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2026 Crowny Hotel. All Rights Reserved.</p>
    </div>
</footer>

<script>
    // Animation on scroll
    function animateOnScroll() {
        const cards = document.querySelectorAll('.room-card');
        cards.forEach(card => {
            const cardTop = card.getBoundingClientRect().top;
            if (cardTop < window.innerHeight - 150) {
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }
        });
    }

    document.addEventListener('DOMContentLoaded', function() {
        // Debug console output
        console.log('🔍 Page chargée - Vérification des éléments');

        const roomsSection = document.getElementById('rooms');
        const roomCards = document.querySelectorAll('.room-card');
        const footer = document.querySelector('.footer');

        console.log('Section rooms trouvée:', roomsSection ? 'OUI' : 'NON');
        console.log('Nombre de cartes de chambres:', roomCards.length);
        console.log('Footer trouvé:', footer ? 'OUI' : 'NON');

        // Animation setup
        const cards = document.querySelectorAll('.room-card');
        cards.forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(30px)';
            card.style.transition = `all 0.6s ease ${index * 0.1}s`;
        });

        // Trigger animations
        setTimeout(() => {
            cards.forEach(card => {
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            });
        }, 100);

        window.addEventListener('scroll', animateOnScroll);
        animateOnScroll();
    });
</script>


</body>

</html>
