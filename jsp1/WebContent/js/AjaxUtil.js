
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