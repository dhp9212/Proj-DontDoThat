<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_buisness_top.jsp"%>
<script type="text/javascript">
	$(document).ready(function(){
		var price = $('.price')
		for(var i=0; i<price.length; ++i){
			setComma($(price).eq(i).text())
		}
	})
</script>
<div class="container-fluid" style="background-color:#fafafa">
	<div class="container" style="overflow: auto; height: 80%; padding: 15;">
		<div class="row border-bottom" style="font-size:16;" align="center">
			<div class="col-sm-1">예약번호</div>
			<div class="col-sm-3">숙소 정보</div>
			<div class="col-sm-2">방 정보</div>
			<div class="col-sm-1">예약수</div>
			<div class="col-sm-3">예약기간</div>
			<div class="col-sm-2">요금</div>
		</div>
		<c:set var="total" value="0"/>
		<c:forEach var="reservation" items="${buisness_b_reservation}">
			<div class="row" align="center">
				<div class="col-sm-1">${reservation.num}</div>
				<c:forEach var="accomodation" items="${accomodation_list}">
				<c:if test="${accomodation.key==reservation.accomodation_num}">
				<div class="col-sm-3"><a href="general_info.do?accomodation_num=${accomodation.key}">${accomodation.value.accomodation_name}</a></div>
					<c:forEach var="room" items="${buisness_b_room_list}">
					<c:if test="${reservation.room_num==room.num}">
					<c:set var="room_price" value="${room.price}"/>
					<div class="col-sm-2">${room.roomclass}</div>
					<div class="col-sm-1">${reservation.rooms}</div>
					</c:if>
					</c:forEach>
				</c:if>
				</c:forEach>
				<div class="col-sm-3">${reservation.checkIn_date} ~ ${reservation.checkOut_date}</div>
				<div class="col-sm-2 price">${room_price*reservation.rooms}</div>
			</div>
		<c:set var="total" value="${total + room_price*reservation.rooms}"/>
		</c:forEach>
		<div class="row border-top">
			<div class="col-sm-10" align="right">예약 완료 금액 </div>
			<div class="col-sm-2 price" align="center">${total}</div>
		</div>
	</div>
</div>
<%@ include file="../_buisness_bottom.jsp"%>