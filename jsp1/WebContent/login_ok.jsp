<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import  = "java.sql.Connection"%>
<%@ page import  = "java.sql.DriverManager"%>
<%@ page import  = "java.sql.ResultSet"%>
<%@ page import  = "java.sql.SQLException"%>
<%@ page import  = "java.sql.PreparedStatement"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<%
String id = request.getParameter("id1");
String pwd = request.getParameter("pwd1");

String dbUrl   = "jdbc:mysql://localhost:3306/jsp_study";
String dbId    = "root";
String dbPwd = "159753";

Connection con = null;		
PreparedStatement ps;

String result = id + "없는 아이디입니다.";

// boolean login = false;

try {
	
	Class.forName("org.mariadb.jdbc.Driver");
	con = DriverManager.getConnection(dbUrl, dbId, dbPwd);
	
	System.out.println("연결 성공");
	
	String sql = "select * from user where id = ?"; // and pwd = ?";
	ps = con.prepareStatement(sql);	// make query page with PreparedStatement
	ps.setString(1, id);	// setString은 알아서 ''을 만들어줌 (첫 번째 param은 ?에 따라서 ~번째)
	// ps.setString(2, pwd);
	ResultSet rs = ps.executeQuery();	// 선 parsing 후, query 실행 (prepareStatement 먼저 parsing 하여 메모리에 올린 후, 이후에는 안함)
	
	// out.println("<table border='1'>");
	
	while(rs.next()) {	 
		if(pwd.equals(rs.getString("password"))) {
			result = ("로그인에 성공하셨네요");
			session.setAttribute("login", "true");
			session.setAttribute("id", id);
		}
		else{
			result = ("비밀번호가 틀리셨습니다.");
		}
	}
	
	// out.println("</table>");
	
} catch (ClassNotFoundException e) {
	
	e.printStackTrace();
	 
} catch (SQLException e) {
	
	e.printStackTrace();
	
}
finally{
	
	if(con != null){
		con.close();
	}
}
%>
<script>
	alert("<%=result%>");
	location.href="/login.jsp";
</script>

</body>
</html>