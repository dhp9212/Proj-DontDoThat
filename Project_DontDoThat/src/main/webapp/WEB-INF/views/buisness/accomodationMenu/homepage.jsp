<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_buisness_top.jsp"%>
<script>
	$(document).ready(function() {
		var imgs = "${accomodation_dto.image}".split(',')
		var path = "resources/img/"
		for(var i in imgs){
			$('.image').append('<div class="col-sm-2"><img width="150" height="120" src="' + path + imgs[i] + '"></div>')
		}
	})
</script>
<style>
	.title{
		margin: 30 0 30 0;
	}
</style>
<c:if test="${empty accomodation_dto.homepage}">
	<font size="4">아직 홈페이지를 등록하지 않았습니다.</font>
	<input type="text" name="homepage">
	<input type="submit" value="등록하기">
</c:if>
<c:if test="${!empty accomodation_dto.homepage}">
<div class="container">
	<div class="row">
		<div class="col-sm-12 title" align="center">
			<font size="5">${accomodation_dto.category_accomodation} ${accomodation_dto.accomodation_name}</font>	
		</div>
	</div>
	<div class="row image">
	</div>

	<div class="row title">
		<div class="col-sm-6">
			<table class="table table-bordered">
				<tr>
					<th>방 종류</th>
					<th>가격</th>
					<th>예약</th>
				</tr>
			<c:forEach var="room_dto" items="${room_list}">
				<tr>
					<td>${room_dto.value.roomclass}</td>
					<td>${room_dto.value.price}</td>
					<td><a href="">예약하기</a></td>
				</tr>
			</c:forEach>
			</table>
		</div>
		<div class="col-sm-6"></div>
	</div>
	<c:forEach var="room_dto" items="${room_list}">
	<div class="row">
		<div class="col-sm-12" align="center">
			${room_dto.value.roomname}, ${room_dto.value.roomclass}, ${room_dto.value.qty}
		</div>
	</div>
	</c:forEach>
</div>
</c:if>
<%@ include file="../_buisness_bottom.jsp"%>