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
  
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
	   
	    //자동 저장
	    var dynaframe = null;
	    
	    function createIframe(){
	    	dynaframe.width = "50";
	    	dynaframe.height = "50";
	    	dynaframe.frameborder = "1";
	    	
	    	document.body.appendChild(dynaframe);
	    }
	    
	    function ajaxGetNickName(){
	    	if(dynaframe == null){
	    		createIframe();
	    	}
	    	var nickName = document.getElementById("nickName").value;
	    	dynaframe.src = "accountUpdate.do?nickName = " + nickName;
	    }
	    
	    function setNickNameData(nickName){
	    	document.getElementById("nickName").value = nickName;
	    }
	    
	    //닉네임, 생일, 국가/지역 저장
	    $(document).ready(function(){
	    	//닉네임
	    	$("#nickName").keydown(function(key){
	    		if(key.keyCode == 13){
	    			s0.submit();
	    		}
	    	});
	    	//생일
			$("#birthday").keydown(function(key){
				if(key.keyCode == 13){
					s0.submit();
				}
			});
	    	//국가/지역
			$('.country').on('change', function(){
				s1.submit();
			});
	    	//이름
			$("#name").keydown(function(key){
				if(key.keyCode == 13){
					s2.submit();
				}
			});
	    	//전화번호
			$("#tel").keydown(function(key){
				if(key.keyCode == 13){
					s2.submit();
				}
			});
	    	//주소
			$("#address").keydown(function(key){
				if(key.keyCode == 13){
					s2.submit();
				}
			});
	    	
	    	//비밀번호
	    	
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
			});
	    	//신용카드 변경
	    	$("#creditCardSave").click(function creditCardSave(){
	    		var selectPayment = $('select[name=kindOfCreditCard]').val();
	    		var numOfCreditCard = $('input[name=numOfCreditCard]').val();
	    		var expirationDate = $('input[name=expirationDate]').val();
	    		var kindOfCreditCard = selectPayment + numOfCreditCard + expirationDate;
	    		var notHyphen = /[-]/;
	    		var notSlash = /[/]/;
	    		
	    		var nameOfCreditCardState = $("#notNumOfCreditCardMatch").css("display");
	    		var expirationDateState = $("#notExpirationDate").css("display");
	    		
	    		if(selectPayment == "선택"){
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
							<input type="file" name="profilePhoto" id="profilePhoto" accept='image/*' onchange='openFile(event)'>
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
							<option value='${userSession.country}' selected disabled>${userSession.countryName}</option>
							<option value='GH'>가나</option>
							<option value='GA'>가봉</option>
							<option value='GM'>감비아</option>
							<option value='GG'>건지</option>
							<option value='GP'>과델로프</option>
							<option value='GT'>과테말라</option>
							<option value='GU'>괌</option>
							<option value='GD'>그라나다</option>
							<option value='GE'>그루지아</option>
							<option value='GR'>그리스</option>
							<option value='GL'>그린랜드</option>
							<option value='GW'>기네비소</option>
							<option value='GN'>기니</option>
							<option value='GY'>기야나</option>
							<option value='NA'>나미비아</option>
							<option value='NR'>나우루</option>
							<option value='NG'>나이지리아</option>
							<option value='ZA'>남아프리카</option>
							<option value='GS'>남조지아 & 남샌드위치 군도</option>
							<option value='NL'>네덜란드</option>
							<option value='AN'>네덜란드 열도</option>
							<option value='NP'>네팔</option>
							<option value='NO'>노르웨이</option>
							<option value='NF'>노포크 섬</option>
							<option value='NZ'>뉴질랜드</option>
							<option value='NC'>뉴 칼레도니아</option>
							<option value='NU'>니우에</option>
							<option value='NE'>니제르</option>
							<option value='NI'>니카라과</option>
							<option value='TW'>대만</option>
							<option value='DK'>덴마크</option>
							<option value='DM'>도미니카</option>
							<option value='DO'>도미니카 공화국</option>
							<option value='DE'>독일</option>
							<option value='TL'>동티모르</option>
							<option value='LA'>라오스</option>
							<option value='LR'>라이베리아</option>
							<option value='LV'>라트비아</option>
							<option value='RU'>러시아</option>
							<option value='LB'>레바논</option>
							<option value='LS'>레소토</option>
							<option value='RO'>루마니아</option>
							<option value='LU'>룩셈부르크</option>
							<option value='RW'>르완다</option>
							<option value='LY'>리비아</option>
							<option value='LT'>리투아니아</option>
							<option value='LI'>리히텐슈타인</option>
							<option value='MG'>마다카스카르</option>
							<option value='MH'>마샬군도</option>
							<option value='FM'>마이크로네시아</option>
							<option value='MO'>마카오</option>
							<option value='MK'>마케도니아</option>
							<option value='MQ'>마티니크</option>
							<option value='MW'>말라위</option>
							<option value='MY'>말레이시아</option>
							<option value='ML'>말리</option>
							<option value='IM'>맨섬</option>
							<option value='YT'>메요트</option>
							<option value='MX'>멕시코</option>
							<option value='MC'>모나코</option>
							<option value='MA'>모로코</option>
							<option value='MU'>모리셔스</option>
							<option value='MR'>모리타니</option>
							<option value='MZ'>모잠비크</option>
							<option value='MS'>몬세라</option>
							<option value='ME'>몬테네그로</option>
							<option value='MD'>몰도바</option>
							<option value='MV'>몰디브</option>
							<option value='MT'>몰타</option>
							<option value='MN'>몽골</option>
							<option value='US'>미국</option>
							<option value='VI'>미국령 버진군도</option>
							<option value='UM'>미국의 군도</option>
							<option value='MM'>미얀마(버마)</option>
							<option value='VU'>바누아투</option>
							<option value='BH'>바레인</option>
							<option value='BB'>바베이도스</option>
							<option value='VA'>바티칸시티</option>
							<option value='BS'>바하마</option>
							<option value='BD'>방글라데시</option>
							<option value='BM'>버뮤다</option>
							<option value='VE'>베네주엘라</option>
							<option value='BJ'>베닌</option>
							<option value='VN'>베트남</option>
							<option value='BE'>벨기에</option>
							<option value='BY'>벨로루시</option>
							<option value='BZ'>벨리즈</option>
							<option value='BV'>보빗 군도</option>
							<option value='BA'>보스니아-헤르체코비나</option>
							<option value='BW'>보츠와나</option>
							<option value='BO'>볼리비아</option>
							<option value='BI'>부룬디</option>
							<option value='BF'>부르키나 파소</option>
							<option value='BT'>부탄</option>
							<option value='MP'>북마리아나 군도</option>
							<option value='KP'>북한</option>
							<option value='BG'>불가리아</option>
							<option value='BR'>브라질</option>
							<option value='BN'>브루나이</option>
							<option value='WS'>사모아</option>
							<option value='SA'>사우디 아라비아</option>
							<option value='CY'>사이프러스</option>
							<option value='SM'>산마리노</option>
							<option value='ST'>상토메 프린스페</option>
							<option value='EH'>서부 사하라</option>
							<option value='SN'>세네갈</option>
							<option value='RS'>세르비아</option>
							<option value='CS'>세르비아 몬테네그로</option>
							<option value='SC'>세이쉘</option>
							<option value='LC'>세인트 루시아</option>
							<option value='VC'>세인트 빈센트 그레나딘</option>
							<option value='KN'>세인트 키츠 네비스</option>
							<option value='PM'>세인트 피레 미켈론</option>
							<option value='SH'>세인트 헬레나</option>
							<option value='SO'>소말리아</option>
							<option value='SB'>솔로몬 군도</option>
							<option value='SD'>수단</option>
							<option value='SR'>수리남</option>
							<option value='LK'>스리랑카</option>
							<option value='SJ'>스발비드 군도</option>
							<option value='SZ'>스와질랜드</option>
							<option value='SE'>스웨덴</option>
							<option value='CH'>스위스</option>
							<option value='ES'>스페인</option>
							<option value='SK'>슬로바키아</option>
							<option value='SI'>슬로베니아</option>
							<option value='SY'>시리아</option>
							<option value='SL'>시에라 리온</option>
							<option value='SG'>싱가포르</option>
							<option value='AE'>아랍에미리트 연합</option>
							<option value='AW'>아루바</option>
							<option value='AM'>아르메니아</option>
							<option value='AR'>아르헨티나</option>
							<option value='AS'>아메리칸 사모아</option>
							<option value='IS'>아이슬란드</option>
							<option value='HT'>아이티</option>
							<option value='IE'>아일랜드</option>
							<option value='AZ'>아제르바이잔</option>
							<option value='AF'>아프가니스탄</option>
							<option value='AD'>안도라</option>
							<option value='AQ'>안타티카(남극)</option>
							<option value='AG'>안티가 바부다</option>
							<option value='AX'>알랜드 군도</option>
							<option value='AL'>알바니아</option>
							<option value='DZ'>알제리</option>
							<option value='AO'>앙골라</option>
							<option value='AI'>앙귈라</option>
							<option value='ER'>에리트리아</option>
							<option value='EE'>에스토니아</option>
							<option value='EC'>에콰도르</option>
							<option value='SV'>엘살바도르</option>
							<option value='GB'>영국</option>
							<option value='VG'>영국령 버진군도</option>
							<option value='IO'>영국령 인도양</option>
							<option value='YE'>예멘</option>
							<option value='OM'>오만</option>
							<option value='AT'>오스트리아</option>
							<option value='HN'>온두라스</option>
							<option value='WF'>왈라스 & 퓨투나</option>
							<option value='JO'>요르단</option>
							<option value='UG'>우간다</option>
							<option value='UY'>우루과이</option>
							<option value='UZ'>우즈베키스탄</option>
							<option value='UA'>우크라이나</option>
							<option value='ET'>이디오피아</option>
							<option value='IQ'>이라크</option>
							<option value='IR'>이란</option>
							<option value='IL'>이스라엘</option>
							<option value='EG'>이집트</option>
							<option value='IT'>이탈리아</option>
							<option value='IN'>인도</option>
							<option value='ID'>인도네시아</option>
							<option value='JP'>일본</option>
							<option value='JM'>자메이카</option>
							<option value='ZM'>잠비아</option>
							<option value='JE'>저지</option>
							<option value='GQ'>적도 기니</option>
							<option value='CN'>중국</option>
							<option value='CF'>중앙아프리카</option>
							<option value='DJ'>지부티</option>
							<option value='GI'>지브랄타</option>
							<option value='ZW'>짐바브웨</option>
							<option value='TD'>챠드</option>
							<option value='CZ'>체코공화국</option>
							<option value='CL'>칠레</option>
							<option value='CM'>카메룬</option>
							<option value='CV'>카보 베르데</option>
							<option value='KZ'>카자흐스탄</option>
							<option value='QA'>카타르</option>
							<option value='KH'>캄보디아</option>
							<option value='CA'>캐나다</option>
							<option value='KE'>케냐</option>
							<option value='KY'>케이만 군도</option>
							<option value='KM'>코모로스</option>
							<option value='CR'>코스타리카</option>
							<option value='CC'>코코스 군도</option>
							<option value='CI'>코트디봐르</option>
							<option value='CO'>콜롬비아</option>
							<option value='CG'>콩고</option>
							<option value='CD'>콩고 민주공화국</option>
							<option value='CU'>쿠바</option>
							<option value='KW'>쿠웨이트</option>
							<option value='CK'>쿡 아일랜드</option>
							<option value='HR'>크로아티아</option>
							<option value='CX'>크리스마스 아일랜드</option>
							<option value='KG'>키르기스</option>
							<option value='KI'>키리바티</option>
							<option value='TJ'>타지크스탄</option>
							<option value='TZ'>탄자니아</option>
							<option value='TH'>태국</option>
							<option value='TR'>터키</option>
							<option value='TG'>토고</option>
							<option value='TK'>토켈라우</option>
							<option value='TO'>통가</option>
							<option value='TC'>투르크 & 카이코스 군도</option>
							<option value='TM'>투르크멘</option>
							<option value='TV'>투발루</option>
							<option value='TN'>튀니지</option>
							<option value='TT'>트리니다드 토바고</option>
							<option value='PA'>파나마</option>
							<option value='PY'>파라과이</option>
							<option value='FO'>파로에 군도</option>
							<option value='PK'>파키스탄</option>
							<option value='PG'>파푸아 뉴기니</option>
							<option value='PW'>팔라우</option>
							<option value='PS'>팔레스타인 지구</option>
							<option value='PE'>페루</option>
							<option value='PT'>포르투갈</option>
							<option value='FK'>포클랜드 군도</option>
							<option value='PL'>폴란드</option>
							<option value='PR'>푸에르토리코</option>
							<option value='FR'>프랑스</option>
							<option value='GF'>프랑스령 가이아나</option>
							<option value='TF'>프랑스령 남부지역</option>
							<option value='RE'>프랑스령 리유니온</option>
							<option value='PF'>프랑스령 폴리네시아</option>
							<option value='FJ'>피지</option>
							<option value='PN'>피트카이른</option>
							<option value='FI'>핀란드</option>
							<option value='PH'>필리핀</option>
							<option value='KR'>한국</option>
							<option value='HM'>허드 앤 맥도날드 군도</option>
							<option value='HU'>헝가리</option>
							<option value='AU'>호주</option>
							<option value='HK'>홍콩</option>					
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
							전화번호<span style="color:gray"> - "-" 없이 숫자만 입력해주세요. ex)01012345678</span><br>
							<input type="text" name="tel" id="tel" value="${userSession.tel}" onkeypress="JavaScript:press(this.form)">
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
								<label>${cardItem.kindOfCreditCard}&nbsp;${cardItem.numOfCreditCard}&nbsp;${cardItem.expirationDate}</label>&nbsp;
								<label>${userSession.name}</label>	
								<br/>
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
							<input type="text" name="numOfCreditCard" value="${numOfCreditCard}" placeholder="0000-0000-0000-0000" maxlength="19">
								<span style="color:gray"> ex) 0000-0000-0000-0000 </span><br>
								<label id="notNumOfCreditCardMatch" style="color:red; display:none;">정확하게 입력해주세요!</label><br>
							만료 날짜<br>
							<input type="text" name="expirationDate" value="${expirationDate}"placeholder="01/19" maxlength="5">
								<span style="color:gray"> - 월/년 기입 ex) 01/19 </span><br>
								<label id="notExpirationDateMatch" style="color:red; display:none;">정확하게 입력해주세요!</label><br>
							<input type="button" value="변경 저장" name="creditCardSave" id="creditCardSave" >
							<input type="reset" value="취소" name="cancel"><br>
						</div><br>
						<div class="appendCreditCardButton">
							<input type="button" name="appendCreditCard" id="appendCreditCard" value="카드 추가" >
						</div><br>
					</form>
				</div>
		
			
				<form name="s4" action="accountUpdate.do" method="post" enctype="multipart/form-data">
					<!-- 비밀번호 및 통화 타이틀 -->
					<div class="passwordAndCurrencyHead">
						<div class="passwordAndCurrencyTitle">
							<h1>비밀번호 및 통화</h1>
						</div>
					</div>
					<!-- 비밀번호 및 통화 내용 -->
					<div class="passwordAndCurrencyContent">
						<!-- <div class="currencySetting">
							선호하는 통화<br>
							<select>
								<option>대한민국 원</option>
								<option>일본 엔</option>
							</select>
						</div><br> -->
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
</body>
</html>