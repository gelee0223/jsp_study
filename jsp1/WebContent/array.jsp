<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script>

var test = function(){
	this.a = "123";	// public
	var b = "456";	// private
	
	this.tt = function(){
		alert(b);
		alert("아~");
	}
	
	var tt2 = function(){	// private
		alert("tt2");
	}
	
	this.arr = {};	// 안에 구조는 function과 동일, 호출만 못할 뿐
	this.arr["key1"] = "value1";
	this.arr["key2"] = "value2";
	this.arr.key3    = "value3";
	
	var arr2 = new Array();
	arr2[0] = "1";
	arr2[1] = "2";
	arr2[2] = "3";
	
	this.arr.key4 = arr2;
	
	this.json = JSON.stringify(this.arr);
}


// function안에 function 선언이 가능 -> 클로져
function test1(){
	var t = new test();
	
	/*
	alert(t.arr["key1"]);
	alert(t.arr.key2);
	alert(t.arr["key3"]);
	// alert(t.arr); Object
	*/
	
	// alert(t.json);
	document.getElementById("r_div").innerHTML = t.json;
	
	var obj = JSON.parse(t.json);
	alert(obj.key4);
	
	// alert(t.json.key1);
	/*
	alert(t.a);
	alert(t.b);		// undefined
	t.tt();			// 함수 호출 여기서 b, 아~ 가 호출
	
	alert(t.tt);		// 변수 -> function 내용이 나옴
	*/
}	

/*
function test(){
	alert(1);	
}

function test(a){
	alert(2);
}

// JavaScript의 경우 overloading개념이 존재하지 않음, 두 번째 function이 호출됨
*/
/*var click = function(){
	alert(1);
}*/
</script>

<body>
<input type="button" value="click" onclick="test1()">
<div id="r_div"></div>
</body>
</html>