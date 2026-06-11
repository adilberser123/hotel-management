package com.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.dao.AdminDAO;
import com.db.DBConnexion;
import com.entities.Admin;
import com.entities.Client;

public class AdminDAOImpl implements AdminDAO {

	private static Connection connexion = DBConnexion.getConnection();

	@Override
	public Admin checkLogin(String email, String password) {

		try {
			String query = "SELECT * FROM admin WHERE email = ? AND password = ?";
			PreparedStatement preSt = connexion.prepareStatement(query);

			preSt.setString(1,email);
			preSt.setString(2,password);

			ResultSet rs = preSt.executeQuery();

			Admin admin = null;

			if(rs.next()) {
				int id = rs.getInt("id");
				String cin = rs.getString("cin");
				String prenom = rs.getString("prenom");
				String nom = rs.getString("nom");

				admin = new Admin(id, email, password, cin, prenom, nom);
			}

			return admin;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public boolean create(Admin o) {
		// D'abord vérifier si l'email existe déjà
		if (emailExists(o.getEmail())) {
			return false;
		}

		String sql = "INSERT INTO admin (email, password, cin, prenom, nom) VALUES (?, ?, ?, ?, ?)";
		try (Connection connexion = DBConnexion.getConnection();
		     PreparedStatement stmt = connexion.prepareStatement(sql)) {
			stmt.setString(1, o.getEmail());
			stmt.setString(2, o.getPassword());
			stmt.setString(3, o.getCin());
			stmt.setString(4, o.getPrenom());
			stmt.setString(5, o.getNom());
			int rowsAffected = stmt.executeUpdate();
			return rowsAffected > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	private boolean emailExists(String email) {
		String query = "SELECT COUNT(*) FROM admin WHERE email = ?";
		try (Connection connexion = DBConnexion.getConnection();
		     PreparedStatement preSt = connexion.prepareStatement(query)) {
			preSt.setString(1, email);
			try (ResultSet rs = preSt.executeQuery()) {
				if (rs.next()) {
					return rs.getInt(1) > 0;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}


	@Override
	public boolean update(Admin o) {

		return false;
	}

	@Override
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Admin getById(int adminId) {

		try {
			String query = "SELECT * FROM admin WHERE id = ?";
			PreparedStatement preSt = connexion.prepareStatement(query);

			preSt.setInt(1, adminId);

			ResultSet rs = preSt.executeQuery();
			Admin admin = new Admin();

			if (rs.next()) {
				admin.setId(rs.getInt("id"));
				admin.setEmail(rs.getString("email"));
				admin.setPassword(rs.getString("password"));
				admin.setCin(rs.getString("cin"));
				admin.setPrenom(rs.getString("prenom"));
				admin.setNom(rs.getString("nom"));
			}

			return admin;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}



	@Override
	public List<Admin> getAll() {
		// TODO Auto-generated method stub
		return null;
	}

	public static void main(String[] args) {
		AdminDAO adminDAO = new AdminDAOImpl();

		/*// Test checkLogin
		Admin admin = adminDAO.checkLogin("admin@gmail.com", "admin");
		System.out.println(admin != null ? "Login success: " + admin.getNom() +admin.getPrenom(): "Login failed");

		// Test create
		Admin newAdmin = new Admin();
		newAdmin.setNom("Test");
		newAdmin.setPrenom("User");
		newAdmin.setEmail("test@gmail.com");
		newAdmin.setCin("TEST123");
		newAdmin.setPassword("testpass");

		boolean created = adminDAO.create(newAdmin);
		System.out.println("Admin created: " + created);*/

	}

}
