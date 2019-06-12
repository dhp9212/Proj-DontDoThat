<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>상세 정보</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
	    function ajaxFileUpload() {
	        // 업로드 버튼이 클릭되면 파일 찾기 창을 띄운다.
	        jQuery("#ajaxFile").click();
	    }
	
	    function ajaxFileChange() {
	        // 파일이 선택되면 업로드를 진행한다.
	        ajaxFileTransmit();
	    }
	
	    /* function ajaxFileTransmit() {
	        var form = jQuery("ajaxFrom")[0];
	        var formData = new FormData(form);
	        formData.append("message", "파일 확인 창 숨기기");
	        formData.append("file", jQuery("#ajaxFile")[0].files[0]);
	
	        jQuery.ajax({
	              url : "./ajaxFormReceive.php"
	            , type : "POST"
	            , processData : false
	            , contentType : false
	            , data : formData
	            , success:function(json) {
	                var obj = JSON.parse(json);
	            }
	        });
	    } */
	    
	    
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
	    
	    //닉네임, 생일 저장
	    $(document).ready(function(){
	    	$("#nickName").keydown(function(key){
	    		if(key.keyCode == 13){
	    			//alert("enterkey 눌림")
	    			
	    			//input text에 쓰인 email을 Controller에 보낸다.
	    			/* function getNickName(){
	    				
	    				if(dynaframe == null){
	    					createIframe();
	    				}
	    				var nickName = document.getElementById("nickName").value;
	    				dynaframe.src = "accountUpdate.do?nickName = " + nickName;
	    			} */
	    			s.submit();
	    		}
	    	});
	    	//Controller에서 받은 email을 input text에 설치한다.
	    	/* function setNickName(nickName){
				document.getElementById("nickName").value = nickName;
			} */
			$("#birthday").keydown(function(key){
				if(key.keyCode == 13){
					/* function getBirthday(){
						var birthday = document.getElementById("birthday").value;
						dynaframe.src = "accountUpdate.do?birthday = " + birthday;
					} */
					s.submit();
				}
			});
			
			/* $(".selectedCountry option:selected").text();
			var selectedCountry = $(".selectedCountry option");
			for(i = 1; i < selectedCountry.length; i++){
				if(selectedCountry.eq(i).text() == ""){
					$(".selectedCountry option:eq("+i+")").prop("selected", true);
					break;
				}
			} */
			
			$('.country').on('change', function(){
				
				
				/* var selectedCountry = document.getElementById("selectedCountry");
				
				var countryName = selectedCountry.options[selectedCountry.selectedIndex].text;
				
				dynaframe.src = "accountUpdate.do"
				dynaframe.src = "accountUpdate.do?selectedCountry = " + countryName; */
				s.submit();
			});
			
			/* var getCountry = document.getElementById("country");
			window.onload = function(){
				if($(this).val() == 'country')
					$(this).prop('selected', true);
			} */
	    });
	    
	    /* var selectedCountry = $(".country option:selected").val();
	    var getCountry = ${country}
	    
	    if(selectedCountry == getCountry){
	    	$(".country").text().prop("selected", true);
	    }
	    $(this).val("country").prop("selected", true);
	    alert( $(this).val("country").prop("selected", true));
	    $(".country option:selected").val();
	    $(".country option:selected").text();
	    $(".country").find(":selected").val();
	    $(".country").find("option:selected").val();
	    $(":selected").val();
	    $("select option:selected").val();
	    $("select[name='country']").val(); */
	    
	    //실시간 프로필 사진 바꾸기
		var openFile = function(event) {
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
	    
	    
	    
	    //값 불러와서 설치해주기?
	    window.onload = function(){
	    	
	    }
	</script>
	
	<style type="text/css">
		.mySettingsMenu
		{
		width:170px;
		height:100%;
		position:absolute;
		border:1px solid blue;
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
		margin : 10px;
		}
		.mySettingsContent{
		border:1px solid green;
		margin : 10px;
		}
		.myProfilePhotoSettings{
		padding: 5px 10px;
		}
		.nickNameSetting{
		padding: 5px 10px;
		}
		.birthdaySetting{
		padding: 5px 10px;
		}
		.countrySetting{
		padding: 5px 10px;
		}
	</style>
</head>
<body>
	<a href="home.do">홈으로</a>
	<!-- 상세정보 페이지 전체 레이아웃 -->
	<div class="mySettingsPage">
		<!-- 상세정보 메뉴, 설정부분 레이아웃 -->
		<div class="mySettingsBody">
			<!-- 상세정보 메뉴 -->
			<div class="mySettingsMenu">
				<br>
				<a href="#">내 정보</a><br><br>
				<a href="#">신용카드</a><br><br>
				<a href="#">결제 수단 설정</a><br><br>
				<a href="#">고객님의 여행 스타일</a><br><br>
				<a href="#">비밀번호 및 통화 </a><br><br>
				<a href="#">소셜 미디어 연결</a><br><br>
				<a href="#">뉴스레터 수신</a><br><br>
				<a href="#">문자메시지 수신 설정</a><br><br>
				<a href="#">보안 설정</a><br>
			</div>
			
			<form name="s" action="accountUpdate.do" method="post" enctype="multipart/form-data">
			<!-- 상세정보 설정 -->
			<div class="detaieldMySettings">
				<!-- 상세정보 타이틀 -->
				<div class="mySettingsHead">
					<div class="mySettingsHeadTitle">
						<h1>내 DDT.com 계정</h1>
					</div>
					<div class="mySettingsHeadSubTitle">
						이 상세 정보는 공개된 이용 후기, 평점, 사진 등 옆에 나타납니다. 여기서 수정하신 모든 정보는 과거 작성 글에도 반영됩니다.
					</div>
				</div>
				<!-- 상세정보 내용 -->
				<div class="mySettingsContent">
					<!-- 프로필 사진 -->
					<div class="myProfilePhotoSettings">
						프로필 사진<br>
						<img src="${pageContext.request.contextPath}/resources/img/profileImage/${profilePhoto}" id="fileName" border="0" width="130" height="130" alt="프로필 등록">${profilePhoto}<br>
						<input type="file" name="profilePhoto" id="profilePhoto" accept='image/*' onchange='openFile(event)'>
						<!-- <input type="file" name="profilePhoto" id="ajaxFile" onchange="ajaxFileChange()" style="display:none;"> -->
						<!-- <input type="button" onClick="ajaxFileUpload();" value="사진 변경"/> -->
						<span style="color:gray"> - 이용자의 눈에 가장 먼저 들어오는 프로필 사진! 나를 가장 잘 표현하는 이미지를 올려주세요.</span>
					</div><br>
					
					<!-- 닉네임 -->
					<div class="nickNameSetting">
						닉네임<br>
						<input type="text" name="nickName" id="nickName" value="${nickName}" onchange="ajaxGetNickName();" onkeypress="JavaScript:press(this.form)">
						<span style="color:gray"> - 언제든 변경하실 수 있으니 개성있는 이름으로 입력해보세요.</span>
					</div><br>
					
					<!-- 생일 -->
					<div class="birthdaySetting">
						생일<br>
						<input type="text" name="birthday" id="birthday" value="${birthday}" maxlength="8" onkeypress="JavaScript:press(this.form)">
						<span style="color:gray"> - 생년월일을 8자리로 입력 해주세요. ex)19901010</span>
					</div><br>
					
					<!-- 국가/지역 -->
					<div class="countrySetting">
						국가/지역<br>
						<select class="country" name="country">
							<option value="" selected disabled>${country}</option>
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
				</div>
				
				
				<!-- 숙소 예약용 정보 -->
				<div class="reservationInformation">
					<div>
						<h1>숙소 예약용 정보</h1>
					</div>
				</div>
				<div class="reservationInformation">
					<div class="reservationInformation">
						<div class="nameSetting">
							이름<br>
							<input type="text" name="name" id="name" value="${name}" onkeypress="JavaScript:press(this.form)">
							
						</div><br>
						<div>
							전화번호
						</div><br>
						<div>
							이메일
						</div><br>
						<div>
							주소
						</div><br>
					</div>
				</div>
			</div>
			</form>
		</div>
	</div>
</body>
</html>