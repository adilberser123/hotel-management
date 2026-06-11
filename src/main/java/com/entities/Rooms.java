package com.entities;
public class Rooms {
    private int id;

    private String type;

    private float prix;

    private boolean disponible;

    private Admin administrateur;

    private String image;

    // Constructeurs
    public Rooms() {
    }

    public Rooms(String type, Float prix, Boolean disponible, Admin administrateur) {
        this.type = type;
        this.prix = prix;
        this.disponible = disponible;
        this.administrateur = administrateur;
    }

    // Getters et Setters
    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Float getPrix() {
        return prix;
    }

    public void setPrix(Float prix) {
        this.prix = prix;
    }

    public Boolean getDisponible() {
        return disponible;
    }

    public void setDisponible(Boolean disponible) {
        this.disponible = disponible;
    }

    public Admin getAdministrateur() {
        return administrateur;
    }

    public void setAdministrateur(Admin administrateur) {
        this.administrateur = administrateur;
    }

    @Override
    public String toString() {
        return "Rooms{" +
                "id=" + id +
                ", type='" + type + '\'' +
                ", prix=" + prix +
                ", disponible=" + disponible +
                ", administrateur=" + administrateur +
                '}';
    }

}

