<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.entities.Client" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion Des Clients</title>

    <!-- CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/listeClients.css"/>

    <!-- JS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body class="d-flex">
<jsp:include page="Admin.jsp"></jsp:include>

<div class="right-section flex-grow-1 d-flex flex-column">
    <div class="myNavbar d-flex align-items-center justify-content-end p-4">
        <div class="iconsBtns-and-profile d-flex align-items-center justify-content-between">
            <div class="icons-btns d-flex">
            <i class="ri-notification-3-line"></i>
                <i class="ri-message-3-line"></i>
            </div>
            <div class="profile d-flex align-items-center justify-content-between">
                <div class="info d-flex align-items-center">
                    <img src="${pageContext.request.contextPath}/images/profil.png">
                    <div class="account">
                        <a href="${pageContext.request.contextPath}/profileAdmin.jsp"><h5>${user.prenom} ${user.nom}</h5></a>
                        <p>Administrateur</p>
                    </div>
                </div>
                <i class="ri-arrow-down-s-line"></i>
            </div>
        </div>
    </div>

    <div class="main flex-grow-1 d-flex flex-column p-4">
        <div class="header">
            <h2>Liste des Clients</h2>
        </div>

        <div class="table-main d-flex flex-column mt-4 p-3">
            <div class="table-header d-flex justify-content-between">
                <div class="btns-add-delete d-flex justify-content-between">
                    <a href="#ajouterClientModal" class="btn btn-success" data-bs-toggle="modal">
                        <span><i class="fas fa-plus-circle"></i> Ajouter un client</span>
                    </a>
                    <a href="#supprimerClientModal" class="btn btn-danger disabled" data-bs-toggle="modal" id="deleteSelectedBtn">
                        <span><i class="fas fa-minus-circle"></i> Supprimer</span>
                    </a>
                </div>
                <div class="for-search">
                    <input class="form-control" id="myInput" type="search" placeholder="Chercher" aria-label="Search">
                </div>
            </div>

            <div class="table-content mt-3">
                <table class="table table-striped table-hover">
                    <thead class="table-primary">
                    <tr>
                        <th><input type="checkbox" class="form-check-input" id="selectAll"></th>
                        <th>Nom</th>
                        <th>Prénom</th>
                        <th>Date de naissance</th>
                        <th>CIN</th>
                        <th>Téléphone</th>
                        <th>Adresse</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody id="myTable">
                    <c:choose>
                        <c:when test="${not empty clients}">
                            <c:forEach var="client" items="${clients}">
                                <tr>
                                    <td><input type="checkbox" class="form-check-input select-checkbox" name="clientId" value="${client.id}"></td>
                                    <td>${client.nom}</td>
                                    <td>${client.prenom}</td>
                                    <td>${client.birthDate}</td>
                                    <td>${client.cin}</td>
                                    <td>${client.telephone}</td>
                                    <td>${client.adresse}</td>
                                    <td>
                                        <a href="#modifierClientModal" class="edit d-inline align-middle" data-bs-toggle="modal"
                                           data-id="${client.id}" data-email="${client.email}" data-password="${client.password}"
                                           data-cin="${client.cin}" data-prenom="${client.prenom}" data-nom="${client.nom}"
                                           data-birthdate="${client.birthDate}" data-sexe="${client.sexe}" data-telephone="${client.telephone}"
                                           data-adresse="${client.adresse}">
                                            <i class="fas fa-edit me-2" data-bs-toggle="tooltip" title="Modifier"></i>
                                        </a>
                                        <a href="#supprimerClientModal" class="delete d-inline align-middle" data-bs-toggle="modal" data-id="${client.id}">
                                            <i class="fas fa-trash me-2" data-bs-toggle="tooltip" title="Supprimer"></i>
                                        </a>
                                        <form action="ListeReservationsClient" method="GET" class="d-inline align-middle form-inline">
                                            <input type="hidden" name="clientId" value="${client.id}">
                                            <button class="btn btn-sm btn-outline-primary" type="submit" data-bs-toggle="tooltip" title="Voir les réservations">
                                                <i class="fas fa-calendar-alt"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="8" class="text-center text-muted">Aucun client trouvé.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!-- Modals -->
<jsp:include page="ajouterClient.jsp"></jsp:include>
<jsp:include page="modifierClient.jsp"></jsp:include>
<jsp:include page="supprimerClient.jsp"></jsp:include>


<script>
    $(document).ready(function() {
        // Filtrer les clients
        $("#myInput").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#myTable tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });

        // Sélectionner tout
        $("#selectAll").change(function() {
            $(".select-checkbox").prop('checked', $(this).prop('checked'));
            updateDeleteButton();
        });

        // Mise à jour du bouton supprimer
        $(".select-checkbox").change(function() {
            updateDeleteButton();
        });

        function updateDeleteButton() {
            var anyChecked = $(".select-checkbox:checked").length > 0;
            $("#deleteSelectedBtn")
                .toggleClass("disabled", !anyChecked)
                .prop("aria-disabled", !anyChecked);
        }

        // Préparer la suppression d'un seul client (icône poubelle)
        $('.delete').click(function() {
            var id = $(this).data('id');
            $('#clientIdsToDelete').val(id);
        });

        // Gestion de la suppression multiple (bouton Supprimer principal)
        $("#deleteSelectedBtn").click(function(e) {
            if($(this).hasClass("disabled")) {
                e.preventDefault();
                return false;
            }

            var ids = [];
            $(".select-checkbox:checked").each(function() {
                ids.push($(this).val());
            });

            if(ids.length > 0) {
                $('#clientIdsToDelete').val(ids.join(","));
            }
        });

        // Soumission du formulaire de suppression
        $('#deleteForm').submit(function(e) {
            e.preventDefault();

            $('#confirmDeleteBtn').prop('disabled', true).html(
                '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Suppression...'
            );

            $.ajax({
                url: $(this).attr('action'),
                type: 'POST',
                data: $(this).serialize(),
                success: function(response) {
                    location.reload();
                },
                error: function(xhr) {
                    $('#confirmDeleteBtn').prop('disabled', false).html('Supprimer');
                    alert("Erreur lors de la suppression : " + xhr.responseText);
                }
            });
        });
    });
</script>
</body>
</html>