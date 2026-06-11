<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="supprimerClientModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="deleteForm" action="${pageContext.request.contextPath}/ListeClients/delete" method="POST">
                <!-- Modal Header -->
                <div class="modal-header bg-danger text-white">
                    <h4 class="modal-title">Supprimer Client</h4>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-hidden="true"></button>
                </div>

                <!-- Modal Body -->
                <div class="modal-body">
                    <p>Êtes-vous sûr de vouloir supprimer ce(s) client(s) ?</p>
                    <p class="text-warning fw-bold">
                        <small>Cette action ne peut pas être annulée.</small>
                    </p>
                    <input type="hidden" id="clientIdsToDelete" name="clientIds" value="">
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-danger" id="confirmDeleteBtn">Supprimer</button>
                </div>
            </form>
        </div>
    </div>
</div>