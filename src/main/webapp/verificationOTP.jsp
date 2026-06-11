<%--
  Created by IntelliJ IDEA.
  User: adil
  Date: 4/22/2026
  Time: 3:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Vérification OTP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body { background:#f0f4ff; display:flex; align-items:center; justify-content:center; min-height:100vh; }
        .otp-card { background:#fff; border-radius:16px; padding:40px 36px;
            box-shadow:0 8px 32px rgba(13,110,253,.12); max-width:420px; width:100%; text-align:center; }
        .otp-inputs input { width:48px; height:56px; font-size:24px; text-align:center;
            border:2px solid #dee2e6; border-radius:8px; margin:0 4px;
            outline:none; transition:border-color .2s; }
        .otp-inputs input:focus { border-color: #0dfd11; }
        #countdown { font-weight:bold; color: #18ec09; }
        #countdown.expired { color:#dc3545; }
    </style>
</head>
<body>
<div class="otp-card">
    <div style="font-size:48px;color:#0dfd11;"><i class="fas fa-envelope-open-text"></i></div>
    <h4 class="mt-3 mb-1">Vérifiez votre email</h4>
    <p class="text-muted mb-4">Un code à 6 chiffres a été envoyé à votre adresse email.</p>

    <c:if test="${not empty messageErreur}">
        <div class="alert alert-danger">${messageErreur}</div>
    </c:if>

    <form action="verificationOTP" method="POST">
        <div class="otp-inputs d-flex justify-content-center mb-3">
            <input type="text" maxlength="1" class="otp-digit" autofocus>
            <input type="text" maxlength="1" class="otp-digit">
            <input type="text" maxlength="1" class="otp-digit">
            <input type="text" maxlength="1" class="otp-digit">
            <input type="text" maxlength="1" class="otp-digit">
            <input type="text" maxlength="1" class="otp-digit">
            <input type="hidden" name="otp" id="otpFull">
        </div>

        <p class="text-muted mb-3">Expire dans : <span id="countdown">05:00</span></p>
        <button type="submit" class="btn btn-primary w-100 mb-3" id="submitBtn">Confirmer</button>
    </form>

    <a href="Registration" class="btn btn-outline-secondary w-100">
        <i class="fas fa-arrow-left me-1"></i> Retour à l'inscription
    </a>
</div>

<script>
    const digits = document.querySelectorAll('.otp-digit');
    digits.forEach((input, i) => {
        input.addEventListener('input', () => {
            input.value = input.value.replace(/\D/g, '');
            if (input.value && i < digits.length - 1) digits[i + 1].focus();
            assemble();
        });
        input.addEventListener('keydown', e => {
            if (e.key === 'Backspace' && !input.value && i > 0) digits[i - 1].focus();
        });
        input.addEventListener('paste', e => {
            e.preventDefault();
            const text = (e.clipboardData || window.clipboardData).getData('text').replace(/\D/g,'');
            [...text].slice(0, 6).forEach((ch, j) => { if (digits[i + j]) digits[i + j].value = ch; });
            assemble();
        });
    });

    function assemble() {
        document.getElementById('otpFull').value = [...digits].map(d => d.value).join('');
    }

    // 5-minute countdown
    let secs = 300;
    const display = document.getElementById('countdown');
    const btn = document.getElementById('submitBtn');
    const timer = setInterval(() => {
        secs--;
        display.textContent = String(Math.floor(secs/60)).padStart(2,'0')
            + ':' + String(secs%60).padStart(2,'0');
        if (secs <= 0) {
            clearInterval(timer);
            display.textContent = 'Expiré';
            display.classList.add('expired');
            btn.disabled = true;
        }
    }, 1000);
</script>
</body>
</html>
