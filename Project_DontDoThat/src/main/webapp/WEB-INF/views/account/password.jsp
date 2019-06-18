<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인 화면</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
		function goBack(){
			window.history.back();
		}
		
		$(document).ready(function() {
			var state = $(".emailAndPasswordAreDifferent").css("display");
			if($('input[name=wrongPassword]').val()=='비밀번호 틀림'){
				if(state == "none"){ // state가 none 상태일경우 .")
					$(".emailAndPasswordAreDifferent").show();
				}
				document.addjoin.password.focus();
				return false;
			}
		});
		
		$(document).ready(function(){
			$("#temporaryPassword").click(function temporaryPassword(){
			alert("고객님의 이메일로 임시 비밀번호를 발송 했습니다.")
			});
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
     	margin:0px 0px 15px;
		}
		
		.emailAndPasswordAreDifferent{
		color : red;
		display : none;
		}
		
		#backButton{
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
		}

	</style>
</head>
<body>
<input type="hidden" name="wrongPassword" value="${wrongPassword}">
	<div id="backGround" align="center">
		<!-- 가운데로 정렬 --><br><br><br><br>
		<div class="center_content" align="center">
			<!-- 뒤로가기, 로그인, 메뉴 -->
			<div id="center_top">
				<input id="backButton" type="button" name="back" onclick="goBack();" value="<"/>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="login.do" style="color:#0033cc;"><b>DDT.com Account</b></a>&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
		
			<!-- 이메일 주소 입력, 다음 버튼, facebook 버튼, google 버튼, naver 버튼, 회원가입으로 이동 -->
			<div id="center_center">
				<h1>로그인</h1>
				<p id="guide">다음 Booking.com 계정에 대한 비밀번호를 입력하세요.<br>
					<strong>${email}</strong>
				</p>
				<form name="f" action="loginOk.do" method="post">
					<div id="center_password">
						<div>
							<label>DDT.com 비밀번호</label>
						</div>
						<input type="password" name="password">
					</div>
					<div class="emailAndPasswordAreDifferent">
						이메일 주소와 비밀번호의 조합이 일치하지 않습니다.
					</div><br>
					<input id="start" type="submit" value="로그인"/><br><br>
					<div id="center_bottom">
						<div>
							<a href="temporaryPassword.do" id="temporaryPassword" onkeypress="JavaScript:press(this.form)">비밀번호를 잊으셨나요?</a>
						</div>
					</div>
				</form>
			</div><br>
		</div>
		
		<div class="bottom_content">			
			<p>로그인 하거나 회원으로 가입하시면 당사 
				<a href="terms.do">이용약관</a>
				 및 
				<a href="privacy.do">개인정보 보호 정책</a>
				에 동의하시는 것으로 간주됩니다.	
			</p>
		</div>
	</div>
</body>
</html>