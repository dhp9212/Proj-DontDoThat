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
		
		$(document).ready(function(){
			$("#temporaryPassword").click(function temporaryPassword(){
			alert("������ �̸��Ϸ� �ӽ� ��й�ȣ�� �߼� �߽��ϴ�.")
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
		<!-- ����� ���� --><br><br><br><br>
		<div class="center_content" align="center">
			<!-- �ڷΰ���, �α���, �޴� -->
			<div id="center_top">
				<input id="backButton" type="button" name="back" onclick="goBack();" value="<"/>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="login.do" style="color:#0033cc;"><b>DDT.com Account</b></a>&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
		
			<!-- �̸��� �ּ� �Է�, ���� ��ư, facebook ��ư, google ��ư, naver ��ư, ȸ���������� �̵� -->
			<div id="center_center">
				<h1>�α���</h1>
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
					</div><br>
					<input id="start" type="submit" value="�α���"/><br><br>
					<div id="center_bottom">
						<div>
							<a href="temporaryPassword.do" id="temporaryPassword" onkeypress="JavaScript:press(this.form)">��й�ȣ�� �����̳���?</a>
						</div>
					</div>
				</form>
			</div><br>
		</div>
		
		<div class="bottom_content">			
			<p>�α��� �ϰų� ȸ������ �����Ͻø� ��� 
				<a href="terms.do">�̿���</a>
				 �� 
				<a href="privacy.do">�������� ��ȣ ��å</a>
				�� �����Ͻô� ������ ���ֵ˴ϴ�.	
			</p>
		</div>
	</div>
</body>
</html>