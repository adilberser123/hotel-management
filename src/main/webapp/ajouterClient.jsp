<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Add Modal HTML -->
<div id="ajouterClientModal" class="modal fade">
    <div class="modal-dialog custom-width">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/ListeClients/create" method="POST">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h5 class="modal-title"><b>Ajouter Client</b></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
                </div>

                <!-- Modal Body -->
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="InputPrenom" class="form-label">Prénom *</label>
                                    <input type="text" name="prenom" class="form-control custom-border-color" id="InputPrenom" required>
                                </div>
                                <div class="mb-3">
                                    <label for="InputNom" class="form-label">Nom *</label>
                                    <input type="text" name="nom" class="form-control custom-border-color" id="InputNom" required>
                                </div>
                                <div class="mb-3">
                                    <label for="InputSexe" class="form-label">Sexe *</label>
                                    <select class="form-select custom-border-color" name="sexe" id="InputSexe" required>
                                        <option value="">Sélectionnez votre sexe</option>
                                        <option value="Homme">Homme</option>
                                        <option value="Femme">Femme</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="InputDateNaissance" class="form-label">Date de naissance *</label>
                                    <input type="text" name="birthDate" class="form-control custom-border-color" id="InputDateNaissance" required>
                                </div>
                                <div class="mb-3">
                                    <label for="InputAdresse" class="col-form-label">Adresse *</label>
                                    <textarea name="adresse" class="form-control custom-border-color" id="InputAdresse" required></textarea>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="InputCIN" class="form-label">CIN *</label>
                                    <input type="text" name="cin" class="form-control custom-border-color" id="InputCIN" required>
                                </div>
                                <div class="mb-3">
                                    <label for="InputTelephone" class="form-label">Téléphone *</label>
                                    <input type="text" name="telephone" class="form-control custom-border-color" id="InputTelephone" required>
                                </div>
                                <div class="mb-3">
                                    <label for="InputEmail" class="form-label">E-mail *</label>
                                    <input type="email" name="email" class="form-control custom-border-color" id="InputEmail" required>
                                </div>

                                <!-- Password -->
                                <div class="mb-3 position-relative">
                                    <label for="InputPassword" class="form-label">Mot de passe *</label>
                                    <div class="input-group">
                                        <input type="password" name="password" class="form-control custom-border-color" id="InputPassword" required>
                                        <span class="input-group-text" onclick="togglePasswordVisibility('InputPassword', this)" style="cursor:pointer">👁️</span>
                                    </div>
                                    <div id="passwordHelp" class="form-text text-danger" style="display: none;">
                                        Le mot de passe doit contenir au moins 8 caractères.
                                    </div>
                                </div>

                                <!-- Confirm Password -->
                                <div class="mb-3 position-relative">
                                    <label for="InputConfirmPassword" class="form-label">Confirmation mot de passe *</label>
                                    <div class="input-group">
                                        <input type="password" class="form-control custom-border-color" id="InputConfirmPassword" required>
                                        <span class="input-group-text" onclick="togglePasswordVisibility('InputConfirmPassword', this)" style="cursor:pointer">👁️</span>
                                    </div>
                                    <div id="confirmHelp" class="form-text text-danger" style="display: none;">
                                        Les mots de passe ne correspondent pas.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal Footer -->
                <div class="modal-footer">
                    <input type="button" class="btn btn-secondary" data-bs-dismiss="modal" value="Annuler">
                    <input type="submit" class="btn btn-primary" value="Ajouter">
                </div>
            </form>
        </div>
    </div>
</div>

<!--  JavaScript complet -->
<script>
    function togglePasswordVisibility(inputId, iconElement) {
        const input = document.getElementById(inputId);
        if (input.type === "password") {
            input.type = "text";
            iconElement.textContent = "";
        } else {
            input.type = "password";
            iconElement.textContent = "👁️";
        }
    }

    document.addEventListener('DOMContentLoaded', function () {
        const passwordInput = document.getElementById('InputPassword');
        const confirmInput = document.getElementById('InputConfirmPassword');
        const passwordHelp = document.getElementById('passwordHelp');
        const confirmHelp = document.getElementById('confirmHelp');
        const form = document.querySelector('#ajouterClientModal form');

        passwordInput.addEventListener('input', function () {
            passwordHelp.style.display = this.value.length < 8 ? 'block' : 'none';
        });

        confirmInput.addEventListener('input', function () {
            confirmHelp.style.display = this.value !== passwordInput.value ? 'block' : 'none';
        });

        form.addEventListener('submit', function (e) {
            let isValid = true;

            if (passwordInput.value.length < 8) {
                passwordHelp.style.display = 'block';
                isValid = false;
            }

            if (confirmInput.value !== passwordInput.value) {
                confirmHelp.style.display = 'block';
                isValid = false;
            }

            if (!isValid) {
                e.preventDefault(); // Empêche l'envoi si invalide
            }
        });
    });
</script>
