<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>회원등록</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
			$(document).ready(function(){ //DOM이 준비되고
			    $('#toggleButton').click(function(){ // ID가 toggleButton인 요소를 클릭하면
			        var state = $('#dropdown_menu').css('display'); // state 변수에 ID가 moreMenu인 요소의 display의 속성을 '대입'
			        if(state == 'none'){ // state가 none 상태일경우 
			            $('#dropdown_menu').show(); // ID가 moreMenu인 요소를 show();
			        }else{ // 그 외에는
			            $('#dropdown_menu').hide(); // ID가 moreMenu인 요소를 hide();         
			        }
			    });
			});
		
			function goBack(){
				window.history.back();
			}
			function check(){
				var email = document.getElementById("email").value;//id가 email인 것의 값을 가져온다.
				var validation = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;//유효성 검사
				var state = $("#userEmailError").css("display");// state 변수에 ID가 moreMenu인 요소의 display의 속성을 '대입'
				
				if(validation.test(email)==false){ //이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우		
			        if(state == "none"){ // state가 none 상태일경우 
			            $(".userEmailError").show(); // class가 userEmailError인 요소를 show();
			            $(".userHasEmail").hide();
			        }
			   		return false
				}
				return true
			}
			$(document).ready(function(){
				if($('input[name=email]').val()==0){
					$(".userHasEmail").hide();
				}
			});
	</script>
	<style type="text/css">
     	#center_center{
     	width:400px;
     	height:auto;
     	margin:0px 0px 15px;
     	}
     	.hide.label{
     	color:purple;
     	}
     	#hide{
     	color:red;
     	}
     	p#guide{
     	width:300px;
     	}
     	#bottom_content{
     	width:400px;
     	height:auto;
     	}
     	#fb{
     	padding:10px 12px;
     	}
     	#gg{
     	padding:10px 12px;
     	}
     	#nv{
     	padding:10px 12px;
     	}
     	.userEmailError{
		color : red;
		display : none;
		}
		.userHasEmail{
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
<input type="hidden" name="hasEmail" value="${hasEmail}">
	<div align="center" id="backGround">
		<br><br><br><br>
		<div id="center_center">
			<div id="center_top">
				<input id="backButton" type="button" name="goBack" onclick="goBack();" value="<"/>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="login.do" style="color:#0033cc;"><b>DDT.com Account</b></a>&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
			<h1>회원 가입</h1>
			<p id="guide">회원으로 가입하여 DDT.com 서비스를 간편하게 이용하세요.</p>
		<form name="c" action="checkAccount.do" method="post" onsubmit="return check()">
			<div id="center_email">
				<div>
					<label>이메일 주소</label>
				</div>
				<input type="text" name="email" id="email" value="${email}">
				<div class="userEmailError" id="userEmailError">
						입력하신 이메일 주소가 정확한지 확인해주세요.
				</div>
				<div class="userHasEmail" id="userHasEmail" style="display:none;">
					<label>
						${email} 주소로 DDT.com에 가입되어 있습니다. 해당 주소로
						<a href="login.do">로그인</a>
						하세요.
					</label>
				</div>
			</div><br>
			<input id="start" name="next" type="submit" value="시작하기" onclick="javascript:emailCheck()" style="cursor:pointer;"/><br><br>
			<div id="center_bottom">
				이미 가입하셨나요?&nbsp;&nbsp;<a href="login.do">로그인</a>
			</div><br>
		</form>
		</div>
		
		<div id="bottom_content">		
			<div class="">
				<div>
					<div>
						<p>로그인 하거나 회원으로 가입하시면 당사 
							<a href="terms.do">이용약관</a>
							 및 
							<a href="privacy.do">개인정보 보호 정책</a>
							에 동의하시는 것으로 간주됩니다.	
						</p>
						<!-- <div>
							<p>
								<a href="">DDT.com 비즈니스</a>
								를 들어보셨나요?
							</p>
							<p>
								DDT.com에서 숙소를 제공해보세요! 
								<a href="">내 숙소 등록</a>
							</p>
						</div> -->
					</div>
				</div>
			</div>		
		</div>
	</div>
</body>
</html>