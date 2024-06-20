package com.uga.mbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {
	private static Connection obj = null;

	private DbConnection() {
	}

	public static Connection getInstance() throws SQLException, ClassNotFoundException {
		if (obj == null) {
			Class.forName("com.mysql.jdbc.Driver");
			obj = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviebookingsystem", "root", "Admin@2001");
		}
		return obj;
	}
}
