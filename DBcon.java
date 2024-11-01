package DBPKG;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBcon {
	public static Connection getConnection(){
		Connection conn = null;
		String driverName = "org.mariadb.jdbc.Driver";
		String url = "jdbc:mariadb://localhost:3306/mydb";
		String uid = "root";
		String pw="1234";
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, uid, pw);
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if(conn != null) {
			System.out.println("DB 접속 성공!");
		}
		return conn;
	}
}	
