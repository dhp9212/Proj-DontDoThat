<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>상세 정보</title>
	<style type="text/css">
		.mySettingsMenu
		{
		width:100px;
		border:1px solid blue;
		background:skyblue;
		/* margin-left : 85px; */
		}
		.detaieldMySettings
		{
		width:80%;
		height:auto;
		border:1px solid blue;
		background:skyblue;
		margin-left : 150px;
		/* margin-right : 85px; */
		}
		.mySettingsHead{
		border:1px solid green;
		margin : 10px;
		}
		
		.mySettingsContent{
		border:1px solid green;
		margin : 10px;
		}
		
		.myProfile{
		border:1px solid green;
		margin : 10px;
		}
		
		.myProfileLabel{
		padding: 0px, 30px, 0px, 0px;
		border:1px solid green;
		}
		.myProfileImage{
		border:1px solid green;
		}
		
		.nickNameLabel{
		float:left;
		}
		.nickNameInput{
		float:right;
		/* padding-right: 100px; */
		}
		
		.birthdayLabel{
		float:left;
		}
		.birthdayInput{
		float:right;
		/* padding-left: 100px; */
		}
		
		.countryLabel{
		float:left;
		}
		
		.countrySelect{
		float:right;
		border-left: 100px;
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
						<div class="myProfileLabel">
							프로필 사진
						</div>
						<div class="myProfileInput">
							<div class="myProfileImage">
								<img src="filename" border="0" width="130" height="130">
							</div>
							<button type="file" name="profilePhoto" value="사진 변경">사진 변경</button>
							이용자의 눈에 가장 먼저 들어오는 프로필 사진! 나를 가장 잘 표현하는 이미지를 올려주세요.
						</div>
					</div><br>
					
					<!-- 닉네임 -->
					<div>
						<div class="nickNameLabel">
						닉네임
						</div>
						<div class="nickNameInput">
							<input type="text" name="nickName"><br>
							언제든 변경하실 수 있으니 개성있는 이름으로 입력해보세요.
						</div>
					</div><br>
					
					<!-- 생일 -->
					<div>
						<div class="birthdayLabel">
							생일
						</div>
						<div class="birthdayInput">
							<input type="text" name="birthday"><br>
							나이는 연령대(예. "25~30")로 표시됩니다.
						</div>
					</div><br>
					
					<!-- 국가/지역 -->
					<div>
						<div class="countryLabel">
							국가/지역
						</div>
						<div class="countrySelect">
							<select>
								
							</select><br>
							다른 분들이 참고할 수 있도록 국적을 알려주세요.
						</div>
					</div><br>
				</div>
				
				<!-- 숙소 예약용 정보 -->
				<div>
					
				</div>
			</div>
		</div>
	</div>
</body>
</html>