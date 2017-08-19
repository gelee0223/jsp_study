<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.util.List, java.util.ArrayList" %>
<!-- <%@ page import ="java.util.ArrayList" %> -->
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
int num1 = Integer.parseInt(request.getParameter("num1"));
String op = request.getParameter("op");
int num2 = Integer.parseInt(request.getParameter("num2"));

int result = 0;

switch(op){
	case "+":
		result = num1 + num2;
		break;
	
	case "-":
		result = num1 - num2;
		break;
		
	case "*":
		result = num1 * num2;
		break;
		
	case "/":
		result = num1 / num2;
		break;			
}
out.print(num1 + " " + op + " " +  num2 + " = " + result + "<br>");

List<String> list = new ArrayList<String>();

for(int i = 10 ; i <= 100 ; i += 10){
	list.add(Integer.toString(i));
}

for(int i = 0 ; i < list.size() ; i++){
	out.println(list.get(i) + "<br>");
}

out.println("<br>");

for(String str : list){
	out.println(str + "<br>");
}

%>
</body>
</html>