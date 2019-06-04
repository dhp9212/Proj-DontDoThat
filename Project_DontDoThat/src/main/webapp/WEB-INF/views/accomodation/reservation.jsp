<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ include file="../top.jsp" %>
	<div>
		<form name="reservation" action="accomodation_reservation.do" method="post" >
		<table>
			<tr>
				<td>
					<div>
						<table border="1" width="100%">
							<tr>
								<td bgcolor="skyblue">�� ���� ����</td>
							</tr>
							<tr>
								<td>
									üũ�� :<br>${start_date}<br>
									üũ�ƿ� :<br>${end_date}<br>
									<a href="">��¥ ����</a>
								</td>
							</tr>
							<tr>
								<td>
									���� ���� :<br>${getRoom.roomname}<br>
									<a href="">�ٸ� ���Ƿ� ����</a>
								</td>
							</tr>
						</table>
						<table border="1" width="100%">
							<tr>
								<td bgcolor="skyblue">���� ��� ����</td>
							</tr>
							<tr>
								<td></td>
							</tr>
						</table>
					</div>
				</td>
				<td>
					<div>
						<table border="0" width="100%">
							<tr>
								<td><img src="image/${image}" width="200" height="200" border="0"></td>
								<td>
									<h3><b>${accomodation_name}</b></h3><br>
									${address}, ${city}, ${country}
								</td>
							</tr>
						</table>
						<h3>�� ���� �Է�</h3>
						<table border="0" bgcolor="skyblue">
							<tr>
								<td>��(����)<br><input type="text" name="last_name" class="box"></td>
								<td>�̸�(����)<br><input type="text" name="first_name" class="box"></td>
							</tr>
							<tr>
								<td colspan="2">�̸��� �ּ�<br>
							<c:choose>
								<c:when test="${empty userSession}">
									<input type="text" name="email" class="box">���� Ȯ�μ��� ���۵� �̸��� �ּ� �Է�
								</c:when>
								<c:otherwise>
									<input type="text" name="email" class="box" value="${getAccount.email}">���� Ȯ�μ��� ���۵� �̸��� �ּ� �Է�
								</c:otherwise>
							</c:choose>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									����/����<br>
									<select name="country">
										<option value="default">-- --����/���� ����-- --</option>
									<c:forEach var="country" items="${selectCountry}">
										<option>${country.name}</option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2">��ȭ��ȣ (������ ��� �޴���)<br>
							<c:choose>
								<c:when test="${empty userSession}">
									<input type="text" name="tel" class="box" maxlength="11">
								</c:when>
								<c:otherwise>
									<input type="text" name="tel" class="box" maxlength="11" value="${getAccount.tel}">
								</c:otherwise>
							</c:choose>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<table>
										<tr>
											<td><h4><b>${getRoom.roomname}</b></h4></td>
											<td>${getRoom.price}</td>
										</tr>
										<tr>
											<td colspan="2">�̿� �ı�</td>
										</tr>
										<tr>
											<td colspan="2">�ִ� ���� �ο� : ${getRoom.people}��</td>
										</tr>
										<tr>
											<td colspan="2">������ ����<br>
										<c:choose>
											<c:when test="${empty userSession}">
												<input type="text" name="tel" class="box">
											</c:when>
											<c:otherwise>
												<input type="text" name="tel" class="box" value="${getAccount.name}">
											</c:otherwise>
										</c:choose>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<input type="button" value="���� �Ϸ�" onClick="javascript:check();">
					</div>
				</td>
			</tr>
		</table>
		</form>
	</div>
	<script type="text/javascript">
	function check(){
		var session = '${userSession}'
		if(session == ''){
			document.reservation.action = 'loginFromReservation.do'
			document.reservation.submit();
		}
		else{
			document.reservation.submit();
		}
	}
	</script>
</body>
</html>