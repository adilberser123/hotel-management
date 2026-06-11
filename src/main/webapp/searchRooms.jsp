<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Rooms - Luxury Stay Hospitality</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/sercherooms.css"/>

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
                <li><a href="${pageContext.request.contextPath}/rooms" class="active">Rooms</a></li>
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

<!-- Results Section -->
<section class="results-section">
    <div class="results-header">
        <div class="results-info">
            <strong>${totalResults}</strong> room(s) available
            <c:if test="${not empty numberOfDays}">
                for <strong>${numberOfDays}</strong> night(s)
            </c:if>
        </div>
    </div>

    <!-- Rooms Grid -->
    <c:choose>
        <c:when test="${not empty rooms}">
            <div class="rooms-grid" id="roomsGrid">
                <c:forEach var="room" items="${rooms}">
                    <div class="room-card" data-price="${room.prix}" data-type="${room.type}">

                        <!-- Image de la chambre -->
                        <div class="room-image">
                            <img src="${pageContext.request.contextPath}/images/${room.image}" alt="${room.type}" style="width:100%; height:180px; object-fit:cover; border-top-left-radius:12px; border-top-right-radius:12px;">
                            <div class="room-badge">${room.type}</div>
                        </div>

                        <div class="room-content">
                            <h3 class="room-title">Room ${room.id}</h3>
                            <div class="room-price">
                                <fmt:formatNumber value="${room.prix}" type="number" maxFractionDigits="2"/> DH / night
                            </div>
                            <div class="room-capacity">
                                <i class="fas fa-users"></i>
                                <c:choose>
                                    <c:when test="${room.type eq 'Single'}">1 Guest</c:when>
                                    <c:when test="${room.type eq 'Double'}">2 Guests</c:when>
                                    <c:otherwise>3+ Guests</c:otherwise>
                                </c:choose>
                            </div>

                            <div class="room-features">
                                <div class="feature-icon" title="WiFi"><i class="fas fa-wifi"></i></div>
                                <div class="feature-icon" title="Air Conditioning"><i class="fas fa-snowflake"></i></div>
                                <div class="feature-icon" title="Room Service"><i class="fas fa-concierge-bell"></i></div>
                                <div class="feature-icon" title="TV"><i class="fas fa-tv"></i></div>
                            </div>

                            <div class="total-price-highlight">
                                <strong>Total Price:
                                    <span style="color: var(--secondary-color);">
                                        <fmt:formatNumber value="${room.prix * numberOfDays}" type="number" maxFractionDigits="2"/> DH
                                    </span>
                                </strong>
                                <div style="font-size: 0.9em; color: var(--text-light); margin-top: 5px;">
                                        ${numberOfDays} night(s) ×
                                    <fmt:formatNumber value="${room.prix}" type="number" maxFractionDigits="2"/> DH
                                </div>
                            </div>

                            <div class="action-buttons">
                                <a href="bookRoom?roomId=${room.id}&checkInDate=${selectedCheckIn}&checkOutDate=${selectedCheckOut}&totalPrice=${room.prix * numberOfDays}"
                                   class="book-now-btn">
                                    <i class="fas fa-calendar-check"></i>
                                    Book Now
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="no-results">
                <i class="fas fa-search"></i>
                <h3>No rooms available</h3>
                <p>We couldn't find any rooms matching your criteria. Please try different dates.</p>
            </div>
        </c:otherwise>
    </c:choose>
</section>

<!-- Footer -->
<footer class="footer">
    <div class="footer-content">
        <div class="footer-logo">
            <div style="display: flex; align-items: center; justify-content: center; gap: 15px; margin-bottom: 20px;">
                <span style="font-family: 'Playfair Display', serif; font-size: 2rem;">Luxury Stay Hospitality</span>
            </div>
         <p>Creating extraordinary experiences through unparalleled luxury and exceptional service.</p>
         <div class="social-links">
            <a href="#" title="Facebook"><i class="fab fa-facebook-f"></i></a>
            <a href="#" title="Instagram"><i class="fab fa-instagram"></i></a>
            <a href="#" title="Twitter"><i class="fab fa-twitter"></i></a>
            <a href="#" title="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
         </div>
         <p style="margin-top: 30px; font-size: 0.9rem;">2026 Luxury Stay Hospitality. All Rights Reserved.</p>
          </div>
    </div>
</footer>

</body>
</html>