<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../top.jsp" %>
	<div>
		<form id="reservation" action="accomodation_reservation.do" method="post">
		<input type="hidden" name="num" value="${num}" />
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
					<td>
						[${getAccomodation.category_accomodation}]<h3><b>${getAccomodation.accomodation_name}</b></h3>
					</td>
				</tr>
				<tr>
					<td>
						${getAccomodation.address}, ${getAccomodation.city}, ${getAccomodation.country} - <a href="">좋은 위치 - 지도에서 보기</a>
					</td>
				</tr>
			</table>
			<img src="image/${getAccomodation.image}" width="200" height="200" border="0">
			<table border="0" width="100%">
				<tr>
					<td width="70%" rowspan="2">${getAccomodation.content}</td>
					<td width="30%" bgcolor="skyblue">
						<h4>이용 후기</h4><br>
					</td>
				</tr>
			</table>
			<h3><b>예약 가능 여부</b></h3>
			<table border="0" width="100%">
				<tr>
					<td>체크인 날짜<br>
						<input autocomplete="off" name="checkIn_date" type="text" placeholder="체크인" aria-label="First name" class="start-date" style="width:12%; height:50px;" size="0">
				    </td>
					<td>체크아웃 날짜<br>
						<input autocomplete="off" name="checkOut_date" type="text" placeholder="체크아웃" aria-label="Last name" class="end-date" style="width:12%; height:50px;" size="0">
					</td>
					<td>
						<input type="button" value="객실 확인" onClick="location.href='search.do'">
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
					<td>
						현재 예약 가능한 방이 없습니다.
					</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="dto" items="${getRoomList}">
				<tr>
					<td>최대 ${dto.value.people}명</td>
					<td>
						<a href="accomodation_reservation.do?num=${dto.value.num}">
							${dto.value.roomname} - ${dto.value.roomclass}
						</a><br>${dto.value.room_facility}
					</td>
					<td>
						<input type="submit" value="지금 예약">
					</td>
				</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
			</table>
		<h3><b>하우스 룰</b></h3><br>${getAccomodation.policy}
		</form>
	</div>
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