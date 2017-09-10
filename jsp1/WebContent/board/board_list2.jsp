<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp" %>

<title>게시판</title>
<script>

	function callback(result){
		
	 	/*
		$("#r_div").html(result);
		result = JSON.parse(result);
		alert(result.length);
		*/ 

		// result = JSON.parse(result);
		
		$("#table").bootstrapTable(
			{data : result}
		)
		
	}

	function getBoardList(content){
		var param = {};
		param["command"] = "list";
		
		if(content){
			param["content"] = content;
		}
		
		param = JSON.stringify(param);
		
		var ja = new JqAjax("list.board", param);
		ja.changeFunc(callback);
		ja.send();
	}
	
	/* $(document).ready(function(){

		// var param = "?command=list";
		// param = encodeURI(param);
		
		// var au = new AjaxUtil("list.board", param, "post");
		// au.changeCallBack(callback);
		// au.send(); 
		
		// var param = {};
		// param["command"] = "list";
		// param = JSON.stringify(param);
		
		var a = {
							type			: "POST"
						, 	url				: "list.board"
						, 	dataType	: "json"
						, 	beforeSend :	function(xhr){
							xhr.setRequestHeader("Accept", "application/json");
							xhr.setRequestHeader("Content-Type", "application/json");
						}
						, data				: param
						, success		: function(result){
							callback(result);
						}
						, error	: function(xhr, status, e){
							alert("에러 : " + e);
						}
						, complete	: function(e){
							
						}
		};
		
		// $.ajax(a); 
		
		var param = {};
		param["command"] = "list";
		param = JSON.stringify(param);
		
		var ja = new JqAjax("list.board", param, null, null);
		ja.changeFunc(callback);
		ja.send();

	}) */
	
	$(document).ready(function(){
		getBoardList();
		$("#btnSearch").click(function(){
			var searchStr = $("#searchStr").val().trim();
			
			if(!searchStr){
				alert("검색할 내용을 적어주세요!");
				$("#searchStr").val("");
				$("#searchStr").focus();
				
				return;
			}
			getBoarList(searchStr);
		});
	})
	
	
	
</script>
</head>
<body>
	<div class="search" align="right">
		<input type="text" name="searchStr" placeholder="내용" id="searchStr"/>
		<input type="button" value="검색" id="btnSearch"/>
	</div>
	<table id="table" data-height="268" class="table table-bordered table-hover">
		<thead>
			<tr>
				<th data-field="bNum" class="text-center">번호</th>
				<th data-field="title" class="text-center">제목</th>
				<th data-field="content" class="text-center">내용</th>
				<th data-field="writer" class="text-center">게시자</th>
				<th data-field="regDate" class="text-center">게시일자</th>
			</tr>
		</thead>
		<tbody id="r_tbody">
		</tbody>
	</table>
</body>
</html>