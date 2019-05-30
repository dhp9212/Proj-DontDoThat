<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>메인 화면</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		$(".logoutButton").unbind("click").click(function(e){
			e.preventDefault();
			fn_logout();
		});
	});
	
	function fn_logout(){
		window.location.href="logoutOk.do";
	}
</script>
</head>
<body>
	<a href="mySettings.do">상세 정보 설정</a>
	<button class="logoutButton" onclick="">로그아웃</button>
	<h1>메인 페이지에 연결 하세요!</h1>
</body>
</html>