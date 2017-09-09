<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp" %>
<title>게시판</title>
<script>

	function callback(result){
		$("#r_div").html(result);
		result = JSON.parse(result);
		alert(result.length);
	}

	$(document).ready(function(){

		var param = "?command=list";
		param = encodeURI(param);
		
		var au = new AjaxUtil("list.board", param, "post");
		au.changeCallBack(callback);
		au.send();
		
	})
	
</script>
</head>
<body>
<div id="r_div"></div>
<table border="1">
	<tr>
		<th>번호</th>
		<th>이름</th>
		<th>내용</th>
		<th>생성자</th>
		<th>생성일자</th>
	</tr>
	<tbody id="r_tbody">
	
	</tbody>
</table>
게시판리스트입니다.
</body>
</html>