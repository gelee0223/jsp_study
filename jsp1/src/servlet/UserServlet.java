package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.DBConnector;

// http://raw.githubusercontent.com/cnfree/eclipse/master/decompiler/update/

public class UserServlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			     throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		String name = request.getParameter("name");
		String[] hobbies = request.getParameterValues("hobby");
		
		String hobby = "";
		
		for(String h : hobbies) {
			hobby += h + ",";
		}
		
		hobby = hobby.substring(0, hobby.length() - 1);
		
		String result = "입력하신 ID : " + id + "<br>";
//		result += "입력하신 Password : " + pwd + "<br>";
//		result += "입력하신 이름 : " + name + "<br>";
		result += "입력하신 취미 : " + hobby + "<br>";
		
		Connection con;
		
		try{
			con = DBConnector.getConnector();
			
			String sql = "INSERT INTO user(id, name, password, hobby)";
			sql += " VALUES(?,?,?,?)";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, name);
			ps.setString(3, pwd);
			ps.setString(4, hobby);
			
			int row = ps.executeUpdate();	
			
			result = name + "님, 무슨 이유인지는 모르겠는데, 회원가입에 실패하셨습니다.";
			
			if(row == 1) {
				result = name + "님, 회원가입에 성공하셨습니다.";
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		doProcess(response, result);
		
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
				 throws ServletException, IOException {
		
    }
	
	public void doProcess(HttpServletResponse response, String writeStr)
			 throws IOException{
		response.setContentType("text/html; charset = UTF-8");
		PrintWriter out = response.getWriter();
		out.print(writeStr);
	}
	
}
