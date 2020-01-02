package com.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DBConnection {
	static Connection con=null;
	static Statement st=null;
	static ResultSet rs=null;
	public Connection getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_registration","root","root");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}
}
