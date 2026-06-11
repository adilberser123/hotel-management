<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${roomDetail.type} Room | Luxury Stay</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/partieDetails.css"/>

</head>
<body>

<!-- Header -->
<header class="header">
    <div class="nav-container">
        <div class="logo">
            <img src="images/logo.png" alt="Crowny">
        </div>
        <nav>
            <ul class="nav-links">
                <li><a href="navigates?page=profileCLient">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/roomss" class="active">Rooms</a></li>
                <li><a href="${pageContext.request.contextPath}/bookRoom">My Bookings</a></li>
                <li><a href="navigates?page=partieServices">Services</a></li>
                <li><a href="navigates?page=partieContact">Contact</a></li>
            </ul>
        </nav>
        <a href="Logout" class="login-btn" id="auth-btn">
            <i class="fas fa-sign-out-alt"></i>
            Logout
        </a>
    </div>
</header>

<!-- Room Detail Section -->
<section id="room-detail" class="section active">
    <div class="room-detail">
        <div style="height: 120px;"></div>
        <div class="detail-hero">
            <div class="detail-image" style="background-image: url('${pageContext.request.contextPath}/images/${roomDetail.image}')"></div>
            <div class="detail-content">
                <div class="detail-grid">
                    <div>
                        <h2 class="detail-title">${roomDetail.type} Room</h2>
                        <p class="detail-info">
                            Experience refined comfort in our ${roomDetail.type} Room, thoughtfully designed for your stay.
                            This elegant space combines modern amenities with classic Crowny.
                        </p>

                        <div class="features-section">
                            <h3>Room Specifications</h3>
                            <div class="features-grid">
                                <div class="feature-item">
                                    <i class="fas fa-bed"></i>
                                    <span>
                                        <c:choose>
                                            <c:when test="${roomDetail.type.equals('Single')}">Single Bed</c:when>
                                            <c:when test="${roomDetail.type.equals('Double')}">Double Bed</c:when>
                                            <c:otherwise>King Size Bed</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <div class="feature-item">
                                    <i class="fas fa-ruler-combined"></i>
                                    <span>
                                        <c:choose>
                                            <c:when test="${roomDetail.type.equals('Single')}">25-30 m²</c:when>
                                            <c:when test="${roomDetail.type.equals('Double')}">30-35 m²</c:when>
                                            <c:otherwise>40-50 m²</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <div class="feature-item">
                                    <i class="fas fa-wifi"></i>
                                    <span>High-speed WiFi</span>
                                </div>
                                <div class="feature-item">
                                    <i class="fas fa-tv"></i>
                                    <span>Smart TV</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div>
                        <div class="features-section">
                            <h3>Premium Features</h3>
                            <div class="features-grid">
                                <div class="feature-item">
                                    <i class="fas fa-coffee"></i>
                                    <span>Tea/Coffee Maker</span>
                                </div>
                                <div class="feature-item">
                                    <i class="fas fa-snowflake"></i>
                                    <span>Air Conditioning</span>
                                </div>
                                <div class="feature-item">
                                    <i class="fas fa-lock"></i>
                                    <span>Safe Deposit Box</span>
                                </div>
                                <div class="feature-item">
                                    <i class="fas fa-bath"></i>
                                    <span>Bathroom</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="price-section">
                    <div>
                        <span class="price">${roomDetail.prix} <span style="font-size: 0.6em; color: var(--text-light);">DH par night</span></span>
                    </div>
                    <a href="${pageContext.request.contextPath}/reservationForm.jsp?roomId=${roomDetail.id}" class="book-now-btn">
                    <i class="fas fa-calendar-check"></i>
                        Book Now
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer">
    <div class="footer-content">
        <div class="footer-logo">
            <span>Luxury Stay Hospitality</span>
        </div>
        <p>Creating extraordinary experiences through unparalleled luxury and exceptional service.</p>
        <div class="social-links">
            <a href="#" title="Facebook"><i class="fab fa-facebook-f"></i></a>
            <a href="#" title="Instagram"><i class="fab fa-instagram"></i></a>
            <a href="#" title="Twitter"><i class="fab fa-twitter"></i></a>
            <a href="#" title="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
        </div>
        <p style="margin-top: 30px; font-size: 0.9rem;">© 2026 Luxury Stay Hospitality. All Rights Reserved.</p>
    </div>
</footer>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Animation pour les éléments de détail
        const detailElements = document.querySelectorAll('.feature-item, .detail-title, .detail-info');
        detailElements.forEach((el, index) => {
            el.style.opacity = '0';
            el.style.transform = 'translateY(20px)';
            el.style.transition = `all 0.5s ease ${index * 0.1}s`;

            setTimeout(() => {
                el.style.opacity = '1';
                el.style.transform = 'translateY(0)';
            }, 100);
        });

        // Header scroll effect
        let lastScrollTop = 0;
        const header = document.querySelector('.header');

    });
</script>

</body>
</html>