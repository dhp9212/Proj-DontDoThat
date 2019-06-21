<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../_buisness_top.jsp"%>
<style>
	.border{
		margin: 15;
		padding: 10;
		background-color: white;
	}
	.menu{
		margin: 15;
		padding: 10;
	}
</style>
<div class="container-fluid" style="background-color:#fafafa">
	<div class="container">
		<div class="row" style="height:70;">
			<div class="col-sm-12  border"><font size="5">숙소 정보</font></div>
		</div>
		<div class="row" style="height:50;">
			<div class="col-sm-12 border">
				<div class="row">
					<div class="col-sm-4"><font>숙소 이름 : ${accomodation_dto.accomodation_name}</font></div>
					<div class="col-sm-8"><font>숙소 주소 : ${accomodation_dto.city} ${accomodation_dto.address}</font></div>
				</div>
			</div>
		</div>
		<div class="row" style="height:270">
			<div class="col-sm-12 menu">
				<div class="dropdown dropright" style="height:100;">
					<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
						숙소 수정메뉴
					</button>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="accomodation_facility.do">숙소시설 및 서비스</a>
						<a class="dropdown-item" href="accomodation_content.do">내 숙소 설명 보기</a>
						<a class="dropdown-item" href="policy.do">정책 변경</a>
						<a class="dropdown-item" href="picture.do">사진 변경</a>
						<a class="dropdown-item" href="nearby.do">숙소 근처에는 무엇이 있나요?</a>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-7"></div>
		</div>
		<c:forEach var="table" items="${room_list}" varStatus="num">
		<div class="row">
			<div class="col-sm-12 border">
				<div class="row">
					<div class="col-sm-4">방 이름 : ${table.value.roomname}</div>
					<div class="col-sm-3">방 종류 : ${table.value.roomclass}</div>
					<div class="col-sm-2">수량 : ${table.value.qty}</div>
					<div class="col-sm-2"><a href="room_facility.do?room_num=${table.value.num}">방 설정 변경</a></div>
				</div>
			</div>
		</div>
		</c:forEach>
	</div>
</div>
<%@ include file="../_buisness_bottom.jsp"%>