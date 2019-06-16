<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<!-- bootstrap -->
    <meta name="viewport" content="initial-scale=1.0">
    <meta charset="utf-8">
  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/datepicker/datepicker.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery.dropotron.min.js"></script>
	<script type="text/javascript">
	$(function(){
		// Dropdowns.
			$('#nav > ul').dropotron({
				mode: 'fade',
				noOpenerFade: true,
				speed: 300
			});
	});
	</script>
<!-- --------- -->
	<title>Hacking.com</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />
  	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/datepicker.css">
  	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css"/>
  	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/noscript.css" />
  	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery.auto-complete.css" />
  	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style_reservation.css"/>
</head>
<body class="is-preload homepage">
	<div id="page-wrapper">
	<!-- Header -->
	<div id="header-wrapper">
		<header id="header" class="container">
			<!-- Logo -->
				<div id="logo">
					<h1><a href="home.do" >Hacking.com</a></h1>
				</div>

			<!-- Nav -->
				<nav id="nav">
					<ul>
						
						<c:if test="${userSession == null}">
						<li id="signon"><a href="signUp.do">가입하기</a></li>
						<li id="login"><a href="login.do">로그인</a></li>
						</c:if>
						<c:if test="${userSession != null}">
						<li><a href="insertRoom.do">내 숙소 등록</a></li>
						<img style="width:50px; height:50px;" src="${pageContext.request.contextPath}/resources/img/profileImage/${userSession.profilePhoto}">
						<li id="myAccount" style=""><a href="#">나의 계정</a>
							<ul>
								<li><a href="mySettings.do">마이페이지</a></li>
							<c:if test="${!empty accomodation_list}">
								<li><a href="buisness_index.do">사업자 홈페이지</a></li>
							</c:if>
								<li><a href="reservation_list.do?num=${userSession.num}">예약</a></li>
								<li><a href="reviewMain.do">이용 후기</a></li>
								<li><a href="myList.do">마이리스트</a></li>
								<li><a href="customerService.do">고객 서비스 지원</a></li>
								<li><a href="logoutOk.do">로그 아웃</a></li>
							</ul>
						</li>
						</c:if>
						<li></li>
					</ul>
				</nav>

		</header>
	</div>