package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConTest {
	
	public static void main(String[] args) {
		
		Connection con;		
		Statement st;
		
		try {
			con = DBConnector.getConnector();
			
			System.out.println("연결 성공");
			
			st = con.createStatement();	// make query page
			ResultSet rs = st.executeQuery("select * from user");	// rs : database가 넘겨주는 query에 대한 정보를 가짐. (meta data (key), real data)
			
			while(rs.next()) {	 // rs.next() !!! point .next 호출 전에는 rs는 meta data와 real data 중간에 위치하고 있다고 생각하면 됨. next를 호출하지 못하면 data를 읽어올 수 없음
				System.out.print(rs.getString("user_no") + " ");
				System.out.print(rs.getString("id") + " ");
				System.out.print(rs.getString("password") + " ");
				System.out.println(rs.getString("name"));
			}
			
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
			
		}
	}
}
