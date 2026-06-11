<!-- ajouterRoom.jsp -->
<div class="modal fade" id="ajouterRoomModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="rooms" method="post">
                <input type="hidden" name="action" value="ajouter">
                <div class="modal-header">
                    <h5 class="modal-title">Ajouter une chambre</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label>Type</label>
                        <input type="text" name="type" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Prix</label>
                        <input type="number" step="0.01" name="prix" class="form-control" required>
                    </div>
                    <div class="form-check mb-3">
                        <input type="checkbox" class="form-check-input" name="disponible" id="ajouterDisponible" checked>
                        <label class="form-check-label" for="ajouterDisponible">Disponible</label>
                    </div>
                    <div class="mb-3">
                        <label>ID Admin</label>
                        <input type="number" name="adminId" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Image (chemin ex: <code>images/room-1.png</code>)</label>
                        <input type="text" name="image" class="form-control" placeholder="images/room1.jpg" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success">Ajouter</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                </div>
            </form>
        </div>
    </div>
</div>
