<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="red" value="빨강이야~~"/>
<title>게시판</title>
</head>
<body>
<!--  ${test} <%--=request.getAttribute("test")--%>  -->

 
<table border="1">
	<tr>
		<th>번호</th>
		<th>이름</th>
		<th>내용</th>
		<th>생성자</th>
		<th>생성일자</th>
	</tr>
	<c:forEach items="${boardList}" var="b">
	<tr>
		<td>${b.bNum}</td>
		<td>${b.title}</td>
		<td>${b.content}</td>
		<td>${b.writer}</td>
		<td>${b.regDate}</td>
	</tr>
	</c:forEach>
</table>

<!-- 
<table border="1">
	<tr>
		<th>이름</th>
		<th>나이</th>
	</tr>
	<c:forEach items="${ul}" var="ul">
	<tr>
		<td>${ul.name}</td>
		<td>${ul.age}</td>
	</tr>
	</c:forEach>
</table>
게시판 리스트입니다.
 -->
</body>
</html>