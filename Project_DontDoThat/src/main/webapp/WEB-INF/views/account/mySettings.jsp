<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>상세 정보</title>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/pattern.js"></script>
  
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
	    //닉네임, 생일, 국가/지역 저장
	    $(document).ready(function(){
	    	$('input[type="text"]').on("blur", function(){
	    		if($(this).parents('form').attr('name')=='s3' || $(this).parents('form').attr('name')=='s4') return
	    		$(this).parents('form').submit()
	    	})
            $('.country').on('change', function(){
                s1.submit();
            });
	    });
	    
	    //실시간 프로필 사진 바꾸기
		function openFile(event) {
		    var input = event.target;
		    var reader = new FileReader();
		    reader.onload = function(){
		      var dataURL = reader.result;
		      var output = document.getElementById('fileName');
		      output.src = dataURL;
		    };
		    reader.readAsDataURL(input.files[0]);
		    s.submit();
		  };
		
	    $(document).ready(function(){
	    	//주소 변경
	    	$("#addressChange").click(function addressChange(){
	    		
	    		var state = $(".adressUpdate").css("display");
	    		if(state == "none"){ // state가 none 상태일경우 
		            $(".adressUpdate").show();
		        }else{
		        	 $(".adressUpdate").hide();
		        }
	    	});
	    });
	    
	    $(document).ready(function(){
	    	//신용카드 추가
	    	$("#appendCreditCard").click(function appendCreditCard(){
	    		if($('.creditCardSetting').children('label').length>6) return
	    		var offset = $(".paymentHead").offset();
			    $("html, body").stop().animate({scrollTop:offset.top},1000);
	    		var state = $(".appendCreditCard").css("display");
	    		if(state == "none"){ // state가 none 상태일경우 
		            $(".appendCreditCard").show();
		        }else{
		        	 $(".appendCreditCard").hide();
		        }
	    	});
	    });
	    
	    $(document).ready(function(){
	    	//tel
	    	$('#tel').on('keydown', function(){
	    		if(!(event.keyCode==46 || event.keyCode==8)){
		    		var length = this.value.length
		    		if(length==3 || length==8) this.value += '-'
	    		}
	    	})
	    	//비밀번호 변경
	    	$("#passwordChangeButton").click(function passwordChangeButton(){
	    		var offset = $(".passwordAndCurrencyHead").offset();
			    $("html, body").stop().animate({scrollTop:offset.top},1000);
	    		var state = $(".passwordChangeForm").css("display");
	    		if(state == "none"){ // state가 none 상태일경우 
		            $(".passwordChangeForm").show();
		        }else{
		        	 $(".passwordChangeForm").hide();
		        }
	    	});
	    	$("#passwordChangeSave").click(function passwordChangeSave(){
				var setPassword = $('input[name=setPassword]').val();//비밀번호 설정
				var confirmPassword = $('input[name=confirmPassword]').val();//비밀번호 확인
				var state = $("#passwordLengthLimit").css("display");
				if(setPassword.length < 8) {
					if(state == "none"){
						 $("#passwordLengthLimit").show();
					}
					//document.addjoin.setPassword.focus();
					return false;
				}else {
					if(setPassword != confirmPassword){
						$("#passwordLengthLimit").hide();
						$("#notPasswordMatch").show();
						//비밀번호가 일치하지 않아요.
						return false;
					}
				}
		        document.s4.submit()
		        alert("비밀번호가 변경되었습니다.")
			});
	    	
	    	//신용카드 변경
	    	$('input[name="numOfCreditCard"]').on('keydown', function(){
	    		if(!(event.keyCode==46 || event.keyCode==8)){
		    		var length = this.value.length
		    		if(length==4 || length==9 || length==14) this.value += '-'
	    		}
	    	})
	    	$('input[name="expirationDate"]').on('keydown', function(){
	    		if(!(event.keyCode==46 || event.keyCode==8)){
	    			if(this.value.length==2) this.value += '/'
	    		}
	    	})
	    	$('.card_button').on('click', function(){
	    		$(this).prev().remove()
	    		var str = ''
	    		var hidden = $('input[name="card_value"]')
	    		for(var i=0; i<hidden.length; ++i){
	    			if(str=='') str += hidden[i].value
	    			else str += "#"+hidden[i].value 
	    		}
	    		$('input[name="payment"]').val(str)
	    		alert('신용카드 정보를 삭제했습니다.')
	    		updatePayment.submit()
	    	})
	    	$("#creditCardSave").click(function creditCardSave(){
	    		var selectPayment = $('select[name=kindOfCreditCard]').val();
	    		var numOfCreditCard = $('input[name=numOfCreditCard]').val();
	    		var expirationDate = $('input[name=expirationDate]').val();
	    		var kindOfCreditCard = selectPayment + numOfCreditCard + expirationDate;
	    		var notHyphen = /[-]/;
	    		var notSlash = /[/]/;
	    		
	    		var nameOfCreditCardState = $("#notNumOfCreditCardMatch").css("display");
	    		var expirationDateState = $("#notExpirationDate").css("display");
	    		
	    		if(selectPayment == ''){
	    			alert("신용카드 종류를 선택해주세요")
	    			return false;
	    		}
	    		if(numOfCreditCard.length < 19 && notHyphen.test(numOfCreditCard)==false){
	    			alert("번호를 정확하게 입력해주세요!")
	    			return false;
	    		}
	    		if(notSlash.test(expirationDate)==false && expirationDate.length < 5){
	    			alert("카드 날짜를 정확하게 입력해주세요!")
	    			return false;
	    		}
	    		var checkED = expirationDate.split('/')
	    		if(checkED[0]>12 || checkED[0]==0){
	    			$('input[name=expirationDate]').val('')
	    			alert("카드 날짜를 정확하게 입력해주세요!")
	    			return false;
	    		}
	    		document.s3.submit()
			});
	    	
	    });
	    
	    $(document).ready(function(){
		    $("#myInfo").on("click",function(event){
		      var offset = $(".mySettingsHeadTitle").offset();
		      $("html, body").stop().animate({scrollTop:offset.top},1000);
		    });
		    $("#reserveInfo").on("click",function(event){
			      var offset = $(".reservationInformationTitle").offset();
			      $("html, body").stop().animate({scrollTop:offset.top},1000);
		    });
		    $("#payMethod").on("click",function(event){
			      var offset = $(".paymentHead").offset();
			      $("html, body").stop().animate({scrollTop:offset.top},1000);
		    });
		    $("#resetPassword").on("click",function(event){
			      var offset = $(".passwordAndCurrencyHead").offset();
			      $("html, body").stop().animate({scrollTop:offset.top},1000);
		    });
		  }); // end of ready()
	</script>
	
	<style type="text/css">
		/* 내 DDT.com 계정 */
		.mySettingsMenu
		{
		width:170px;
		height:100%;
		position:fixed;
		border:1px solid blue;
		padding: 5px 10px;
		}
		.detaieldMySettings
		{
		width:80%;
		height:auto;
		border:1px solid blue;
		margin-left : 190px;
		}
		.mySettingsHead{
		border:1px solid green;
		padding: 5px 10px;
		margin : 10px;
		}
		.mySettingsContent{
		border:1px solid green;
		padding: 5px 10px;
		margin : 10px;
		}
		
		/* 숙소 예약용 정보 */
		.reservationInformationHead{
		border:1px solid green;
		padding: 5px 10px;
		margin : 10px;
		}
		.reservationInformationContent{
		border:1px solid green;
		padding: 5px 10px;
		margin : 10px;
		}
		.adressUpdate{
		display:none;
		}
		
		/* 결제 수단 설정 */
		.paymentHead{
		border:1px solid green;
		padding: 5px 10px;
		margin : 10px;
		}
		.paymentContent{
		border:1px solid green;
		padding: 5px 10px;
		margin : 10px;
		}
		.appendCreditCard{
		display:none;
		}
		
		/* 비밀번호 및 통화 */
		.passwordAndCurrencyHead{
		border:1px solid green;
		padding: 5px 10px;
		margin : 10px;
		}
		.passwordAndCurrencyContent{
		border:1px solid green;
		padding: 5px 10px;
		margin : 10px;
		}
		.passwordChangeForm{
		display:none;
		}
	</style>
</head>
<body>
	<!-- 상세정보 페이지 전체 레이아웃 -->
	<div class="mySettingsPage">
		<!-- 상세정보 메뉴, 설정부분 레이아웃 -->
		<div class="mySettingsBody">
			<!-- 상세정보 메뉴 -->
			<div class="mySettingsMenu">
				<br>
				<a href="home.do"><h3>홈으로</h3></a><br><br>
				<a id="myInfo">내 정보</a><br><br>
				<a id="reserveInfo">숙소 예약용 정보</a><br><br>
				<a id="payMethod">결제 수단 설정</a><br><br>
				<!-- <a href="#">고객님의 여행 스타일</a><br><br> -->
				<a id="resetPassword">비밀번호</a><br><br>
				<!-- <a href="#">소셜 미디어 연결</a><br><br>
				<a href="#">뉴스레터 수신</a><br><br>
				<a href="#">문자메시지 수신 설정</a><br><br>
				<a href="#">보안 설정</a><br> -->
			</div>
			
			<!-- 상세정보 설정 -->
			<div class="detaieldMySettings">
				<!-- 상세정보 타이틀 -->
				<div class="mySettingsHead">
					<div class="mySettingsHeadTitle">
						<h1>내 계정</h1>
					</div>
					<div class="mySettingsHeadSubTitle">
						이 상세 정보는 공개된 이용 후기, 평점, 사진 등 옆에 나타납니다. 여기서 수정하신 모든 정보는 과거 작성 글에도 반영됩니다.
					</div>
				</div>
				<!-- 상세정보 내용 -->
				<div class="mySettingsContent">
					<!-- 프로필 사진 -->
					<div class="myProfilePhotoSettings">
						<form name="s" action="accountUpdateImage.do" method="post" enctype="multipart/form-data">
							프로필 사진<br>
							<img src="${pageContext.request.contextPath}/resources/img/profileImage/${userSession.profilePhoto}" id="fileName" border="0" width="180" height="180" alt="프로필 등록"><br>
							<input style="border:none; background-color:white;" type="file" name="profilePhoto" id="profilePhoto" accept='image/*' onchange='openFile(event)'>
							<span style="color:gray"> - 이용자의 눈에 가장 먼저 들어오는 프로필 사진! 나를 가장 잘 표현하는 이미지를 올려주세요.</span>
							<!-- <input type="file" name="profilePhoto" id="ajaxFile" onchange="ajaxFileChange()" style="display:none;"> -->
							<!-- <input type="button" onClick="ajaxFileUpload();" value="사진 변경"/> -->
						</form>
					</div><br>

				<form name="s0" action="accountUpdateNames.do" method="post" enctype="multipart/form-data">
					<!-- 닉네임 -->
					<div class="nickNameSetting">
						닉네임<br>
						<input type="text" name="nickName" id="nickName" value="${userSession.nickName}" onchange="ajaxGetNickName();" onkeypress="JavaScript:press(this.form)">
						<span style="color:gray"> - 언제든 변경하실 수 있으니 개성있는 이름으로 입력해보세요.</span>
					</div><br>
					
					<!-- 생일 -->
					<div class="birthdaySetting">
						생일<br>
						<input type="text" name="birthday" id="birthday" value="${userSession.birthday}" maxlength="8" onkeypress="JavaScript:press(this.form)">
						<span style="color:gray"> - 생년월일을 8자리로 입력 해주세요. ex) 19901010</span>
					</div><br>
				</form>
				<form name="s1" action="accountUpdateCountry.do" method="post" enctype="multipart/form-data">
					<!-- 국가/지역 -->
					<div class="countrySetting">
						국가/지역<br>
						<select class="country" name="country">
							<c:forEach var="myCountry" items="${countryList}">
							<c:if test="${userSession.countryName==myCountry.name}">
							<option value="${myCountry.code_2}" selected>${myCountry.name}</option>
							</c:if>
							<c:if test="${userSession.countryName!=myCountry.name}">
							<option value="${myCountry.code_2}">${myCountry.name}</option>
							</c:if>
							</c:forEach>
						</select>
						<span style="color:gray"> - 다른 분들이 참고할 수 있도록 국적을 알려주세요.</span>
					</div><br>
				</form>
				</div>
			
				<!-- 숙소 예약용 정보 타이틀 -->
				<div class="reservationInformationHead">
					<div class="reservationInformationTitle">
						<h1>숙소 예약용 정보</h1>
					</div class="reservationInformationSubTitle">
					<div>본 정보는 예약 시 자동 입력을 통해 예약 절차를 간편하게 하기 위한 목적으로만 사용됩니다. 입력하신 정보는 철저히 보안되며 절대 공개되지 않습니다.</div>
				</div>
				<!-- 숙소 예약용 정보 내용 -->
				
				<div class="reservationInformationContent">
					<form name="s2" action="accountUpdatePrivate.do" method="post" enctype="multipart/form-data">
						<!-- 이름 -->
						<div class="nameSetting">
							이름<br>
							<input type="text" name="name" id="name" value="${userSession.name}" onkeypress="JavaScript:press(this.form)">
						</div><br>
						<!-- 전화번호 -->
						<div class="telSetting">
							휴대전화번호<br>
							<input type="text" name="tel" id="tel" value="${userSession.tel}" onkeypress="JavaScript:press(this.form)" maxlength="13">
							<span style="color:gray"> - 숫자만 입력하면 자동으로 "-"가 입력됩니다. ex)010-1234-5678</span>
						</div><br>
						<!-- 이메일 -->
						<div class="emailSetting">
							이메일<!-- <span style="color:gray"> - 최대 3개까지 이메일 주소 저장 가능... 근데 난 안될거야.. 포기하자</span> --><br>
							&nbsp;<label><b>${userSession.email}</b></label><br>
							<!-- <input type="button" name="appendEmail" value="이메일 추가하기"> -->
						</div><br>
						<!-- 주소 -->
						<div class="addressSetting">
							주소<br>
							&nbsp;<label>(우) ${userSession.address}</label><br>
							<div class="adressUpdate">
								<input type="text" name="address" id="address" value="${userSession.address}" onkeypress="JavaScript:press(this.form)" placeholder="ex) 00000 서울시 송파구 잠실6동 장미아파트 101동 101호." style="width:500px;">
								<span style="color:gray"> - 기입 ex) 00000 서울시 송파구 잠실6동 장미아파트 101동 101호.</span><br>
							</div><br>
							<input type="button" name="addressChange" id="addressChange" value="집 주소 변경" onkeypress="JavaScript:press(this.form)">
						</div><br>
					</form>
				</div>
				
				<!-- 결제 수단 설정 타이틀 -->
				<div class="paymentHead">
					<div class="paymentTitle">
						<h1>결제 수단 설정</h1>
					</div>
					<div class="paymentSubTitle">
						빠르고 편리한 예약을 위해 원하시는 결제 방식을 알려주세요.
					</div>
				</div>
				<!-- 결제 수단 설정 내용 -->
				<div class="paymentContent">
					<form name="s3" action="accountUpdateCard.do" method="post" enctype="multipart/form-data">
						<!-- 신용카드 설정 -->
						<div class="creditCardSetting" style="background-color:lavender;">
							<c:forEach var="cardItem" items="${userSession.cardList}">
							<span>
								<input type="hidden" name="card_value" value="${cardItem.kindOfCreditCard},${cardItem.numOfCreditCard},${cardItem.expirationDate}" >
                                <input type="button" class="card_button" value="지우기" style="border:1px solid #0033cc; color:#0033cc; background-color:lavender">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <label>${cardItem.kindOfCreditCard}&nbsp;${cardItem.numOfCreditCard}&nbsp;${cardItem.expirationDate}</label>&nbsp;
                                <label>${userSession.name}</label>
                                <label>${userSession.name}</label>&nbsp;&nbsp;&nbsp;&nbsp;
								<br/>
							</span>
							</c:forEach>
						</div><br>
						<!-- <div class="guidanceCreditCard">
							<span style="color:gray" style="pading:5px 10px"> - 신용카드를 등록해주세요. </span>
						</div><br> -->
						<div class="appendCreditCard">
							신용카드 종류<br>
							<select name="kindOfCreditCard">
								<option value=''>선택</option>
								<option value='American Express'>American Express</option>
								<option value='VISA'>VISA</option>
								<option value='MasterCard'>MasterCard</option>
								<option value='JCB'>JCB</option>
								<option value='UnionPay'>UnionPay</option>
							</select><br><br>
							신용카드 번호<br>
							<input type="text" class="onlyNumber" name="numOfCreditCard" value="${numOfCreditCard}" placeholder="0000-0000-0000-0000" maxlength="19">
								<span style="color:gray"> - ex) 0000-0000-0000-0000 </span><br>
								<label id="notNumOfCreditCardMatch" style="color:red; display:none;">정확하게 입력해주세요!</label><br>
							만료 날짜<br>
							<input type="text" class="onlyNumber" name="expirationDate" value="${expirationDate}"placeholder="01/19" maxlength="5">
								<span style="color:gray"> - 월/년 기입 ex) 01/19 </span><br>
								<label id="notExpirationDateMatch" style="color:red; display:none;">정확하게 입력해주세요!</label><br>
							<input type="button" value="변경 저장" name="creditCardSave" id="creditCardSave">
							<input type="reset" value="취소" name="cancel"><br>
						</div><br>
						<div class="appendCreditCardButton">
							<input type="button" name="appendCreditCard" id="appendCreditCard" value="카드 추가">
						</div><br>
					</form>
				</div>
			
				<form name="s4" action="accountUpdatePassword.do" method="post" enctype="multipart/form-data">
					<!-- 비밀번호 및 통화 타이틀 -->
					<div class="passwordAndCurrencyHead">
						<div class="passwordAndCurrencyTitle">
							<h1>비밀번호</h1>
						</div>
					</div>
					<!-- 비밀번호 및 통화 내용 -->
					<div class="passwordAndCurrencyContent">
						<div class="passwordChange">
							<div class="passwordChangeForm">
								새로운 비밀번호 입력<br>
								<input type="password" name="setPassword" required="required"><br>
									<label id="passwordLengthLimit" style="color:red; display:none;">비밀번호는 최소 8자 이상이어야 합니다.</label><br>
								새로운 비밀번호 재입력<br>
								<input type="password" name="confirmPassword" required="required"><br>
									<label id="notPasswordMatch" style="color:red; display:none;">비밀번호가 일치하지 않습니다. 다시 입력해주세요.</label><br>
								<input type="button" value="변경 저장" name="passwordChangeSave" id="passwordChangeSave"><br>
							</div><br>
							<input type="button" value="비밀번호 변경하기" name="passwordChangeButton" id="passwordChangeButton">
						</div><br>
					</div>
				</form>
			</div>
		</div>
	</div>
<form name="updatePayment" action="updateAccount_payment.do" method="post">
	<input type="hidden" name="payment">
</form>
</body>
</html>