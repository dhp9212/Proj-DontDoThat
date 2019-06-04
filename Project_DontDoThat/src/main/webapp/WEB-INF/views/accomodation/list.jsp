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
							<tr>
								<td>
									<input type="button" value="�� ��" onClick="location.href=''">
								</td>
							</tr>
					</table>
				</div>
			</td>
	<!-- datalist -->
			<td width="70%;">
				<div>
	<c:choose>
		<c:when test="${empty listAccomodation}">
					<table border="0" width="70%">
				  		<tr>
				  			<td><h1>�� ���� ��, Ȥ�� �α� ���� ������ ���� 0��</h1></td>
							<td align="right"><a href="">������ ����</a></td>
						</tr>
					</table>
					<table border="1" width="100%">
				  		<tr>
							<td align="center">
								<h2>���ϴ� �˻������ ��� ���</h2><br>
								<h3>���� �ɼ��� ����Ͽ� ���ϴ� ���Ҹ� ã�ƺ����� :</h3>
							</td>
						</tr>
						<tr><td>���� �˻�â ���</td></tr>
					</table>
		</c:when>
		<c:otherwise>
					<table border="0" width="100%">
						<tr>
							<td><h1>�˻��� ����</h1></td>
							<td align="right"><a href="">������ ����</a></td>
						</tr>
					</table>
					<table border="1" width="100%">
						<tr>
							<th width="15%">���</th>
							<th width="20%">�ı� ����</th>
							<th width="30%">�ı� ���� + ���</th>
							<th width="15%">����</th>
							<th width="20%">���� + ���</th>
						</tr>
					</table>
			<c:forEach var="dto" items="${listAccomodation}">
					<table border="0" width="100%">
						<tr>
							<td width="25%" rowspan="4">
								<img src="image/${dto.image}" width="200" height="200" border="0">
							</td>
							<td width="50%">
								<a href="search_accomodation_content.do?num=${dto.num}">
									<h3>[${dto.category_accomodation}]${dto.accomodation_name}</h3>
								</a>
							</td>
							<td width="25%" align="right">�̿� �ı� ����</td>
						</tr>
						<tr>
							<td width="50%"><a href="">${dto.city} - �������� ǥ��</a></td>
							<td width="25%" align="right" rowspan="2">
								<input type="button" value="��� ǥ��" onClick="location.href=''">
							</td>
						</tr>
						<tr><td width="50%">${dto.content}</td></tr>
						<tr>
							<td colspan="2" align="right">
								<input type="button" value="���� ���� �ɼ� ����" onClick="location.href='search_accomodation_content.do?num=${dto.num}'">
								<input type="hidden" name="start_date" value="${start_date}" />
								<input type="hidden" name="end_date" value="${end_date}" />
							</td>
						</tr>
					</table>
			</c:forEach>
		</c:otherwise>
	</c:choose>
				</div>
			</td>
		</tr>
	</table>
	<script>
      var map;
      function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: -34.397, lng: 150.644},
          zoom: 8
        });
      }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD_7jiKyn69S94Q7zgR4IOgQ4-BJ4sL6B4&callback=initMap"
    async defer></script>
</body>
</html>