<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ include file="/common/header.jsp" %>
<!--  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 -->
<title>로그인</title>

<style>
body{
	background-color : skyblue; 
}

p {
    text-align: center;
    margin-top: 300px;
} 


</style>
</head>

<script src="/js/jquery-3.2.1.min.js"></script>
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
		/*
		if(value == "로그아웃"){
			this.form.submit();
		}
		*/
	})
})
</script>

<body>
<%--=request.getParameter("id")--%>
<%-- out.println("<br>"); --%>
<%--
String login = null;									// String login = "false";

if(session.getAttribute("id") != null){ 			// session.getAttribute("login").equals("false")
	login = (String)session.getAttribute("id");	// login = (String)session.getAttribute("login");
}
if(login == null){									// if(login.equals("false")){
--%>
<%
/*
Map<String, String> user = null;
if(session.getAttribute("user") != null){ 			
	user = (Map<String, String>)session.getAttribute("user");	
}
*/
if(user == null){	
%>

<script>
/*
var AjaxUtil = function(p_url, p_params, p_method, p_aSync){
	
	if(!p_url || p_url.trim() == ""){
		alert("AjaxUtil호출시 url은 필수 입니다.");
		return;
	}
	
	this.params = p_params;
	
	var getHttpXmlObj = function(){
		if(window.XMLHttpRequest){
	  		return new XMLHttpRequest();
	 	}
		else if(window.ActiveXObject){
	  		return new ActiveXObject("Microsoft.XMLHTTP");
	 	}
		alert("해당 브라우져가  Ajax를 지원하지 않습니다.");
	}
	
	this.xhr = getHttpXmlObj();
	var method = p_method ? p_method : "get";
	var url = p_url;
	var aSync = p_aSync ? p_aSync : true; 	// true;	// 비동기 -> false일 때, 동기
	
	this.xhr.callback = null;
	
	this.xhr.onreadystatechange=function(){
   		if (this.readyState==4){	// readyState : 0 ~ 4 / 4 : server에서 결과값을 준 상태
   			if(this.status==200){	// 200 ~ 209 : 성공했다는 의미 (그 외의 값들은 error)
	   			var result = decodeURIComponent(this.responseText);
   		
   				if(this.callback){
   					this.callback(result);
   				}
   				else{
   					alert(result);
   				}
   		
   			}
   			else{
   				var result = decodeURIComponent(this.responseText);
   				alert(result);
   			}
   			
   		}
	}
	
	this.changeCallBack = function(func){
		// this.xhr.onreadystatechange = func;
		this.xhr.callback = func;
	}
	
   	this.xhr.open(method, url+this.params, aSync);	// 연결 준비
   	
   	this.send = function(){
   		this.xhr.send.arguments = this;
   	   	this.xhr.send();
   	}
}
*/
$(document).ready(function(){
	
	$("input[type='button']").click(function(){
		var value = this.value;
		
		if(value == "회원가입"){
			location.href = "/user/signin.jsp";
			return;
		}
		
		else if(value == "로그인"){
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
			
			
			// param = JSON.stringify(param);
			// alert(param);
			
			param = "?command=login&param=" + JSON.stringify(param);
			param = encodeURI(param);
			
			var au = new AjaxUtil("test.user", param, "post");
			au.changeCallBack(callback);
			au.send();
			
			return;
		}
	})
	
	/*
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
		
		
		// param = JSON.stringify(param);
		// alert(param);
		
		param = "?command=login&param=" + JSON.stringify(param);
		param = encodeURI(param);
		
		var au = new AjaxUtil("test.user", param, "post");
		au.changeCallBack(callback);
		au.send();
		
	});
	*/
})

function callback(result){
	var re = JSON.parse(result);
	alert(re.result);
	location.href = re.url;
}

</script>
<form action="login.user" method="post">	
<p>
아이디 : <input type="text" name="id1" id="id"><br>
비밀번호 : <input type="password" name="pwd1" id="pwd"><br>
<input type="button" id="btnLogin" value="로그인">	
<input type="button" id="btnInsert" value="회원가입">
<input type="hidden" name="command" value="login">	<!-- Controller를 Command 방식으로 분기 -->
</p>
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