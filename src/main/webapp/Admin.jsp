<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="currentURI" value="${pageContext.request.requestURI}" />

<!-- Importation des styles CSS -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/dashboard.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.min.css">
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

<!-- sidebar admin -->
<div class="left-section d-flex flex-column align-items-center justify-content-between p-4">
	<div class="sidebar d-flex flex-column">
		<div class="item ${currentURI.contains('/dashboard') ? 'active' : ''}">
			<a href="${pageContext.request.contextPath}/dashboard" class="d-flex align-items-center">
				<i class="ri-dashboard-line"></i>
				<h3>Tableau de bord</h3>
			</a>
		</div>

		<div class="item ${currentURI.contains('/rooms') ? 'active' : ''}">
			<a href="${pageContext.request.contextPath}/rooms" class="d-flex align-items-center">
				<i class="ri-hotel-bed-line"></i>
				<h3>Chambres</h3>
			</a>
		</div>

		<div class="item ${currentURI.contains('/reservations') ? 'active' : ''}">
			<a href="${pageContext.request.contextPath}/reservations" class="d-flex align-items-center">
				<i class="ri-calendar-check-line"></i>
				<h3>Reservations</h3>
			</a>
		</div>

		<div class="item ${currentURI.contains('/ListeClients') or currentURI.contains('/listeClients') ? 'active' : ''}">
			<a href="${pageContext.request.contextPath}/ListeClients" class="d-flex align-items-center">
				<i class="ri-user-3-line"></i>
				<h3>Clients</h3>
			</a>
		</div>


		<div class="item">
			<a href="${pageContext.request.contextPath}/dashboard" class="d-flex align-items-center">
				<i class="ri-bill-line"></i>
				<h3>Factures</h3>
			</a>
		</div>
	</div>

	<div class="sign-out">
		<a href="${pageContext.request.contextPath}/Logout" class="d-flex align-items-center">
			<i class="ri-logout-box-r-line"></i>
			<h3>Se déconnecter</h3>
		</a>
	</div>
</div>
