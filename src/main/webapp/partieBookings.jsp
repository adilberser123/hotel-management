<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - Luxury Stay Hospitality</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/partieBooking.css"/>
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
                <li><a href="${pageContext.request.contextPath}/bookRoom" class="active">My Bookings</a></li>
                <li><a href="navigates?page=partieServices">Services</a></li>
                <li><a href="navigates?page=partieContact" >Contact</a></li>
            </ul>
        </nav>
        <a href="Logout" class="login-btn">
            <i class="fas fa-sign-out-alt"></i>
            Logout
        </a>
    </div>
</header>

<!-- Main Content -->
<div class="main-content">
    <div class="booking-section">
        <h2 class="section-title">My Reservations</h2>
        <p class="section-subtitle">Manage your current and past bookings with ease.</p>

        <c:choose>
            <c:when test="${empty bookings}">
                <!-- No bookings message -->
                <div class="no-bookings">
                    <i class="fas fa-calendar-times"></i>
                    <h3>No Reservations Found</h3>
                    <p>You haven't made any reservations yet. Start planning your perfect getaway!</p>
                    <a href="${pageContext.request.contextPath}/roomss" class="browse-rooms-btn">
                        <i class="fas fa-bed"></i>
                        Browse Rooms
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Display bookings -->
                <c:forEach var="booking" items="${bookings}">
                    <div class="booking-card">
                        <div class="booking-image room-${booking.room.type}">
                            <img src="${pageContext.request.contextPath}/images/${booking.room.image}" alt="${booking.room.type}" />
                        </div>
                        <div class="booking-info">
                            <div class="status-badge status-${booking.status}">
                                <c:choose>
                                    <c:when test="${booking.status == 'en_attente'}">
                                        <i class="fas fa-clock"></i>
                                        En Attente
                                    </c:when>
                                    <c:when test="${booking.status == 'confirme'}">
                                        <i class="fas fa-check-circle"></i>
                                        Confirmé
                                    </c:when>
                                    <c:when test="${booking.status == 'annule'}">
                                        <i class="fas fa-times-circle"></i>
                                        Annulé
                                    </c:when>
                                    <c:when test="${booking.status == 'termine'}">
                                        <i class="fas fa-flag-checkered"></i>
                                        Terminé
                                    </c:when>
                                </c:choose>
                            </div>
                            <h3>${booking.room.type}</h3>
                            <div class="booking-dates">
                                <div>
                                    <i class="fas fa-calendar-plus"></i>
                                    <strong>Réservé le:</strong> ${booking.dateBooking}
                                </div>
                                <c:if test="${not empty booking.checkInDate}">
                                    <div>
                                        <i class="fas fa-calendar-check"></i>
                                        <strong>Check-In:</strong> ${booking.checkInDate}
                                    </div>
                                </c:if>
                                <c:if test="${not empty booking.checkOutDate}">
                                    <div>
                                        <i class="fas fa-calendar-times"></i>
                                        <strong>Check-Out:</strong> ${booking.checkOutDate}
                                    </div>
                                </c:if>
                                <div>
                                    <i class="fas fa-bed"></i>
                                    <strong>Chambre:</strong> ${booking.room.type}
                                </div>
                            </div>

                            <!-- Action buttons for pending bookings -->
                            <c:if test="${booking.status == 'en_attente'}">
                                <div class="action-buttons">
                                    <!-- Formulaire Modifier -->
                                    <form action="${pageContext.request.contextPath}/BookingActionServlet" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="modifier"/>
                                        <input type="hidden" name="bookingId" value="${booking.id}"/>
                                        <button type="submit" class="btn btn-modify">
                                            <i class="fas fa-edit"></i>
                                            Modifier
                                        </button>
                                    </form>

                                    <!-- Formulaire Annuler -->
                                    <form action="${pageContext.request.contextPath}/BookingActionServlet" method="post" style="display: inline;" onsubmit="return confirm('Êtes-vous sûr de vouloir annuler cette réservation ?');">
                                        <input type="hidden" name="action" value="annuler"/>
                                        <input type="hidden" name="bookingId" value="${booking.id}"/>
                                        <button type="submit" class="btn btn-cancel">
                                            <i class="fas fa-times"></i>
                                            Annuler
                                        </button>
                                    </form>
                                </div>
                            </c:if>
                        </div>
                        <div class="booking-pricing">
                            <c:if test="${not empty booking.totalPrice}">
                                <div class="total-price">
                                    <fmt:formatNumber value="${booking.totalPrice}" type="currency" currencySymbol=""/>
                                    <span style="font-size: 0.6em; color: var(--text-light);">DH</span>
                                </div>
                            </c:if>
                            <c:if test="${not empty booking.room.prix}">
                                <div class="total-price">
                                    <fmt:formatNumber value="${booking.room.prix}" type="currency" currencySymbol=""/>
                                    <span style="font-size: 0.6em; color: var(--text-light);">DH par nuit</span>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>


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


    // Header scroll effect
    let lastScrollTop = 0;
    const header = document.querySelector('.header');


</script>

</body>
</html>