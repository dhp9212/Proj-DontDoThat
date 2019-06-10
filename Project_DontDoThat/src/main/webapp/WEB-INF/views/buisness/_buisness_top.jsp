<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/pattern.js"></script>
<style>
	.full_color{
		background-color:#fafafa;
		height:80%;
		overflow:auto;
		padding: 50;
	}
</style>
</head>
<body>
<div>
	<div class="row" style="background-color:#000080;">
		<div style="margin:5 0 0 30;" class="col-sm-7"><a href="home.do"><font class="text-white">인덱스로</font></a></div>
		<div class="col-sm-2"><input type="text" style="height:25; margin:5 0 0 0;" name="search" class="form-control"></div>
		<div style="margin:5 0 0 0;" class="col-sm-1"><font class="text-white">어카운트</font></div>
		<div style="margin:5 0 0 0;" class="col-sm-1"><font class="text-white">숙소</font></div>
	</div>
	<div class="row" style="background-color:#000080;">
		<div style="margin:0 0 0 30;" class="col-sm-11"><a href="buisness_index.do"><font class="text-white">사업자 홈으로</font></a></div>
	</div>
	<c:if test="${!empty accomodation_num}">
	<div class="row" style="background-color:#000080;">
		<div style="margin:0 10 0 30;" class="col-sm-11"><a href="general_info.do"><font class="text-white">숙소 정보</font></a></div>
	</div>
	</c:if>
	<div class="row" style="background-color:blue;">
		<div style="margin:5 0 0 30;" class="col-sm-1"><font class="text-white">예약</font></div>
		<div style="margin:5 0 0 30;" class="col-sm-5"><font class="text-white">이용 후기</font></div>
		<div class="col-sm-1">
			<button type="button" style="width:80;" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">숙소</button>
			<div class="dropdown-menu">
			<c:forEach var="dto" items="${accomodation_list}" varStatus="num">
		      <a class="dropdown-item" href="general_info.do?accomodation_num=${dto.value.num}">${dto.value.accomodation_name}</a>
		    </c:forEach>
		    </div>
		</div>
		<div class="col-sm-1">
			<button type="button" style="width:80;" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">메세지</button>
			<div class="dropdown-menu">
		      <a class="dropdown-item" href="custom_message.do">고객 메세지</a>
		      <a class="dropdown-item" href="admin_message.do">dontDoThat 메세지</a>
		    </div>
		</div>
		<div class="col-sm-1">
			<button type="button" style="width:80;" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">재무</button>
			<div class="dropdown-menu">
		      <a class="dropdown-item" href="bill.do">청구서</a>
		      <a class="dropdown-item" href="reservation_specification.do">예약 명세서</a>
		      <a class="dropdown-item" href="financial_overview.do">재무 개요</a>
		      <a class="dropdown-item" href="account_info">은행 계좌 정보</a>
		    </div>
		</div>
	</div>
</div>
<div class="container-fluid full_color">
	<!-- 				미구현
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
			</tr>
		</table>
	-->	
