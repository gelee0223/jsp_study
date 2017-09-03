<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/common/header.jsp" %>

<style>
.btn {
    border: none;
    color: white;
    padding: 10px 20px;
    font-size: 12px;
    cursor: pointer;
}

.logout {background-color: #e7e7e7; color: black;} /* Gray */ 
.logout:hover {background: #ddd;}

.delete{background-color: #f44336;} /* Red */ 
.delete:hover {background: #da190b;}

.update {background-color: #ff9800;} /* Orange */
.update:hover {background: #e68a00;}

.list{background-color: #4CAF50;} /* Green */
.list:hover {background-color: #46a049;}

.golist{background-color: #4CAF50;} /* Green */
.golist:hover {background-color: #46a049;}

</style>
</head>

<script>
$(document).ready(function(){
	$("input[type='button']").click(function(){
		var value = this.value;
		
		var url = this.getAttribute("data-url");
		var urls = url.split(".");
		
		// alert(url);	// data- : custom tag	
		/*
		if(urls[1] == "jsp"){
			location.href = url;
		}
		*/
		if(urls[1].indexOf("jsp") != -1){
			location.href = url;
		}
		else{
			$("#command").val(urls[0]);
			this.form.submit();
		}
		
		return;
		
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

<%
String userNo = "";
String id = "";
String name = "";
String hobby = "";

if(user != null){
	id = user.get("id");
	userNo = user.get("user_no");
	name = user.get("name");
	hobby = user.get("hobby");
	
	String result = userNo + "번째로 가입하신 " + name + "님 반갑습니다.<br>";
	result += name + "님의 id는 " + id + "이며 취미는 아래와 같습니다.<br>";
	result += "취미 : " + hobby;
	out.println(result);
%>
<form action="some.user" method="post">
<input type="button"  class="btn logout" value="로그아웃" data-url="logout.user">
<input type="button"  class="btn delete" value="회원탈퇴" data-url="delete.user">
<input type="button"  class="btn update" value="회원정보수정" data-url="/user/update.jsp?user_no=<%=userNo%>">
<input type="button"  class="btn list" value="회원리스트" data-url="/user/list.jsp">
<input type="button"  class="btn golist" value="게시판가기" data-url="/board/board_list.jsp">
<input type="hidden" name="command"  id="command" value="logout"> 
<input type="hidden" name="userNo" value="<%=userNo%>">
</form>
<%
}
%>
</body>
</html>