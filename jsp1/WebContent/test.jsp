<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script src="/js/jquery-3.2.1.min.js"></script>
<script>

$(document).ready(function(){
	$("#btn1").click(function(){
		var name = $("#name").val();
		var age   = $("#age").val();
		var result = "이름 : " + name;
		result += " 나이 : " + age;
		$("#result_div").html(result);
	})
})

/*
function test(){
	
	// alert($("#name").val());	// # : 무조건 id를 바라봄 (selector)
	// alert($("input[name='nameInput']").val()) // #이 없으면 tag를 의미
	var name = $("#name").val();
	var age   = $("#age").val();
	
	var result = "이름 : " + name;
	result += " 나이 : " + age;
	
	$("#result_div").html(result);	// =
	// $("#result_div").append(result);	// +=
	
	
	// alert("test.jsp페이지에 오셨습니다.");
	// var nameObj = document.getElementById("name");
	// alert(nameObj.value);
	
}	

function test1(){
	var name = document.getElementById("name").value;
	var age   = document.getElementById("age").value;
	var result = "이름 : " + name + " 나이 : " + age;
	document.getElementById("result_div").innerHTML = result;
}
*/
</script>

<body>

이름 : <input type="text" name="name" id="name">
<br>
나이 : <input type="text" name="age" id="age">
<br>
<div id="result_div">아무값</div>	<!--  중간에 들어가는 값이 변수라고 생각하면 됨 -->
<!--  <input type="button" value="클릭해버려" onclick="test()"/> -->
<input type="button" value="클릭해버려" id="btn1"/>

</body>


</html>