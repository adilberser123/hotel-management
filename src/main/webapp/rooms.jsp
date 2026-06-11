<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Gestion des Chambres - CROWNY HOTEL</title>

  <!-- CSS -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/roomss.css"/>

  <!-- JS -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <style>
    /* Style pour les images dans le tableau */
    .room-img-wrapper {
      width: 60px;
      height: 60px;
      overflow: hidden;
      border-radius: 6px;
      border: 1px solid #ddd;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .room-img-wrapper img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
  </style>
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
      <h2>Gestion des Chambres</h2>
    </div>

    <div class="table-main d-flex flex-column mt-4 p-3">
      <div class="table-header d-flex justify-content-between">
        <div class="btns-add-delete d-flex justify-content-between">
          <a href="#ajouterRoomModal" class="btn btn-success" data-bs-toggle="modal">
            <span><i class="fas fa-plus-circle"></i> Ajouter une chambre</span>
          </a>
          <a href="#supprimerRoomModal" class="btn btn-danger disabled" data-bs-toggle="modal" id="deleteSelectedBtn">
            <span><i class="fas fa-minus-circle"></i> Supprimer</span>
          </a>
        </div>
        <div class="for-search d-flex">
          <input class="form-control me-2" id="searchInput" type="search" placeholder="Rechercher...">
          <button class="btn btn-outline-primary" id="searchBtn">
            <i class="fas fa-search"></i>
          </button>
        </div>
      </div>

      <div class="table-content mt-3">
        <table class="table table-striped table-hover">
          <thead class="table-primary">
          <tr>
            <th><input type="checkbox" class="form-check-input" id="selectAll"></th>
            <th>ID</th>
            <th>Image</th> <!-- Nouvelle colonne Image -->
            <th>Type</th>
            <th>Prix</th>
            <th>Disponibilité</th>
            <th>Admin</th>
            <th>Actions</th>
          </tr>
          </thead>
          <tbody id="roomsTable">
          <c:choose>
            <c:when test="${not empty rooms}">
              <c:forEach var="room" items="${rooms}">
                <tr>
                  <td><input type="checkbox" class="form-check-input select-checkbox" name="roomId" value="${room.id}"></td>
                  <td>${room.id}</td>
                  <td>
                    <div class="room-img-wrapper">
                      <img src="${pageContext.request.contextPath}/images/${room.image}" alt="Image chambre">
                    </div>
                  </td>
                  <td>${room.type}</td>
                  <td>${room.prix} DH</td>
                  <td>
                    <c:choose>
                      <c:when test="${room.disponible}">
                        <span class="badge bg-success">Disponible</span>
                      </c:when>
                      <c:otherwise>
                        <span class="badge bg-danger">Occupée</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td>${room.administrateur.nom} ${room.administrateur.prenom}</td>
                  <td>
                    <a href="#modifierRoomModal" class="edit" data-bs-toggle="modal"
                       data-id="${room.id}" data-type="${room.type}"
                       data-prix="${room.prix}" data-disponible="${room.disponible}"
                       data-admin-id="${room.administrateur.id}">
                      <i class="fas fa-edit me-2" data-bs-toggle="tooltip" title="Modifier"></i>
                    </a>
                    <a href="#supprimerRoomModal" class="delete" data-bs-toggle="modal" data-id="${room.id}">
                      <i class="fas fa-trash me-2" data-bs-toggle="tooltip" title="Supprimer"></i>
                    </a>
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr>
                <td colspan="8" class="text-center text-muted">Aucune chambre trouvée.</td>
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
<jsp:include page="ajouterRoom.jsp"></jsp:include>
<jsp:include page="modifierRoom.jsp"></jsp:include>
<jsp:include page="supprimerRoom.jsp"></jsp:include>

<script>
  $(document).ready(function() {
    // Fonctionnalité de recherche
    $("#searchBtn").click(function() {
      var searchValue = $("#searchInput").val().toLowerCase();
      $("#roomsTable tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(searchValue) > -1);
      });
    });

    // Sélectionner/désélectionner toutes les cases
    $("#selectAll").change(function() {
      $(".select-checkbox").prop('checked', $(this).prop('checked'));
      updateDeleteButton();
    });

    // Mise à jour du bouton Supprimer
    $(".select-checkbox").change(function() {
      updateDeleteButton();
    });

    function updateDeleteButton() {
      var anyChecked = $(".select-checkbox:checked").length > 0;
      $("#deleteSelectedBtn")
              .toggleClass("disabled", !anyChecked)
              .prop("aria-disabled", !anyChecked);
    }

    // Pré-remplir le modal d'édition
    $('.edit').click(function() {
      var id = $(this).data('id');
      $('#editRoomId').val(id);
      $('#editType').val($(this).data('type'));
      $('#editPrix').val($(this).data('prix'));
      $('#editDisponible').prop('checked', $(this).data('disponible') === true);
      $('#editAdminId').val($(this).data('admin-id'));
    });

    // Préparer la suppression
    $('.delete').click(function() {
      var id = $(this).data('id');
      $('#roomIdToDelete').val(id);
    });

    $('[data-bs-toggle="tooltip"]').tooltip();
  });
</script>
</body>
</html>
