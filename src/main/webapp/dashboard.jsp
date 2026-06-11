<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CROWNY HOTEL MANAGEMENT SYSTEM</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.min.css"> <!-- REMIX ICON -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'> <!-- Boxicons -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/dashboard.css"/>

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>

<body>
<jsp:include page="Admin.jsp"></jsp:include>

<div class="right-section">
    <div class="navbar">
        <div class="title-welcome">
            <h2><span>Bonjour </span>${user.prenom}</h2>
        </div>
        <div class="iconsBtns-and-profile">
            <div class="icons-btns">
                <i class="ri-notification-3-line"></i>
                <i class="ri-message-3-line"></i>
            </div>
            <div class="profile">
                <div class="info">
                    <img src="<%=request.getContextPath()%>/images/profil.png" alt="photo_profil">
                    <div class="account">
                        <a href="${pageContext.request.contextPath}/profileAdmin.jsp"><h5>${user.prenom} ${user.nom}</h5></a>
                        <p>Administrateur</p>
                    </div>
                </div>
                <i class="ri-arrow-down-s-line"></i>
            </div>
        </div>
    </div>

    <div class="main">
        <h3 class="header">
            Tableau de bord
        </h3>

        <ul class="insights">
            <li>
                <i class='bx bx-calendar'></i>
                <span class="info">
            <h3>${currentDate}</h3>
            <p>Date / Heure</p>
        </span>
            </li>
            <li>
                <i class='bx bxs-user'></i>
                <span class="info">
            <h3>${nbrClients} Clients</h3>
            <p>Nombre de clients</p>
        </span>
            </li>
            <li>
                <i class='bx bx-task'></i>
                <span class="info">
            <h3>${nbrChambres} Chambres</h3>
            <p>Chambres disponibles</p>
        </span>
            </li>
            <li>
                <i class='bx bx-line-chart'></i>
                <span class="info">
            <h3><fmt:formatNumber value="${chiffreAffaire}" type="currency" currencySymbol="DH"/></h3>
            <p>Chiffre d'affaires</p>
        </span>
            </li>
        </ul>


        <div class="charts">
            <div class="chart-bar">
                <div id="donutbar" style="width: 770px; height: 340px;"></div>
            </div>

            <div class="chart-doughnut">
                <div id="donutchart" style="width: 420px; height: 340px;"></div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    google.charts.load("current", {packages:["corechart"]});
    google.charts.setOnLoadCallback(drawChart);
    function drawChart() {
        var data = google.visualization.arrayToDataTable([
            ['Task', 'Hours per Day'],
            ['Homme', ${nbrHomme}],
            ['Femme', ${nbrFemme}]
        ]);

        var options = {
            title: 'Pourcentage d\'hommes et de femmes',
            pieHole: 0.4,
            slices: {
                0: { textStyle: { color: '#000000', bold: true } },
                1: { textStyle: { color: '#000000', bold: true } }
            },
            colors: ['#3cbaf4', '#ffbbd0'],
            legend: { position: 'right' },
            chartArea: {
                left: 50,
                top: 50,
                width: '100%',
                height: '100%'
            }
        };

        var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
        chart.draw(data, options);
    }
</script>

<script type="text/javascript">
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
        var data = google.visualization.arrayToDataTable([
            ['Month', 'Réservations'],
            ['Jan', 45],
            ['Feb', 55],
            ['Mar', 65],
            ['Apr', 50],
            ['May', 75],
            ['Jun', 85],
            ['Jul', 90],
            ['Aug', 0],
            ['Sep', 0],
            ['Oct', 0],
            ['Nov', 0],
            ['Dec', 0]
        ]);

        var options = {
            title: 'Statistiques de réservations mensuelles',
            hAxis: { title: 'Mois' },
            vAxis: { title: 'Réservations' },
            legend: { position: 'none' },
            colors: ['#1976D2'],
            bar: { groupWidth: '75%' },
            chartArea: {
                width: '80%',
                height: '70%'
            }
        };

        var chart = new google.visualization.ColumnChart(document.getElementById('donutbar'));
        chart.draw(data, options);
    }
</script>
</body>
</html>