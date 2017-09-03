package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnector {
	
	private static Connection con;
	
	public static Connection getConnector() 
			throws ClassNotFoundException, SQLException {
		
		if(con == null) {
			String url   = "jdbc:mysql://localhost:3306/jsp_study";
			String id    = "root";
			String pwd = "159753";
			boolean autoCommit = false;			
			
			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection(url, id, pwd);
			con.setAutoCommit(autoCommit);
		}
		
		return con;
	}
	
	public static void closeConnector() throws SQLException {
		if(con != null) {
			con.close();
			con = null;
		}
	}

}
