<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp" %>

<title>게시판</title>
<script>

	var gParam, gPage;

	function callback(result){
		
	 	/*
		$("#r_div").html(result);
		result = JSON.parse(result);
		alert(result.length);
		*/ 

		// result = JSON.parse(result);
		
		if(result.error){
			alert(result.error);
			return;
		}
		
		var list = result.list;
		
		gParam = result.param;
		gPage = result.page;
		makePagination(gPage,"page"); 
		setEvent(gPage,gParam , "/list.board");
		
		var pageStr = "";
		
		for(var i=0,max=page.totalBlock;i<max;i++){
			pageStr += (i+1) + ",";
		}
		
		$("#page_div").html(pageStr);
		$("#total_div").html("총 갯수 : " + gPage.totalCnt);
		$("#table").bootstrapTable('destroy');
		$("#table").bootstrapTable(
			{data : list}
		);
		
	}

	function getBoardList(content){
		var param = {};
		param["command"] = "list";
		
		if(content){
			param["content"] = content;
		}
		
		var page = {};
		page["nowPage"] = 1;
		page["rowCnt"] = 20;
		param = "param=" + JSON.stringify(param);
		param += "&page=" + JSON.stringify(page);
		
		var ja = new JqAjax("list.board", param);
		ja.changeFunc(callback);
		ja.send();
		
		/*
		param = JSON.stringify(param);
		
		var ja = new JqAjax("list.board", param);
		ja.changeFunc(callback);
		ja.send();*/
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
			getBoardList(searchStr);
		});
	})
	
	function makePagination(pageInfo, objId){
		
		var sNum = pageInfo.startBlock;
		var eNum = pageInfo.endBlock;
		var nPage = pageInfo.nowPage;
		var nTotal = pageInfo.totalPageCnt;
		var pageStr = "";
		
		if(nPage==1){
			pageStr += "<li class='disabled'><a >◀◀</a></li>";
			pageStr += "<li class='disabled' ><a >◀</a></li>";
		}
		else{ 
			pageStr += "<li><a>◀◀</a></li>";
			pageStr += "<li><a>◀</a></li>";
		}
		
		for(var i=sNum, max=eNum;i<=max;i++){
			if(i==nPage){
				pageStr += "<li class='active'><a>" + i + "</a></li>";
			}
			else{
				pageStr += "<li><a>" + i + "</a></li>";
			}
		}
		
		if(nPage.equals(nTotal)){
			pageStr += "<li class='disabled'><a>▶</a></li>";
			pageStr += "<li class='disabled'><a>▶▶</a></li>";
		}
		else{ 
			pageStr += "<li><a>▶</a></li>";
			pageStr += "<li><a>▶▶</a></li>";
		}
		$("#" + objId).html(pageStr);
	}
	
	function setEvent(pageInfo, params, pUrl){
		$("ul[class='pagination']>li:not([class='disabled'],[class='active'])>a").click(function(){
			
			var thisNowPage = pageInfo.nowPage;
			var goPageNum = new Number(this.innerHTML);
			
			if(isNaN(goPageNum)){
				if(this.innerHTML=="◀"){
					thisNowPage -= pageInfo.blockCnt;
				}
				else if(this.innerHTML=="◀◀"){
					thisNowPage = 1;
				}
				else if(this.innerHTML=="▶"){
					thisNowPage += pageInfo.blockCnt;
				}
				else if(this.innerHTML=="▶▶"){
					thisNowPage = pageInfo.totalPageCnt;
				}
			
				if(thisNowPage<=0){
					thisNowPage = 1;
				}
				else if(thisNowPage>pageInfo.totalPageCnt){
					thisNowPage = pageInfo.totalPageCnt;
				}
				goPageNum = thisNowPage;
			}
			
			gPage["nowPage"] = goPageNum;
			
			var param = "param=" + JSON.stringify(gParam);
			param += "&page=" + JSON.stringify(gPage);
			
			var ja = new JqAjax("list.board",param); 
			ja.changeFunc(callback); 
			ja.send();
		})
	}
	
</script>
</head>
<body>
	<div class="container">
	<div id="error_div"></div>
	<div id="total_div"></div>
		내용 :
	<div class="search" align="right">
		<input type="text" name="searchStr" placeholder="내용" id="searchStr"/>
		<input type="button" value="검색" id="btnSearch"/>
	</div>
	<table id="table" data-height="400" class="table table-bordered table-hover">
		<thead>
			<tr>
				<th data-field="bNum" class="text-center">번호</th>
				<th data-field="title" class="text-center">제목</th>
				<th data-field="content" class="text-center">내용</th>
				<th data-field="writer" class="text-center">게시자</th>
				<th data-field="userName" class="text-center">게시자명</th>
				<th data-field="regDate" class="text-center">게시일자</th>
			</tr>
		</thead>
		<tbody id="r_tbody">
		</tbody>
	</table>
	</div>
	<div class="jb-center" style="text-align: center">
		<ul class="pagination" id="page">
		</ul>
	</div>
</body>
</html>