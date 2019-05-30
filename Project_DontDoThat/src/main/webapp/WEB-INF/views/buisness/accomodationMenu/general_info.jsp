<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../_buisness_top.jsp"%>
<table style="height:70%">
	<tr>
		<td class="m1">일반 정보</td>
	</tr>
	<tr>
		<td>
			<table>
				<tr>
					<td>${accomodation_dto.image}</td>
				</tr>
				<tr>
					<td>숙소 이름</td>
					<td>${accomodation_dto.accomodation_name}</td>
				</tr>
				<tr>
					<td>숙소 주소</td>
					<td>${accomodation_dto.city} ${accomodation_dto.address}</td>
				</tr>
				<tr>
					<td><a href="accomodation_facility.do">시설 및 서비스</a></td>
					<td><a href="accomodation_content.do">내 숙소 설명 보기</a></td>
					<td><a href="policy.do">정책 변경</a></td>
				</tr>
				<tr>
					<td><a href="onTheWay.do">${accomodation_dto.accomodation_name}까지 찾아오는 길</a></td>
					<td><a href="picture.do">사진 변경</a>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table>
				<c:forEach var="table" items="${room_list}" varStatus="num">
				<tr>
					<td>${table.value.roomname}</td>
					<td>${table.value.roomclass}</td>
					<td>${table.value.qty}</td>
					<td><a href="room_facility.do?room_num=${table.value.num}">방 설정 변경</a></td>
				</tr>
				</c:forEach>
			</table>
		</td>
	</tr>
</table>
<%@ include file="../_buisness_bottom.jsp"%>