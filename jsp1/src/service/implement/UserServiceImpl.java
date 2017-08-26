package service.implement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Map;

import common.DBConnector;
import service.UserService;

public class UserServiceImpl implements UserService {

	@Override
	public String insertUser(Map hm) {

		
		String result = hm.get("name") + "님 무슨 이유인지는 모르겠지만, 회원가입에 실패하셨습니다.";		
		Connection con;
		
		try{
			con = DBConnector.getConnector();
			
			String sql = "INSERT INTO user(id, name, password, hobby)";
			sql += " VALUES(?,?,?,?)";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, (String)hm.get("id"));
			ps.setString(2, (String)hm.get("name"));
			ps.setString(3, (String)hm.get("pwd"));
			ps.setString(4, (String)hm.get("hobby"));
			
			int row = ps.executeUpdate();
			
			if(row == 1) {
				result = hm.get("name") + "님, 회원가입에 성공하셨습니다.";
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

}
