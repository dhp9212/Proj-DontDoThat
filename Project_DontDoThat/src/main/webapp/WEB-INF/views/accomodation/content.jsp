<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../top.jsp" %>
	<table width="100%">
		<tr>
			<th colspan="2">����</th><td><div id="map"></div></td>
		</tr>
		<tr>
			<td width="30%;">
				<div>
					<table border="2">
						<tr>
							<tr><th>�˻�</th></tr>
							<tr><td>������/�����̸�</td></tr>
							<tr><td><input type="text" value="${input_place}"></td></tr>
							<tr><td>üũ�� ��¥</td></tr>
							<tr><td><input type="text" value="${start_date}"></td></tr>
							<tr><td>üũ�ƿ� ��¥</td></tr>
							<tr><td><input type="text" value="${end_date}"></td></tr>
							<tr></tr>
							<tr>
								<td>
									<select name="adults">
									<c:forEach var="i" begin="1" end="30">
										<option value="i">���� ${i}��</option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td>
									<select name="children">
										<option value="0">���� �Ƶ� ����</option>
									<c:forEach var="i" begin="1" end="10">
										<option value="i">�Ƶ� ${i}��</option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td>
									<select name="rooms">
									<c:forEach var="i" begin="1" end="30">
										<option value="i">���� ${i}��</option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr><td><input type="button" value="�� ��" onClick="location.href=''"></td></tr>
					</table>
				</div>
			</td>
	<!-- datalist -->
			<td width="70%;">
				<div>
					<table border="1" width="100%">
						<tr>
							<th width="35%">�ɼ� ���� & ���</th>
							<th width="10%">�ü�</th>
							<th width="20%">�Ͽ콺 ��</th>
							<th width="35%">�� �ı�</th>
						</tr>
					</table>
					<table border="0" width="100%">
						<tr>
							<td>
								[${getAccomodationInfoInfo.category_accomodation}]<h3><b>${getAccomodationInfoInfo.accomodation_name}</b></h3>
							</td>
						</tr>
						<tr>
							<td>
								${getAccomodationInfo.address}, ${getAccomodationInfo.city}, ${getAccomodationInfo.country} - <a href="">���� ��ġ - �������� ����</a>
							</td>
						</tr>
					</table>
					<img src="image/${getAccomodationInfo.image}" width="200" height="200" border="0">
					<table border="0" width="100%">
						<tr>
							<td width="70%" rowspan="2">${getAccomodationInfo.content}</td>
							<td width="30%" bgcolor="skyblue">
								<h4>�̿� �ı�</h4><br>
							</td>
						</tr>
					</table>
					<h3><b>���� ���� ����</b></h3>
					<table border="0" width="100%">
						<tr>
							<td>üũ�� ��¥<br>
								<input value="${start_date}" autocomplete="off" name="checkIn_date" type="text" placeholder="üũ��" aria-label="First name" class="start-date" style="width:12%; height:50px;" size="0">
						    </td>
							<td>üũ�ƿ� ��¥<br>
								<input value="${end_date}" autocomplete="off" name="checkOut_date" type="text" placeholder="üũ�ƿ�" aria-label="Last name" class="end-date" style="width:12%; height:50px;" size="0">
							</td>
							<td>
								<input type="button" value="���� Ȯ��" onClick="location.href=''">
							</td>
						</tr>
						<tr>
							<td>����
								<select name="rooms">
								<c:forEach var="i" begin="1" end="30">
									<option value="i">${i}</option>
								</c:forEach>
								</select>
							</td>
							<td>����
								<select name="adults">
								<c:forEach var="i" begin="1" end="30">
									<option value="i">${i}</option>
								</c:forEach>
								</select>
							</td>
							<td>���
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
							<td>����</td>
							<td>���� ����</td>
							<td></td>
						</tr>
				<c:choose>
					<c:when test="${empty getRoomList}">
						<tr>
							<td>
								���� ���� ������ ���� �����ϴ�.
							</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="dto" items="${getRoomList}">
						<tr>
							<td>�ִ� ${dto.value.people}��</td>
							<td>
								<a href="accomodation_reservation.do?num=${dto.value.num}">
									${dto.value.roomname} - ${dto.value.roomclass}
								</a><br>${dto.value.room_facility}
							</td>
							<td>
								<input type="button" value="���� ����" onClick="location.href='accomodation_reservation.do?num=${dto.value.num}'">
								<input type="hidden" name="category_accomodation" value="${getAccomodationInfo.category_accomodation}" />
								<input type="hidden" name="accomodation_name" value="${getAccomodationInfo.accomodation_name}" />
								<input type="hidden" name="address" value="${getAccomodationInfo.address}" />
								<input type="hidden" name="city" value="${getAccomodationInfo.city}" />
								<input type="hidden" name="country" value="${getAccomodationInfo.country}" />
								<input type="hidden" name="image" value="${getAccomodationInfo.image}" />
								<input type="hidden" name="start_date" value="${start_date}" />
								<input type="hidden" name="end_date" value="${end_date}" />
							</td>
						</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
					</table>
					<h3><b>�Ͽ콺 ��</b></h3><br>${getAccomodationInfo.policy}
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