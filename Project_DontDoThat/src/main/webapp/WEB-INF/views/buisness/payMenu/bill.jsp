<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../_buisness_top.jsp"%>
<script>
	$(document).ready(function() {
		var today = new Date();
		var month = today.getMonth()+1
		if(month<10) month='0'+month
		var all_price = 0
		var price = 0
		var hidden
		var myPrice
		var length = $('input[name="count"]').length
		for(var j=0; j<length; ++j){
			var hidden = $('input[name="' + j + '"]')
			price = 0
			for(var i=0; i<hidden.length; ++i){
				price += Number(hidden[i].value)
			}
			price = price/100*15
			all_price += price
			myPrice = setComma(''+price)
			if($('#'+j).prev().prev().text()=='2019/'+month) $('#'+j).text('현재까지 : ' + myPrice + '원')
			else $('#'+j).text(myPrice + '원')
		}
		
		var price = $('.price')
		for(var i=0; i<price.length; ++i){
			var str = setComma($(price).eq(i).text())
			$(price).eq(i).text(str+' 원')
		}
		$('#total').text(setComma(''+all_price) + '원')
	})
	var rgx2 = /(\d+)(\d{3})/;
	function setComma(inNum){
	     var outNum
	     outNum = inNum
	     while (rgx2.test(outNum)) {
	         outNum = outNum.replace(rgx2, '$1' + ',' + '$2')
	     }
	     return outNum;
	}
</script>
<div class="container-fluid" style="background-color:#fafafa">
	<div class="container" style="overflow: auto; height: 80%; padding: 15;">
		<div class="row" style="font-size:16;" align="center">
			<div class="col-sm-12">지불하실 내역<br></div>
		</div>
		<div class="row border-bottom" style="font-size:16;" align="center">
			<div class="col-sm-1">월</div>
			<div class="col-sm-8"></div>
			<div class="col-sm-3">요금</div>
		</div>
		<c:forEach var="reservation_list" items="${buisness_bill}" varStatus="num">
		<c:set var="have" value=""/>
		<input type="hidden" name="count">
		<c:forEach var="reservation" items="${reservation_list.value}">
		<c:if test="${fn:substring(reservation.checkOut_date,0,7)==reservation_list.key}">
		<c:set var="have" value="have"/>
		</c:if>
		</c:forEach>
		<c:if test="${!empty have}">
			<div class="row" align="center">
				<div class="col-sm-1 pt-1">${reservation_list.key}</div>
				<div class="col-sm-8" align="center">
					<button type="button" class="btn pt-1" data-toggle="modal" data-target="#myModal${num.count}">
						내역보기
					</button>
					<div class="modal" id="myModal${num.count}">
						<div class="modal-dialog modal-xl">
							<div class="modal-content">
						    	<!-- Modal Header -->
								<div class="modal-header">
								  <h4 class="modal-title">예약내역</h4>
								  <button type="button" class="close" data-dismiss="modal"></button>
								</div>
								<!-- Modal body -->
								<div class="modal-body">
									<table class="table">
										<tr>
											<th>예약 번호</th>
											<th>날짜</th>
											<th>숙소 내역</th>
											<th>고객 정보</th>
											<th>결제액</th>
										</tr>
										<c:forEach var="reservation" items="${reservation_list.value}">
										<c:if test="${fn:substring(reservation.checkOut_date,0,7)==reservation_list.key}">
										<tr>
											<td>${reservation.num}</td>
											<td>${reservation.checkIn_date} ~ ${reservation.checkOut_date}</td>
											<td>
												<c:forEach var="accomodation" items="${accomodation_list}">
												<c:if test="${accomodation.key==reservation.accomodation_num}">
													<c:forEach var="room" items="${buisness_b_room_list}">
													<c:if test="${reservation.room_num==room.num}">
													<a href="general_info.do?accomodation_num=${accomodation.key}">${accomodation.value.accomodation_name}</a>
													 - ${room.roomclass} * ${reservation.rooms}
													<input type="hidden" name="${num.index}" value="${room.price*reservation.rooms}">
													<c:set var="price" value="${room.price*reservation.rooms}"/>
													</c:if>
													</c:forEach>
												</c:if>
												</c:forEach>
											</td>
											<td style="padding: 0">
												<c:forEach var="account" items="${buisness_b_account}">
												<c:if test="${account.key==reservation.account_num}">
												<div class="dropdown">
													<button type="button" class="btn dropdown-toggle" data-toggle="dropdown">
														고객정보
													</button>
													<div class="dropdown-menu">
														<a class="dropdown-item">${reservation.first_name}${reservation.last_name}</a>
														<a class="dropdown-item">${account.value.email}</a>
														<a class="dropdown-item">${reservation.country}</a>
													</div>
												</div>
												</c:if>
												</c:forEach>
											</td>
											<td class="price">${price}</td>
										</tr>
										</c:if>
										</c:forEach>
									</table>
								</div>
								<!-- Modal footer -->
								<div class="modal-footer">
								  <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-3 pt-1" id="${num.index}"></div>
			</div>
		</c:if>
		</c:forEach>
		<div class="row border-top">
			<div class="col-sm-9" align="right">총 금액</div>
			<div class="col-sm-3" align="center" id="total"></div>
		</div>
	</div>
</div>
<%@ include file="../_buisness_bottom.jsp"%>