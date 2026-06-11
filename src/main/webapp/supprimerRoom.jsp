<!-- supprimerRoom.jsp -->
<div class="modal fade" id="supprimerRoomModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="rooms" method="post">
                <input type="hidden" name="action" value="supprimer">
                <input type="hidden" name="id" id="roomIdToDelete">
                <div class="modal-header">
                    <h5 class="modal-title text-danger">Confirmer la suppression</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Es-tu sur de vouloir supprimer cette chambre ?</p>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-danger">Supprimer</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                </div>
            </form>
        </div>
    </div>
</div>
