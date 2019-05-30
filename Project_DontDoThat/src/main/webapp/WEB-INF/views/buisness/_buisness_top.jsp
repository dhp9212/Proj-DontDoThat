<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/basic_style.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
</head>
<script src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
<script>
	$(document).ready(function() {
		$('.table').on('click', function(){
			for(var i=1; i<4; ++i){
				$('#'+i).hide()
			}
			switch($(this).text()){
			case '그룹 홈' : $('#1').show(); break;
			case '예약' : $('#2').show(); break;
			case '이용 후기' : $('#3').show(); break;
			}
		})
		$('.menu').on('mouseenter', function(){
			$('#calenderMenu').attr('class', 'hide')
			$('#accomodationMenu').attr('class', 'hide')
			$('#messageMenu').attr('class', 'hide')
			$('#payMenu').attr('class', 'hide')
			$('#menu').show()
			switch($(this).text()){
			case '요금 및 캘린더' : visible('calenderMenu'); break;
			case '숙소' : visible('accomodationMenu'); break;
			case '메세지' : visible('messageMenu'); break;
			case '재무' : visible('payMenu'); break;
			}
		})
	})
	function visible(id){
		$('#blank').attr('class', id);
		if($('#'+id).attr('class')=='hide') $('#'+id).attr('class', 'show')
		else $('#'+id).attr('class', 'hide')
		$('#'+id).on('mouseleave', function(){
			$('#'+id).attr('class', 'hide')
			$('#menu').hide()
		})
	}
</script>
<body>
	<div>
		<table class="dark_blue">
			<tr>
				<td width="75%">
					<a href="home.do">인덱스로</a><br>
					<a href="buisness_index.do">사업자 홈으로</a>
				</td>
				<td><input name="search" type="text" size="10"></td>
				<td><input type="button" class="search"></td>
				<td>어카운트</td>
				<td>숙소</td>
			</tr>		
		</table>
	</div>
	<div>
		<table class="blue">
			<tr>
				<td class="table" width="30%"><a href="buisness_index.do">그룹 홈</a></td>
			<c:if test="${!empty accomodation_num}">
				<td class="table"><a href="general_info.do">숙소 정보</a></td>
			</c:if>
				<td class="table">예약</td>
				<td class="table">이용 후기</td>
				<td class="menu">요금 및 캘린더</td>
				<td class="menu">숙소</td>
				<td class="menu">메세지</td>
				<td class="menu">재무</td>

			</tr>
		</table>
		<table>
			<tr id="menu" class="hide">
				<td id="blank"></td>
				<td id="calenderMenu" class="menuHide">
					<table>
						<tr>
							<td><a href="calender.do">캘린더</a></td>
							<td><a href="open_close.do">객실 열기/닫기</a></td>
						</tr>
						<tr>
							<td><a href="qty_control.do">판매 가능 객실 수 조정</a></td>
							<td><a href="payment.do">요금제</a></td>
						</tr>
						<tr>
							<td><a href="pay_control.do">연간 요금 복사하기</a></td>
							<td></td>
						</tr>
					</table>
				</td>
				<td id="accomodationMenu" class="menuHide">
					<table>
						<tr>
							<td><a href="homepage.do">숙소 페이지 점수</a></td>
							<td><a href="nearby.do">숙소 근처에는 무엇이 있나요?</a></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td><a href="message_setting.do">메세지 설정</a></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td><a href="profile.do">프로필</a></td>
						</tr>
					</table>
				</td>
				<td id="messageMenu" class="menuHide">
					<table>
						<tr>
							<td><a href="custom_message.do">고객 메세지</a></td>
						</tr>
						<tr>
							<td><a href="admin_message.do">dontDoThat 메세지</a></td>
						</tr>
					</table>
				</td>
				<td id="payMenu" class="menuHide">
					<table>
						<tr>
							<td><a href="bill.do">청구서</a></td>
						</tr>
						<tr>
							<td><a href="reservation_specification.do">예약 명세서</a></td>
						</tr>
						<tr>
							<td><a href="financial_overview.do">재무 개요</a></td>
						</tr>
						<tr>
							<td><a href="account_info.do">은행 계좌 정보</a></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
	<div style="height:90%; overflow:scroll;">
	
