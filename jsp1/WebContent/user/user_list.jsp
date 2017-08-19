<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import  = "java.sql.Connection"%>
<%@ page import  = "java.sql.DriverManager"%>
<%@ page import  = "java.sql.ResultSet"%>
<%@ page import  = "java.sql.SQLException"%>
<%@ page import  = "java.sql.Statement"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String url   = "jdbc:mysql://localhost:3306/jsp_study";
String id    = "root";
String pwd = "159753";

Connection con;		
Statement st;

try {
	
	Class.forName("org.mariadb.jdbc.Driver");	// reflection (link .jar file)
	con = DriverManager.getConnection(url, id, pwd);
	
	System.out.println("연결 성공");
	
	st = con.createStatement();	// make query page
	ResultSet rs = st.executeQuery("select * from user where id = 'red'");	// rs : database가 넘겨주는 query에 대한 정보를 가짐. (meta data (key), real data)
	
	out.println("<table border='1'>");
	
	while(rs.next()) {	 // rs.next() !!! point .next 호출 전에는 rs는 meta dat와 real data 중간에 위치하고 있다고 생각하면 됨. next를 호출하지 못하면 data를 읽어올 수 없음
		out.println("<tr>");
		
		out.println("<td>");
		out.println(rs.getString("user_no") + " "); // (response.)out.print
		out.println("</td>");
		
		out.println("<td>");
		out.println(rs.getString("id") + " ");
		out.println("</td>");
		
		out.println("<td>");
		out.println(rs.getString("password") + " ");
		out.println("</td>");
		
		out.println("<td>");
		out.print(rs.getString("name"));
		out.println("</td>");
		
		out.println("</tr>");
	}
	
	out.println("</table>");
	
} catch (ClassNotFoundException e) {
	
	e.printStackTrace();
	 
} catch (SQLException e) {
	
	e.printStackTrace();
	
}
%>
</body>
</html>