<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/common/header.jsp" %>
<title>회원정보 수정</title>
</head>
<body>
<!--  <script src="/js/jquery-3.2.1.min.js"></script> -->
<script>
$(document).ready(function(){
	var params = {};
	params["user_no"] = "<%=request.getParameter("user_no")%>";
	params = "?command=view&param=" + JSON.stringify(params);
	params = encodeURI(params);
	
	var au = new AjaxUtil("update.user", params, "post");
	au.changeCallBack(callback);
	au.send();
})

function callback(result){
	var obj = JSON.parse(result);
	$("#name").val(obj.name);
	$("#id").val(obj.id);
	
	var hobbies = obj.hobby.split(",");
	
	for(var i = 0, max = hobbies.length ; i < max ; i++){
		$("input[value='" + hobbies[i] + "']").prop("checked", true);
	}
	$("#userNo").val(obj.user_no);
	
	//alert(result);
}

function check(){
	var nameValue = $("#name").val().trim();
	var pwdValue  = $("#pwd").val().trim();
	
	if(nameValue == ""){
		alert("이름이 공백이면 안 됩니다.");
		$("#name").val("");
		$("#name").focus();
		return false;
	}
	else if(pwdValue == ""){
		alert("비밀번호가 공백이면 안 됩니다");
		$("#pwd").val("");
		$("#pwd").focus();
		return false;
	}
	
	return true;
}
</script>
<form action="update.user" method="post" onsubmit="return check()">	<!--  함수명이 check -->
<table border="1">
	<tr>
		<td colspan="2">회원정보 수정</td>
	</tr>
	<tr>
		<td>아이디</td>
		<td><input type="text" name="id" id="id" readonly></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="pwd" id="pwd"></td>
	</tr>
	<tr>
		<td>이름</td>
		<td><input type="text" name="name" id="name"></td>
	</tr>
	<tr>
		<td>취미</td>
		<td>
			<input type="checkbox" name="hobby" value="수면">수면
			<input type="checkbox" name="hobby" value="음악">음악
			<input type="checkbox" name="hobby" value="영화">영화
			<input type="checkbox" name="hobby" value="게임">게임
			<input type="checkbox" name="hobby" value="요리">요리
			<input type="checkbox" name="hobby" value="여행">여행
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center"><input type="submit" value="회원정보 수정" ></td>
	</tr>	
</table>
<!--  
아이디 : <input type="text" name="id1" id="id"><br>
비밀번호 : <input type="password" name="pwd1" id="pwd"><br>
<input type="submit" value="로그인">
 -->
<input type="hidden" name="command" value="update">
<input type="hidden" name="userNo" id="userNo">
</form>

</body>
</html>