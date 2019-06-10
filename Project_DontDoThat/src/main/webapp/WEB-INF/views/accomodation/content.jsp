<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../top.jsp" %>
	<table width="100%">
		<tr>
			<th colspan="2">지역</th><td><div id="map"></div></td>
		</tr>
		<tr>
			<td width="30%;">
				<div>
					<table border="2">
						<tr>
							<tr><th>검색</th></tr>
							<tr><td>여행지/숙소이름</td></tr>
							<tr><td><input type="text" value="${input_place}"></td></tr>
							<tr><td>체크인 날짜</td></tr>
							<tr><td><input type="text" value="${start_date}"></td></tr>
							<tr><td>체크아웃 날짜</td></tr>
							<tr><td><input type="text" value="${end_date}"></td></tr>
							<tr></tr>
							<tr>
								<td>
									<select name="adults">
									<c:forEach var="i" begin="1" end="30">
										<option value="i">성인 ${i}명</option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td>
									<select name="children">
										<option value="0">동반 아동 없음</option>
									<c:forEach var="i" begin="1" end="10">
										<option value="i">아동 ${i}명</option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td>
									<select name="rooms">
									<c:forEach var="i" begin="1" end="30">
										<option value="i">객실 ${i}개</option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr><td><input type="button" value="검 색" onClick="location.href='accomodation_list.do?input_place=${input_place}&start_date=${start_date}&end_date=${end_date}&people=${adults + children}&rooms=${rooms}'"></td></tr>
					</table>
				</div>
			</td>
	<!-- datalist -->
			<td width="70%;">
				<div>
					<table border="1" width="100%">
						<tr>
							<th width="35%">옵션 정보 & 요금</th>
							<th width="10%">시설</th>
							<th width="20%">하우스 룰</th>
							<th width="35%">고객 후기</th>
						</tr>
					</table>
					<table border="0" width="100%">
						<tr>
							<td><h3><b>[${getAccomodationInfo.category_accomodation}]${getAccomodationInfo.accomodation_name}</b></h3></td>
							<td align="right">
								<input type="button" value="지금 예약" onClick="location.href='#reservation'">
							</td>
						</tr>
						<tr>
							<td colspan="2">${getAccomodationInfo.address}, ${getAccomodationInfo.city}, ${getAccomodationInfo.country} - <a href="">좋은 위치 - 지도에서 보기</a></td>
						</tr>
					</table>
					<img src="image/${getAccomodationInfo.image}" width="200" height="200" border="0">
					<table border="0" width="100%">
						<tr>
							<td width="70%" rowspan="2">${getAccomodationInfo.content}</td>
							<td width="30%" bgcolor="skyblue">
								<h4>이용 후기</h4><br>
							</td>
						</tr>
					</table>
					<h3 id="reservation"><b>예약 가능 여부</b></h3>
					<table border="0" width="100%">
						<tr>
							<td>체크인 날짜<br>
								<input value="${start_date}" autocomplete="off" name="checkIn_date" type="text" placeholder="체크인" aria-label="First name" class="start-date" style="width:12%; height:50px;" size="0">
						    </td>
							<td>체크아웃 날짜<br>
								<input value="${end_date}" autocomplete="off" name="checkOut_date" type="text" placeholder="체크아웃" aria-label="Last name" class="end-date" style="width:12%; height:50px;" size="0">
							</td>
							<td>
								<input type="button" value="객실 확인" onClick="location.href='accomodation_list.do?input_place=${input_place}&start_date=${start_date}&end_date=${end_date}&people=${adults + children}&rooms=${rooms}'">
							</td>
						</tr>
						<tr>
							<td>객실
								<select name="rooms">
								<c:forEach var="i" begin="1" end="30">
									<option value="i">${i}</option>
								</c:forEach>
								</select>
							</td>
							<td>성인
								<select name="adults">
								<c:forEach var="i" begin="1" end="30">
									<option value="i">${i}</option>
								</c:forEach>
								</select>
							</td>
							<td>어린이
								<select name="children">
								<c:forEach var="i" begin="0" end="10">
									<option value="i">${i}</option>
								</c:forEach>
								</select>
							</td>
						</tr>
					</table>
					<table border="1" width="100%">
						<tr>
							<td>정원</td>
							<td>객실 유형</td>
							<td></td>
						</tr>
				<c:choose>
					<c:when test="${empty getRoomList}">
						<tr>
							<td>현재 예약 가능한 방이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="dto" items="${getRoomList}">
						<tr>
							<td>최대 ${dto.value.people}명</td>
							<td>
								<a href="accomodation_reservation.do?num=${dto.value.num}&accomodation_num=${getAccomodationInfo.num}&start_date=${start_date}&end_date=${end_date}">${dto.value.roomname} - ${dto.value.roomclass}</a><br>${dto.value.room_facility}
							</td>
							<td>
								<input type="button" value="지금 예약" onClick="location.href='accomodation_reservation.do?num=${dto.value.num}&accomodation_num=${getAccomodationInfo.num}&start_date=${start_date}&end_date=${end_date}'">
							</td>
						</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
					</table>
					<h3><b>하우스 룰</b></h3><br>${getAccomodationInfo.policy}
				</div>
			</td>
		</tr>
	</table>
	<script src="${pageContext.request.contextPath}/resources/js/datepicker/datepicker.js"></script>
	<script>
			$(function() {
			    var $startDate = $('.start-date');
			    var $endDate = $('.end-date');
			    $startDate.datepicker({
			      autoHide: true,
			      startDate : new Date(this.date)
			    });
			    $endDate.datepicker({
			      autoHide: true,
			      startDate: $startDate.datepicker('getDate'),
			    });
			    $startDate.on('change', function () {
			      $endDate.datepicker('setStartDate', $startDate.datepicker('getDate'));
			    });
			});
	</script>
</body>
</html>