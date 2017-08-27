<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> <!--  include를 하더라도 따라가지 않아 해 주어야 함 -->
<%@ include file= "/common/header.jsp" %>	<!--  include 파일은 java파일로 만들지 않음, header.jsp를 그대로 받은 상태에서 java 파일로 생성 -->
<title>Insert title here</title>
</head>

<script>
$(document).ready(function(){
	$("form[action='list.user']").submit();
});
</script>

<body>
<form action="list.user" method="post">
<input type="hidden" name="command" value="list">
</form>
</body>
</html>