<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>비밀번호 설정 화면</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
		function goBack(){
			window.history.back();
		}
		
		$(document).ready(function() {
			$("#start").click(function passwordCheck(){
				var setPassword = $('input[name=setPassword]').val();//비밀번호 설정
				var confirmPassword = $('input[name=confirmPassword]').val();//비밀번호 확인
				var state = $(".passwordLengthLimit").css("display");
				if(setPassword.length < 8) {
					if(state == "none"){
						 $(".passwordLengthLimit").show();
					}
					//document.addjoin.setPassword.focus();
					return false;
				}else {
					if(setPassword != confirmPassword){
						$(".passwordLengthLimit").hide();
						$(".notPasswordMatch").show();
						//비밀번호가 일치하지 않아요.
						return false;
					}
				}
		        document.p.submit()
			});
		});
		
	</script>
	<style type="text/css">
		div.center_top{
		width:400px;
     	height:auto;
     	border:1px solid green;
     	margin:0px 0px 15px;
		}
		
		.center_bottom{
		width:400px;
     	height:auto;
     	border:1px solid blue;
     	margin:0px 0px 15px;
		}
		
		.center_top-back-DDT.comAccount-menu{
		border:1px solid black;
		}
		
		.passwordLengthLimit{
		color : red;
		display : none;
		}
		.notPasswordMatch{
		color : red;
		display : none;
		}
	</style>
</head>
<body>
	<div>
		<div class="center" align="center">
			<div class="center_top">
				<div class="center_top-back-DDT.comAccount-menu">
					<input type="button" name="back" onclick="goBack();" value="<"/>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="login.do">DDT.com Account</a>&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button value=":">
						:
					</button>
					<div class="center_top-setPassword">
						<div>
							<h4>비밀번호 설정</h4>
						</div>
						<div>
							<p>
								다음 DDT.com 계정에 대한 비밀번호를 설정하세요.<br>
								<strong>${email}</strong>
							</p>
						</div>
						<form name="p" action="passwordSettingsOk.do" method="post">
						<div class="center_top-setPassword-setPassword"><!-- 비밀번호 설정 라벨, 텍스트 -->
							<label>
								비밀번호 설정
							</label>
							<div>
							<input type="password" name="setPassword" required="required">
							</div>
							<div class="passwordLengthLimit">
								비밀번호는 최소 8자 이상이어야 합니다.
							</div>
						</div>
						<div class="center_top-setPassword-confirmPassword"><!-- 비밀번호 확인, 텍스트 -->
							<label>
								비밀번호 확인
							</label>
							<div>
							<input type="password" name="confirmPassword" required="required">
							</div>
							<div class="notPasswordMatch">
								비밀번호가 일치하지 않습니다. 다시 입력해주세요.
							</div>
						</div>
						<div>
							<button id="start" name="signUpButton" onclick="javascript:passwordCheck()">회원 가입</button>
						</div>
						</form>
					</div>
				</div>
			</div>
			
			<div class="center_bottom">
				<div class="">
				DDT.com 계정이 이미 있으신가요?
					<div>
						<a href="login.do">로그인</a>
						<div>
							<p>로그인 하거나 회원으로 가입하시면 당사 
								<a href="terms.do">이용약관</a>
								 및 
								<a href="privacy.do">개인정보 보호 정책</a>
								에 동의하시는 것으로 간주됩니다.	
							</p>
							<div>
								<p>
									<a href="">DDT.com 비즈니스</a>
									를 들어보셨나요?
								</p>
								<p>
									DDT.com에서 숙소를 제공해보세요! 
									<a href="">내 숙소 등록</a>
								</p>
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
	</div>
</body>
</html>