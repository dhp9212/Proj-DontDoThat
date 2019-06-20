<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>로그인 화면</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
		function goBack()
		{//뒤로가기
			window.history.back();
		}
		
		function press(key){
			if(key.keyCode == 13){
			window.l.nextButton();
			}
		}
		
		function check(){
			var email = document.getElementById("email").value;//id가 email인 것의 값을 가져온다.
			var validation = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;//유효성 검사
			var state = $("#userEmailError").css("display");// state 변수에 ID가 moreMenu인 요소의 display의 속성을 '대입'
			
			if(validation.test(email)==false){ //이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우		
		        if(state == "none"){ // state가 none 상태일경우 
		            $(".userEmailError").show(); // class가 userEmailError인 요소를 show();
		            $(".userEmailNone").hide();
		        }
		   		return false
			}
			return true
		}
		$(document).ready(function(){
			if($('input[name=emailNone]').val()=='없음'){
				$(".userEmailNone").show();
			}
		});		
	</script>
	<style type="text/css">
		div.center_content{
		width:400px;
     	height:auto;
     	margin:0px 0px 15px;
		}
		
		.bottom_content{
		width:400px;
     	height:auto;
     	/* border:1px solid blue; */
     	margin:0px 0px 15px;
		}
		
		.userEmailError{
		color : red;
		display : none;
		}
		.userEmailNone{
		color : red;
		display : none;
		}
		#backButton{
		align : left;
		color:#0033cc;
		background-color:white;
		border:none;
		}
		
		
		#start{
		color:white;
		background-color:#0033cc;
		width:175px;
		border:none;
		padding:4px;
		margin-left:6px;
		}
		
	</style>
</head>
<body>
<input type="hidden" name="emailNone" value="${emailCheckNone}">
	<div id="backGround" align="center">
		<!-- 가운데로 정렬 --><br><br><br><br>
		<div class="center_content">
			<!-- 뒤로가기, 로그인, 메뉴 -->
			<div id="center_top">
				<strong><input type="button" id="backButton" name="back" onclick="goBack();" value="<"/></strong>&nbsp;&nbsp;&nbsp;&nbsp;
				<a style="color:#0033cc;"><b>DDT.com Account</b></a>&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
		
			<!-- 이메일 주소 입력, 다음 버튼, facebook 버튼, google 버튼, naver 버튼, 회원가입으로 이동 -->
			<div id="center_center">
				<h1>로그인</h1>
				<p id="guide">DDT.com 계정으로 로그인하여 서비스를 이용하실 수 있습니다.</p>
			<form name="l" action="password.do" method="post" onsubmit="return check()">
				<div id="center_email">
					<div>
						<label>이메일 주소</label>
					</div>
					<input type="text" name="email" id="email" value="${email}" onkeypress="press(this.form)" >
					<div class="userEmailError" id="userEmailError">
						입력하신 이메일 주소가 정확한지 확인해주세요.
					</div>
					<div class="userEmailNone">
						이 이메일 주소로 등록된 계정이 없습니다. 
						<a href="signUp.do">회원가입</a> 
						후 서비스를 이용해 주세요.
					</div>
				</div><br>
				<input id="start" name="next" type="submit" value="다음" title="nextButton" style="cursor:pointer;"/>
				<br><br>
				<div id="center_bottom">
					<div>
						<label>${emailCheckNone}</label>
						<label>아직 계정이 없으신가요? <a href="signUp.do">가입하기</a></label>
					</div>
				</div><br>
			</form>
			</div>
		</div>
		
		<div class="bottom_content">		
			<div class="">
				<div>					
					<div>
						<p>로그인 하거나 회원으로 가입하시면 당사 
							<a href="terms.do">이용약관</a>
							 및 
							<a href="privacy.do">개인정보 보호 정책</a>
							에 동의하시는 것으로 간주됩니다.	
						</p>
					</div>
				</div>
			</div>		
		</div>
	</div>
</body>
</html>