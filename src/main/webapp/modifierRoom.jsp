<!-- modifierRoom.jsp -->
<div class="modal fade" id="modifierRoomModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="rooms" method="post">
                <input type="hidden" name="action" value="modifier">
                <input type="hidden" name="id" id="editRoomId">
                <div class="modal-header">
                    <h5 class="modal-title">Modifier la chambre</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label>Type</label>
                        <input type="text" name="type" id="editType" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Prix</label>
                        <input type="number" step="0.01" name="prix" id="editPrix" class="form-control" required>
                    </div>
                    <div class="form-check mb-3">
                        <input type="checkbox" class="form-check-input" name="disponible" id="editDisponible">
                        <label class="form-check-label" for="editDisponible">Disponible</label>
                    </div>
                    <div class="mb-3">
                        <label>ID Admin</label>
                        <input type="number" name="adminId" id="editAdminId" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Image (chemin)</label>
                        <input type="text" name="image" id="editImage" class="form-control" placeholder="images/room1.jpg" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Enregistrer</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                </div>
            </form>
        </div>
    </div>
</div>
