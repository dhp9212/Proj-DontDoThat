<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
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
	.text_white{
		color: white;
	}
	.cellRight{
		width:
	}
</style>
</head>
<body>
<div>
	<div class="row" style="background-color:#000080;">
		<div class="col-sm-4">
			<nav class="navbar navbar-expand-sm">
				<ul class="navbar-nav">
					<li class="nav-item">
						<h1><a class="nav-link text_white" href="home.do">Hacking.com</a></h1>
					</li>
				</ul>
			</nav>
		</div>
		<div class="col-sm-8" style="padding: 20 60 0 0;">
			<nav class="navbar navbar-expand-sm float-right">
				<ul class="navbar-nav">
					<li class="nav-item">
					  <form class="form-inline" action="/action_page.php">
					    <input class="form-control mr-sm-2" type="text" placeholder="Search">
					    <button class="btn btn-success" type="submit" style="margin: 0 10 0 0;">Search</button>
					  </form>
					</li>
					<li class="nav-item">
						<a class="nav-link text_white" href="#">사용자</a>
					</li>
					<li class="nav-item">
						<div class="dropdown">
							<button type="button" class="btn text_white dropdown-toggle" data-toggle="dropdown">
								숙소
							</button>
							<div class="dropdown-menu">
								<c:forEach var="dto" items="${accomodation_list}" varStatus="num">
								<a class="dropdown-item" href="general_info.do?accomodation_num=${dto.value.num}">${dto.value.accomodation_name}</a>
								</c:forEach>
							</div>
						</div>
					</li>
				</ul>
			</nav>
		</div>
	</div>
	<c:if test="${!empty accomodation_num}">
	<div class="row" style="background-color:#000080;">
		<div style="margin:0 10 0 30;" class="col-sm-11"><a href="general_info.do"><font class="text-white">숙소 정보</font></a></div>
	</div>
	</c:if>
	<div class="row" style="background-color:blue;">
		<div class="col-sm-4">
			<nav class="navbar navbar-expand-sm">
				<ul class="navbar-nav">
				  	<li class="nav-item">
				      <a class="nav-link text_white" href="buisness_index.do">사업자 홈으로</a>
				    </li>
				    <li class="nav-item">
				      <a class="nav-link text_white" href="#">예약</a>
				    </li>
				    <li class="nav-item">
				      <a class="nav-link text_white" href="custom_review.do">이용후기</a>
				    </li>
				</ul>
			</nav>
		</div>
		<div class="col-sm-8" style="padding: 0 60 0 0;">
			<nav class="navbar navbar-expand-sm float-right">
				<ul class="navbar-nav">
					<li class="nav-item dropdown">
					    <a class="nav-link text_white dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
					    	메세지
					    </a>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="custom_message.do">고객 메세지</a>
							<a class="dropdown-item" href="admin_message.do">dontDoThat 메세지</a>
						</div>
					</li>
					<li class="nav-item dropdown">
					    <a class="nav-link text_white dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
					    	재무
					    </a>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="bill.do">청구서</a>
							<a class="dropdown-item" href="reservation_specification.do">예약 명세서</a>
							<a class="dropdown-item" href="financial_overview.do">재무 개요</a>
							<a class="dropdown-item" href="account_info.do">은행 계좌 정보</a>
						</div>
					</li>
			  </ul>
			</nav>
		</div>
	</div>
</div>
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
