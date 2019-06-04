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
									üũ�� :<br>${getAccomodation.checkIn_date}<br>
									üũ�ƿ� :<br>${getAccomodation.checkOut_date}<br>
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
								<td><img src="image/${getAccomodation.image}" width="200" height="200" border="0"></td>
								<td>
									<h3><b>${getAccomodation.accomodation_name}</b></h3><br>
									${getAccomodation.address}, ${getAccomodation.city}, ${getAccomodation.country}
								</td>
							</tr>
						</table>
						<h3>�� ���� �Է�</h3>
						<table border="0" width="100%" bgcolor="skyblue">
							<tr>
								<td>��(����)<br><input type="text" name="last_name" class="box"></td>
								<td>�̸�(����)<br><input type="text" name="first_name" class="box"></td>
							</tr>
							<tr>
								<td>�̸��� �ּ�<br><input type="text" name="email" class="box">���� Ȯ�μ��� ���۵� �̸��� �ּ� �Է�</td>
							</tr>
							<tr>
								<td>�̸��� �ּ� Ȯ��<br><input type="text" name="email_check" class="box"></td>
							</tr>
							<tr>
								<td>
									����/����<br>
									<select name="country">
										<option value="default">-- --����/���� ����-- --</option>
									<c:forEach var="country" items="${countryList}">
										<option>${country.name}</option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td>��ȭ��ȣ (������ ��� �޴���)<br><input type="text" name="tel" class="box"></td>
							</tr>
							<tr>
								<td>
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
											<td colspan="2">������ ����<br><input type="text" name="guest_name" class="box"></td>
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