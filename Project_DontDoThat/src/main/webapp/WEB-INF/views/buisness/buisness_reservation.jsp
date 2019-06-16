<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="_buisness_top.jsp"%>
<div class="container-fluid" style="background-color:#fafafa">
	<div class="container" style="overflow: auto; height: 80%; padding: 15;">
		<div class="row border-bottom" style="font-size:16;" align="center">
			<div class="col-sm-1">예약번호</div>
			<div class="col-sm-3">숙소 정보</div>
			<div class="col-sm-2">방 정보</div>
			<div class="col-sm-1">예약수</div>
			<div class="col-sm-3">예약기간</div>
			<div class="col-sm-2"></div>
		</div>
		<c:forEach var="reservation" items="${buisness_a_reservation}" varStatus="num">
			<div class="row" align="center">
				<div class="col-sm-1">${reservation.num}</div>
				<c:forEach var="accomodation" items="${accomodation_list}">
				<c:if test="${accomodation.key==reservation.accomodation_num}">
				<div class="col-sm-3"><a href="general_info.do?accomodation_num=${accomodation.key}">${accomodation.value.accomodation_name}</a></div>
					<c:forEach var="room" items="${buisness_a_room_list}">
					<c:if test="${reservation.room_num==room.num}">
					<div class="col-sm-2">${room.roomclass}</div>
					<div class="col-sm-1">${reservation.rooms}</div>
					</c:if>
					</c:forEach>
				</c:if>
				</c:forEach>
				<div class="col-sm-3">${reservation.checkIn_date} ~ ${reservation.checkOut_date}</div>
				<c:forEach var="account" items="${buisness_a_account}">
				<c:if test="${account.key==reservation.account_num}">
				<div class="col-sm-2">
					<button type="button" class="btn" data-toggle="modal" data-target="#myModal${num.count}">
						고객정보 보기
					</button>
					<div class="modal" id="myModal${num.count}">
						<div class="modal-dialog">
							<div class="modal-content">
						    	<!-- Modal Header -->
								<div class="modal-header">
								  <h4 class="modal-title">예약 고객 정보</h4>
								  <button type="button" class="close" data-dismiss="modal"></button>
								</div>
								<!-- Modal body -->
								<div class="modal-body">
									<table class="table">
										<tr>
											<th>이름</th>
											<th>email</th>
											<th>나라</th>
										</tr>
										<tr>
											<td>${account.value.name}</td>
											<td>${account.value.email}</td>
											<td>${account.value.country}</td>
										</tr>
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
				</c:if>
				</c:forEach>
			</div>
		</c:forEach>
	</div>
</div>
<%@ include file="_buisness_bottom.jsp"%>