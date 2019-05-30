<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="initial-scale=1.0">
    <meta charset="utf-8">
  	
	<title>Hacking.com</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css" />
  	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/datepicker.css">
  	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css">
  	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/noscript.css" />
</head>
<body class="is-preload homepage">
	<div id="page-wrapper">
	<!-- Header -->
	<div id="header-wrapper">
		<header id="header" class="container">
			<!-- Logo -->
				<div id="logo">
					<h1><a href="">Hacking.com</a></h1>
				</div>

			<!-- Nav -->
				<nav id="nav">
					<ul>
						<li><a href="#">c</a></li>
						<li><a href="#">N</a></li>
						<li><a href="insertRoom.do">내 숙소 등록</a></li>
						<c:if test="${userSession == null}">
						<li id="signon"><a href="signUp.do">가입하기</a></li>
						<li id="login"><a href="login.do">로그인</a></li>
						</c:if>
						<c:if test="${userSession != null}">
						<img style="width:50px; height:50px;" src="${pageContext.request.contextPath}/resources/img/Penguins.jpg">
						<li id="myAccount" style=""><a href="#">나의 계정</a>
							<ul>
								<li><a href="adminMain.do">마이페이지</a></li>
								<li><a href="#">예약</a></li>
								<li><a href="#">내 Wallet</a></li>
								<li><a href="#">보고서</a></li>
								<li><a href="reviewMain.do">이용 후기</a></li>
								<li><a href="#">마이리스트</a></li>
								<li><a href="#">앱 받으러 가기</a></li>
								<li><a href="customerService.do">고객 서비스 지원</a></li>
								<li><a href="#">설정</a></li>
								<li><a href="#">로그 아웃</a></li>
							</ul>
						</li>
						</c:if>
						<li></li>
					</ul>
				</nav>

		</header>
	</div>