<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="modifierClientModal" class="modal fade">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form id="updateClientForm" action="${pageContext.request.contextPath}/ListeClients/update" method="POST">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title"><b>Modifier Client</b></h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-hidden="true"></button>
                </div>

                <div class="modal-body">
                    <div id="updateErrorMessages" class="alert alert-danger d-none"></div>

                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="prenom" class="form-label">Prénom *</label>
                                    <input type="text" name="prenom" class="form-control" id="prenom" required>
                                </div>
                                <div class="mb-3">
                                    <label for="sexe" class="form-label">Sexe *</label>
                                    <select name="sexe" class="form-select" id="sexe" required>
                                        <option value="">Sélectionnez votre sexe</option>
                                        <option value="Homme">Homme</option>
                                        <option value="Femme">Femme</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="birthDate" class="form-label">Date de naissance *</label>
                                    <input type="date" name="birthDate" class="form-control" id="birthDate" required>
                                </div>
                                <div class="mb-3">
                                    <label for="adresse" class="form-label">Adresse *</label>
                                    <textarea name="adresse" class="form-control" id="adresse" required></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="cin" class="form-label">CIN *</label>
                                    <input type="text" name="cin" class="form-control" id="cin" required>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="nom" class="form-label">Nom *</label>
                                    <input type="text" name="nom" class="form-control" id="nom" required>
                                </div>
                                <div class="mb-3">
                                    <label for="telephone" class="form-label">Téléphone *</label>
                                    <input type="tel" name="telephone" class="form-control" id="telephone" required>
                                </div>
                                <div class="mb-3">
                                    <label for="email" class="form-label">E-mail *</label>
                                    <input type="email" name="email" class="form-control" id="email" required>
                                </div>
                                <div class="mb-3">
                                    <label for="password" class="form-label">Mot de passe *</label>
                                    <input type="password" name="password" class="form-control" id="password" required>
                                </div>
                                <div class="mb-3">
                                    <label for="confirmPassword" class="form-label">Confirmation mot de passe *</label>
                                    <input type="password" class="form-control" id="confirmPassword" required>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <input type="hidden" name="id" id="id">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary" id="updateClientBtn">Modifier</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // Validation des mots de passe
        $('#confirmPassword').on('keyup', function() {
            if ($('#password').val() !== $('#confirmPassword').val()) {
                this.setCustomValidity("Les mots de passe ne correspondent pas");
            } else {
                this.setCustomValidity("");
            }
        });

        // Pré-remplir le formulaire quand on clique sur modifier
        $('.edit').click(function() {
            $('#id').val($(this).data('id'));
            $('#email').val($(this).data('email'));
            $('#password').val($(this).data('password'));
            $('#confirmPassword').val($(this).data('password'));
            $('#cin').val($(this).data('cin'));
            $('#prenom').val($(this).data('prenom'));
            $('#nom').val($(this).data('nom'));
            $('#birthDate').val($(this).data('birthdate'));
            $('#sexe').val($(this).data('sexe'));
            $('#telephone').val($(this).data('telephone'));
            $('#adresse').val($(this).data('adresse'));
        });

        // Soumission du formulaire
        $('#updateClientForm').submit(function(e) {
            e.preventDefault();

            if (!this.checkValidity()) {
                e.stopPropagation();
                $(this).addClass('was-validated');
                return;
            }

            $('#updateClientBtn').prop('disabled', true).html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Enregistrement...');

            $.ajax({
                url: $(this).attr('action'),
                type: 'POST',
                data: $(this).serialize(),
                success: function(response) {
                    location.reload();
                },
                error: function(xhr) {
                    $('#updateClientBtn').prop('disabled', false).html('Modifier');
                    let errorMsg = "Erreur lors de la modification";

                    try {
                        const response = JSON.parse(xhr.responseText);
                        if (response.message) errorMsg = response.message;
                    } catch(e) {}

                    $('#updateErrorMessages').removeClass('d-none').html(errorMsg);
                }
            });
        });
    });
</script>