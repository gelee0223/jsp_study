<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ include file="/common/header.jsp" %>
 <script src="/js/jquery-3.2.1.min.js"></script>
 <link rel="stylesheet" href="/ui/signin.css"/>

<title>로그인</title>
</head>

<script>
$(document).ready(function(){
	$("input[type='button']").click(function(){
		if(this.getAttribute("id") == "btnLogin"){
			return;
		}
		var value = this.value;
		
		if(value == "회원탈퇴"){
			$("#command").val("delete");
		}
		else if(value == "회원정보수정"){
			location.href = "/user/update.jsp";
			return;
		}
		else if(value == "회원리스트"){
			location.href = "/user/list.jsp";
			return;
		}
		this.form.submit();
		
	})
})
</script>

<body>
<%
if(user == null){	
%>

<script>
$(document).ready(function(){
	
	$("#btnLogin").click(function(){
		var idValue = $("#id").val().trim();
		var pwdValue = $("#pwd").val().trim();
		
		if(idValue == ""){
			alert("아이디를 적어주세요!")
			$("#id").val("");
			$("#id").focus();
			return;
		}
		
		if(pwdValue == ""){
			alert("비밀번호를 입력해 주세요!");
			$("#pwd").val("");
			$("#pwd").focus();
			return;
		}
		
		var param = {};
		param["id"] = idValue;
		param["pwd"] = pwdValue;
		
		param = "?command=login&param=" + JSON.stringify(param);
		param = encodeURI(param);
		
		var au = new AjaxUtil("test.user", param, "post");
		au.changeCallBack(callback);
		au.send();
		
	});
	
})

function callback(result){
	var re = JSON.parse(result);
	alert(re.result);
	location.href = re.url;
}


</script>
<!-- 
<form action="login.user" method="post">	
<p>
아이디 : <input type="text" name="id1" id="id" class="test"><br>
비밀번호 : <input type="password" name="pwd1" id="pwd"><br>
<input type="button" id="btnLogin" value="로그인">	
<input type="button" id="btnInsert" value="회원가입">
<input type="hidden" name="command" value="login">	
</p>
</form>
 -->
<!--  
<form action="login.user" method="post">	
아이디 : <input type="text" name="id1" id="id"><br>
비밀번호 : <input type="password" name="pwd1" id="pwd"><br>
<input type="submit" value="로그인">
<input type="hidden" name="command" value="login">
</form>
-->

	<div class="container">
		<form class="form-signin" action="/user/login_ok.jsp">
			<h2 class="form-signin-heading">Please login</h2>
			<label for="inputEmail" class="sr-only">ID</label> <input type="text"
				id="id" name="id" class="form-control" placeholder="ID" required
				autofocus> <label for="inputPassword" class="sr-only">Password</label>
			<input type="password" name="pwd" id="pwd" class="form-control"
				placeholder="Password" required>
			<div class="checkbox">
				<label> <input type="checkbox" value="remember-me">
					Remember me
				</label>
			</div>
			<button id="btnLogin" class="btn btn-lg btn-primary btn-block"
				type="button">Login</button>
		</form>

	</div>


<%
}
else{
	// out.println(session.getAttribute("id") + "님 환영합니다.");
	
	String id = user.get("id");
	String userNo = user.get("user_no");
	String name = user.get("name");
	String hobby = user.get("hobby");
	
	String result = userNo + "번째로 가입하신 " + name + "님 반갑습니다.<br>";
	result += name + "님의 id는 " + id + "이며 취미는 아래와 같습니다.<br>";
	result += "취미 : " + hobby;
	out.println(result);
	
	/*
	String id = (String)session.getAttribute("id");
	String userNo = (String)session.getAttribute("user_no");
	String name = (String)session.getAttribute("name");
	String hobby = (String)session.getAttribute("hobby");
	
	String result = userNo + "번째로 가입하신" + name + "님 반갑습니다.<br>";
	result += name + "님의 id는 " + id + "이며 취미는 아래와 같습니다.<br>";
	result += "취미 : " + hobby;
	out.println(result);
	*/

%>
<form action="some.user" method="post">
<input type="button" value="로그아웃">
<input type="button" value="회원탈퇴">
<input type="button" value="회원정보수정">
<input type="button" value="회원리스트">
<input type="hidden" name="command"  id="command" value="logout"> 
<input type="hidden" name="userNo" value="<%=userNo%>">
</form>
<%
}
%>
</body>
</html>