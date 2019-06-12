<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp" %>
	<div>
		<form name="reservation" action="accomodation_reservation.do" method="post">
		<input type="hidden" name="account_num" value="${getAccount.num}" />
		<input type="hidden" name="accomodation_num" value="${accomodation_num}" />
		<input type="hidden" name="room_num" value="${getRoom.num}" />
		<input type="hidden" name="checkIn_date" value="${start_date}" />
		<input type="hidden" name="checkOut_date" value="${end_date}" />
		<table>
			<tr>
				<td>
					<div>
						<table border="1" width="100%">
							<tr>
								<td bgcolor="skyblue">내 예약 정보</td>
							</tr>
							<tr>
								<td>
									체크인 :<br>${start_date}<br>
									체크아웃 :<br>${end_date}<br>
									<a href="">날짜 변경</a>
								</td>
							</tr>
							<tr>
								<td>
									선택 객실 :<br>${getRoom.roomname}<br>
									<a href="">다른 객실로 변경</a>
								</td>
							</tr>
						</table>
						<table border="1" width="100%">
							<tr>
								<td colspan="2" bgcolor="skyblue">결제 요금 내역</td>
							</tr>
							<tr>
								<td>${getRoom.roomclass}</td>
								<td>${getRoom.price*selectQty}</td>
							</tr>
						</table>
					</div>
				</td>
				<td>
					<div>
						<table border="0" width="100%">
							<tr>
								<td><img src="image/${getAccomodationInfo.image}" width="200" height="200" border="0"></td>
								<td>
									<h3><b>${getAccomodationInfo.accomodation_name}</b></h3><br>
									${getAccomodationInfo.address}, ${getAccomodationInfo.city}, ${getAccomodationInfo.country}
								</td>
							</tr>
						</table>
						<h3>상세 정보 입력</h3>
						<table border="0" bgcolor="skyblue">
							<tr>
								<td>성(영문)<br><input type="text" name="last_name" class="box"></td>
								<td>이름(영문)<br><input type="text" name="first_name" class="box"></td>
							</tr>
							<tr>
								<td colspan="2">이메일 주소<br>
							<c:choose>
								<c:when test="${empty userSession}">
									<input type="text" name="email" class="box">예약 확인서가 전송될 이메일 주소 입력
								</c:when>
								<c:otherwise>
									<input type="text" name="email" class="box" value="${getAccount.email}">예약 확인서가 전송될 이메일 주소 입력
								</c:otherwise>
							</c:choose>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									국가/지역<br>
									<select name="country" id="country">
										<option value="default">-- --국가/지역 선택-- --</option>
									<c:forEach var="country" items="${countryList}">
										<option>${country.name}</option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2">전화번호 (가능한 경우 휴대폰)<br>
							<c:choose>
								<c:when test="${empty userSession}">
									<input type="text" name="tel" id="tel" class="box" maxlength="13">
								</c:when>
								<c:otherwise>
									<input type="text" name="tel" id="tel" class="box" maxlength="13" value="${getAccount.tel}">
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
											<td colspan="2">이용 후기</td>
										</tr>
										<tr>
											<td colspan="2">최대 투숙 인원 : ${getRoom.people}명</td>
										</tr>
										<tr>
											<td colspan="2">투숙객 성명<br>
												<input type="text" name="guest_name" class="box" placeholder="성(영문) 이름(영문)">
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<input type="button" value="예약 완료" onClick="javascript:check();">
					</div>
				</td>
			</tr>
		</table>
		</form>
	</div>
	<script type="text/javascript">
	function check() {
		var session = '${userSession}'
		if (session == '') {
			document.reservation.action = 'loginFromReservation.do'
			document.reservation.submit();
		}
		else {
			if (reservation.last_name.value == '') {
				alert("성(영문)을 입력해주세요")
				reservation.last_name.focus()
				return false
			}
			if (reservation.email.value == '') {
				alert("이메일 주소를 입력해주세요")
				reservation.email.focus()
				return false
			}
			if (reservation.country.value == 'default') {
				alert("국가/지역을 선택해주세요")
				reservation.country.focus()
				return false
			}
			if (reservation.tel.value == '') {
				alert("전화번호를 입력해주세요")
				reservation.tel.focus()
				return false
			}
			document.reservation.submit();
			alert("예약에 성공하였습니다")
			return true
		}
	}
	function autoHypenTel(str) {
        str = str.replace(/[^0-9]/g, '');
        var tmp = '';
        if (str.length < 4) {
            return str;
        } else if (str.length < 7) {
            tmp += str.substr(0, 3);
            tmp += '-';
            tmp += str.substr(3);
            return tmp;
        } else if (str.length < 11) {
            tmp += str.substr(0, 3);
            tmp += '-';
            tmp += str.substr(3, 3);
            tmp += '-';
            tmp += str.substr(6);
            return tmp;
        } else {              
            tmp += str.substr(0, 3);
            tmp += '-';
            tmp += str.substr(3, 4);
            tmp += '-';
            tmp += str.substr(7);
            return tmp;
        }
        return str;
    }
	var tel = document.getElementById('tel');
	tel.onkeyup = function(event) {
	    event = event || window.event;
	    var _val = this.value.trim();
	    this.value = autoHypenTel(_val);
	}
	var country = '${getAccount.country}'
	$(function() {
		if (country != '') {
			$('#country').val(country).prop('selected', true);
		}
	});
	</script>
</body>
</html>