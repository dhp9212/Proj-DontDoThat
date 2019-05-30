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
	</script>
	<style type="text/css">
		div.center_content{
		width:400px;
     	height:auto;
     	border:1px solid green;
     	margin:0px 0px 15px;
		}
		
		.bottom_content{
		width:400px;
     	height:auto;
     	border:1px solid blue;
     	margin:0px 0px 15px;
		}
		
		.emailAndPasswordAreDifferent{
		color : red;
		display : none;
		}

	</style>
</head>
<body>
<input type="hidden" name="wrongPassword" value="${wrongPassword}">
	<div id="backGround" align="center">
		<!-- 가운데로 정렬 -->
		<div class="center_content" align="center">
			<!-- 뒤로가기, 로그인, 메뉴 -->
			<div id="center_top">
				<input type="button" name="back" onclick="goBack();" value="<"/>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="login.do">DDT.com Account</a>&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button value=":">
					:
				</button>
			</div>
		
			<!-- 이메일 주소 입력, 다음 버튼, facebook 버튼, google 버튼, naver 버튼, 회원가입으로 이동 -->
			<div id="center_center">
				<h4>로그인</h4>
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
				</div>
				<input id="start" type="submit" value="로그인"/>
				<div id="center_bottom">
				 - 또는 클릭 한번으로 로그인 - 
					<div id="center_access">
						<a id="fb" href="">facebook</a>
						<a id="gg" href="">google</a>
						<a id="nv" href="">naver</a>
					</div>
					<div>
						<a href="#">비밀번호를 잊으셨나요?</a>
					</div>
				</div>
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
						<div>
							<div>
								<p>
									한국어(언어 설정 부분)
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>		
		</div>
	</div>
</body>
</html>