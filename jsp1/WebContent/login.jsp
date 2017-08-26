<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%=request.getParameter("id") %>
<%
String login = null;									// String login = "false";

if(session.getAttribute("id") != null){ 			// session.getAttribute("login").equals("false")
	login = (String)session.getAttribute("id");	// login = (String)session.getAttribute("login");
}
if(login == null){									// if(login.equals("false")){
%>

<form action="login.user" method="post">	
아이디 : <input type="text" name="id1" id="id"><br>
비밀번호 : <input type="password" name="pwd1" id="pwd"><br>
<input type="submit" value="로그인">	
<input type="hidden" name="command" value="login">	<!-- Controller를 Command 방식으로 분기 -->
</form>

<!--  
<form action="login.user" method="post">	
아이디 : <input type="text" name="id1" id="id"><br>
비밀번호 : <input type="password" name="pwd1" id="pwd"><br>
<input type="submit" value="로그인">
<input type="hidden" name="command" value="login">
</form>
-->
<%
}
else{
	// out.println(session.getAttribute("id") + "님 환영합니다.");
	out.println(login + "님 환영합니다.");
}
%>
</body>
</html>