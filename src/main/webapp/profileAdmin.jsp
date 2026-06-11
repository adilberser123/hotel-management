<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>CROWNY - Profil</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --black: #000000;
            --dark: #363949;
            --dark-blue: #364670;
            --light: #F0F5FD;
            --white: #FFF;
            --grey: #999;
            --blue: #1D92F1;
            --light-blue: #DDEFFD;
            --red: #D32F2F;
            --light-red: #FECDD3;
            --dark-green: #32a652;
            --green: #3BC963;
            --light-green: #E2F7E8;
            --yellow: #FFD12C;
            --light-yellow: #FFF8DF;
            --dark-yellow: #FFC107;
            --blue-btn: #1976D2;
            --dark-blue-btn: #0D47A1;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: var(--light);
            padding: 40px;
        }

        .container {
            max-width: 1000px;
            margin: auto;
            display: flex;
            gap: 30px;
            flex-wrap: wrap;
        }

        .profile-card {
            background-color: var(--white);
            border-radius: 16px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            padding: 25px;
            text-align: center;
            width: 250px;
        }

        .profile-photo {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            overflow: hidden;
            margin: 0 auto 15px;
            background-color: var(--light-blue);
        }

        .profile-photo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .profile-name {
            font-size: 20px;
            font-weight: 600;
            color: var(--dark);
        }

        .profile-id {
            font-size: 14px;
            color: var(--grey);
            margin: 5px 0;
        }

        .profile-role {
            font-size: 14px;
            color: var(--blue);
            font-weight: 500;
        }

        .profile-gender {
            font-size: 14px;
            color: var(--dark-blue);
            margin-top: 5px;
        }

        .info-card {
            background-color: var(--white);
            border-radius: 16px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            padding: 25px;
            flex: 1;
            min-width: 300px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid var(--light-blue);
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            font-weight: 500;
            color: var(--dark-blue);
            width: 40%;
        }

        .info-value {
            color: var(--dark);
            width: 60%;
            text-align: right;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="profile-card">
        <div class="profile-photo">
            <img src="<%=request.getContextPath()%>/images/profiladmin.png" alt="Photo de profil">
        </div>
        <div class="profile-name">${user.prenom} ${user.nom}</div>
        <div class="profile-id">ID : ${user.id}</div>
        <div class="profile-role">Administrateur</div>
        <div class="profile-gender">Sexe : Homme</div>
    </div>

    <div class="info-card">
        <div class="info-row">
            <div class="info-label">Adresse</div>
            <div class="info-value">Ksar elkebir</div>
        </div>
        <div class="info-row">
            <div class="info-label">Email</div>
            <div class="info-value">${user.email}</div>
        </div>
        <div class="info-row">
            <div class="info-label">Téléphone</div>
            <div class="info-value">+212 682655914</div>
        </div>
        <div class="info-row">
            <div class="info-label">CIN</div>
            <div class="info-value">${user.cin}</div>
        </div>
        <div class="info-row">
            <div class="info-label">Date de naissance</div>
            <div class="info-value">23/02/2003</div>
        </div>
    </div>
</div>
</body>
</html>
