<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�α��� ȭ��</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
		function goBack(){
			window.history.back();
		}
		
		$(document).ready(function() {
			var state = $(".emailAndPasswordAreDifferent").css("display");
			if($('input[name=wrongPassword]').val()=='��й�ȣ Ʋ��'){
				if(state == "none"){ // state�� none �����ϰ�� .")
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
		<!-- ����� ���� -->
		<div class="center_content" align="center">
			<!-- �ڷΰ���, �α���, �޴� -->
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
		
			<!-- �̸��� �ּ� �Է�, ���� ��ư, facebook ��ư, google ��ư, naver ��ư, ȸ���������� �̵� -->
			<div id="center_center">
				<h4>�α���</h4>
				<p id="guide">���� Booking.com ������ ���� ��й�ȣ�� �Է��ϼ���.<br>
					<strong>${email}</strong>
				</p>
			<form name="f" action="loginOk.do" method="post">
				<div id="center_password">
					<div>
						<label>DDT.com ��й�ȣ</label>
					</div>
					<input type="password" name="password">
				</div>
				<div class="emailAndPasswordAreDifferent">
					�̸��� �ּҿ� ��й�ȣ�� ������ ��ġ���� �ʽ��ϴ�.
				</div>
				<input id="start" type="submit" value="�α���"/>
				<div id="center_bottom">
				 - �Ǵ� Ŭ�� �ѹ����� �α��� - 
					<div id="center_access">
						<a id="fb" href="">facebook</a>
						<a id="gg" href="">google</a>
						<a id="nv" href="">naver</a>
					</div>
					<div>
						<a href="#">��й�ȣ�� �����̳���?</a>
					</div>
				</div>
			</form>
			</div>
		</div>
		
		<div class="bottom_content">		
			<div class="">
				<div>					
					<div>
						<p>�α��� �ϰų� ȸ������ �����Ͻø� ��� 
							<a href="terms.do">�̿���</a>
							 �� 
							<a href="privacy.do">�������� ��ȣ ��å</a>
							�� �����Ͻô� ������ ���ֵ˴ϴ�.	
						</p>
						<div>
							<div>
								<p>
									�ѱ���(��� ���� �κ�)
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