package com.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnexion {

	private static Connection connexion = null;

	public static Connection getConnection() {

		System.out.println("Start getConnection ...");

		try {
			String url = "jdbc:mysql://localhost:3306/hotel_management";
			String login = "root";
			String passwd = "5949";
			Class.forName("com.mysql.cj.jdbc.Driver");

			connexion = DriverManager.getConnection(url, login, passwd);

			if (connexion != null) {
				System.out.println("Connection successful !");
			} else {
				System.out.println("Connection failure !");
			}

			return connexion;

		} catch (ClassNotFoundException | SQLException e) {
			System.out.println("Connexion failure ... " + e.getMessage());
			e.printStackTrace();
			return null;
		}
	}

	public static void main(String[] args) {
		DBConnexion.getConnection();
	}
}