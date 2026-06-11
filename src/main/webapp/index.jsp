<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HOTEL MANAGEMENT SYSTEM</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> <!-- Bootstrap CSS 5.3.3 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script> <!-- Bootstrap JS 5.3.3 -->

    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css"/>
</head>
<body>
<header>
    <div class="nav-container">
        <div class="logo">
            <img src="images/logo.png" alt="Crowny">
        </div>
    </div>
</header>

<section id="home" class="home main" style="background-image: url('<%=request.getContextPath()%>/images/banner-1.png'); background-size: cover; background-position: center; background-repeat: no-repeat; min-height: 100vh;">
    <div class="content">
        <div class="item">
            <div class="text">
                <h1>Welcome to Crowny Hotel</h1> <br><br>
                <form action="Login" method="GET">
                    <div class="flex">
                        <button class="primary-btn" type="submit" name="accountType" value="client">Espace de CLient</button>
                        <button class="secondary-btn" type="submit" name="accountType" value="admin">Espace de l'administrateur</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

</body>
</html>
