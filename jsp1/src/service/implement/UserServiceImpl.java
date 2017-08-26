package service.implement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import common.DBConnector;
import service.UserService;

public class UserServiceImpl implements UserService {

	@Override
	public String insertUser(Map<String, String> hm) {
		
		String result = hm.get("name") + "님 무슨 이유인지는 모르겠지만, 회원가입에 실패하셨습니다.";		
		Connection con;
		
		try{
			con = DBConnector.getConnector();
			
			String sql = "INSERT INTO user(id, name, password, hobby)";
			sql += " VALUES(?,?,?,?)";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, hm.get("id"));
			ps.setString(2, hm.get("name"));
			ps.setString(3, hm.get("pwd"));
			ps.setString(4, hm.get("hobby"));
			
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

	@Override
	public Map<String, String> selectUser(Map<String, String> hm) {
		Connection con;
		PreparedStatement ps;
		String result = hm.get("id") + "는 없는 아이디 입니다.";
		
		Map<String, String> resultMap = new HashMap<String, String>();
		
		try {
			con = DBConnector.getConnector();
			System.out.println("연결 성공");
			String sql = "select * from user";
			sql += " where id=?";
			ps = con.prepareStatement(sql);
			ps.setString(1 , hm.get("id"));
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				if(hm.get("pwd").equals(rs.getString("password"))){
					
					resultMap.put("id", rs.getString("id"));
					resultMap.put("name", rs.getString("name"));
					resultMap.put("hobby", rs.getString("hobby"));
					resultMap.put("user_no", rs.getString("user_no"));
					
					result = "로그인 성공하셨네요";

				}else{
					result = "비밀번호가 틀리셨습니다.";
				}
			}
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		resultMap.put("result", result);
		
		return resultMap;
	}
}
