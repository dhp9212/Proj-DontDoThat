<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/style.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>홈 입력</title>
</head>
<script src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('.go').on('click', function(){
			for(var i=1; i<13; ++i){
				$('#'+i+'table').hide()
			}
			for(var i=0; i<9; ++i){
				if($(this).val()==$('.go').eq(i).val()) $('#'+(i+3)+'table').show()
			}
		})
	})
	function clickEvent2(a) {
		if (a.value == '계속하기') {
			$('#2table').hide()
			$('#3table').show()
		} else {
			location.href = 'insertRoom.do'
		}
	}
	function clickEvent3() {
		$('#3table').hide()
		$('#4table').show()
	}
	function clickEvent4() {
		$('#4table').hide()
		$('#5table').show()
	}
	function clickEvent5() {
		$('#5table').hide()
		$('#6table').show()
	}
	function clickEvent6() {
		var check = document.getElementsByName('facilities')
		var str = ''
		for (var i = 0; i < check.length; i++) {
			if (check[i].checked == true)
				str += check[i].value + ','
		}
		document.f.facility.value = str
		$('#6table').hide()
		$('#7table').show()
	}
	function clickEvent7() {
		$('#7table').hide()
		$('#8table').show()
	}
	function clickEvent8() {
		$('#8table').hide()
		$('#9table').show()
	}
	function clickEvent9() {
		$('#9table').hide()
		$('#10table').show()
	}
	function clickEvent10() {
		var check = document.getElementsByName('policies')
		var str = ''
		for (var i = 0; i < check.length; i++) {
			if (check[i].checked == true)
				str += check[i].value + ','
		}
		document.f.policy.value = str
		$('#10table').hide()
		$('#11table').show()
	}
	function clickEvent11() {
		$('#11table').hide()
		$('#12table').show()
	}
	function clause() {
		window.open("https://admin.booking.com/hotelreg/terms-and-conditions.html?language=ko;cc1=kr", "width=800; height=700;")
	}
	function check_clause() {
		var check = document.getElementsByName('clause')
		var str = ''
		for (var i = 0; i < check.length; i++) {
			if (check[i].checked == false) {
				alert('약정에 동의하셔야 등록이 가능합니다.')
				return false
			}
		}
		return true
	}
</script>
<body>
<table>
	<tr>
		<td width="550">
		<form name="f" action="insertRoomPro.do" method="post" enctype="multipart/form-data" onsubmit="return check_clause()">
			<input type="hidden" name="category_accomodation" value="${param.category}">
			<input type="hidden" name="facility">
			<input type="hidden" name="policy">
			<div id="2table" style="display: black;">
				<table>
					<tr>
						<td align="center" style="margin: 0px; padding: 10px; float: left;">등록중인 숙박옵션<br>
							<h2>${param.category}</h2>
							<p/>
							<input style="margin: 7px; width: 150;" type="button" value="계속하기" onclick="javascript:clickEvent2(this)"><br>
							<input style="margin: 7px; width: 150;" type="button" value="수정하기" onclick="javascript:clickEvent2(this)">
						</td>
					</tr>
				</table>
			</div>
			<div id="3table" style="display: none;">
				<h3>아래에 숙소가 등록된 웹사이트를 입력해 주세요.</h3>
				<table>
					<tr>
						<td><input type="text" name="homepage">
							<p /> <input type="button" value="계속"
							onclick="javascript:clickEvent3()" style="width: 400;" /></td>
					</tr>
				</table>
			</div>
			<div id="4table" style="display: none;">
				<h3>등록하실 숙소는 어디에 있나요?</h3>
				<table>
					<tr>
						<td>국가/지역<br> <select name="country">
								<c:forEach var="str" items="${country}">
									<c:if test="${str.name == '대한민국'}">
										<option selected>${str.name}</option>
									</c:if>
									<c:if test="${str.name != '대한민국'}">
										<option>${str.name}</option>
									</c:if>
								</c:forEach>
						</select><br> 도시명<br> <input name="city" type="text"><br>
							도로명주소<br> <input name="roadname" type="text"><br>
							상세주소<br> <input name="detail" type="text"><br>
							우편번호<br> <input name="postalcode" type="text">
							<p /> <input type="button" value="계속"
							onclick="javascript:clickEvent4()" style="width: 400;" />
						</td>
					</tr>
				</table>
			</div>
			<div id="5table" style="display: none;">
				<h3>수용 가능한 인원은 몇 명인가요?</h3>
				<table>
					<tr>
						<td>수용 가능한 인원은 몇 명인가요?<br> <input name="people"
							type="text" value="1"><br>
							<p /> <input type="button" value="계속"
							onclick="javascript:clickEvent5()" style="width: 400;" />
						<td>
					</tr>
				</table>
			</div>
			<div id="6table" style="display: none;">
				<h3>투숙객이 숙소에서 이용할 수 있는 것은 무엇인가요?</h3>
				<table>
					<tr>
						<td><input name="facilities" type="checkbox" value="난방 시설" />난방<br>
						<input name="facilities" type="checkbox" value="무료 Wi-Fi" />무료 Wi-Fi<br>
						<input name="facilities" type="checkbox" value="에어컨" />에어컨<br>
						<input name="facilities" type="checkbox" value="구내 주차" />구내 주차<br>
						<input name="facilities" type="checkbox" value="수영장" />수영장
						<p/>
						<input type="button" value="계속" onclick="javascript:clickEvent6()" style="width: 400;" /></td>
					</tr>
				</table>
			</div>
			<div id="7table" style="display: none">
				<h3>숙소 모습을 보여주세요.</h3>
				<table>
					<tr>
						<td><input name="image" type="file" />
							<p /> <input type="button" value="계속"
							onclick="javascript:clickEvent7()" style="width: 400;" /></td>
					</tr>
				</table>
			</div>
			<div id="8table" style="display: none;">
				<h3>숙소 이름을 알려주세요.</h3>
				<table>
					<tr>
						<td><input name="accomodation_name" type="text" /><br>
							<p /> <input type="button" value="계속"
							onclick="javascript:clickEvent8()" style="width: 400;" /></td>
					</tr>
				</table>
			</div>
			<div id="9table" style="display: none;">
				<h3>1박당 수익 목표는 얼마인가요?</h3>
				<table>
					<tr>
						<td>1박당 수익<br> <input name="price" type="text" />원<br>
							<p /> <input type="button" value="계속"
							onclick="javascript:clickEvent9()" style="width: 400;" />
						</td>
					</tr>
				</table>
			</div>
			<div id="10table" style="display: none;">
				<h3>숙소 정책</h3>
				<table>
					<tr>
						<td><input name="policies" type="checkbox" value="흡연 가능" />흡연
							가능<br> <input name="policies" type="checkbox"
							value="반려동물 동반 가능" />반려동물 동반 가능<br> <input name="policies"
							type="checkbox" value="아동 동반 가능" />아동 동반 가능<br> <input
							name="policies" type="checkbox" value="파티/행사를 허용합니다" />파티/행사를
							허용합니다<br>
							<p /> <input type="button" value="계속"
							onclick="javascript:clickEvent10()" style="width: 400;" /></td>
					</tr>
				</table>
			</div>
			<div id="11table" style="display: none;">
				<h3>유의사항</h3>
				<table>
					<tr>
						<td>성공적인 숙소 운영을 위해 반드시 숙지하셔야 할 정보를 엄선하여 안내해드립니다.</td>
					</tr>
					<tr>
						<td>예약 즉시 확정<br> 캘린더에서 특정 날짜에 예약이 가능하도록 설정하시면
							Booking.com에 숙소가 표시되며, 접수된 모든 예약은 즉시 확정됩니다.
						</td>
					</tr>
					<tr>
						<td>예약 자동 승인<br> 접수된 예약은 자동 승인됩니다. 따라서 별도로 예약을 승인하거나 거부해야
							할 번거로움이 없어 업무를 최소화하고 예약률을 극대화하실 수 있습니다.
						</td>
					</tr>
					<tr>
						<td>최신 상태로 캘린더 관리<br> 캘린더를 최신으로 유지하면 모든 예약을 정상적으로 진행하실 수
							있습니다. 또한 같은 날짜에 여러 건의 예약이 접수되는 오버부킹이 발생할 여지가 없습니다.
						</td>
					</tr>
					<tr>
						<td><input type="button" value="계속"
							onclick="javascript:clickEvent11()" style="width: 400;" /></td>
					</tr>
				</table>
			</div>
			<div id="12table" style="display: none;">
				<h3>거의 완료되었습니다!</h3>
				<br>
				<h4>숙소 등록 절차가 거의 완료되었습니다. 그전에 몇 가지 주의 사항을 안내해드립니다.</h4>
				<h2>예약 접수 개시</h2>
				<h4>
					온라인으로 예약을 접수할 준비가 된 경우 다음 페이지로 이동하여<br> 캘린더에서 숙소를 판매할 날짜를 선택하실
					수 있습니다.<br> 숙소 등록이 완료되면 고객이 해당 날짜에 예약을 진행할 수 있게 됩니다.<br>
					아직 예약을 접수할 준비가 되지 않은 경우, 우선 숙소 등록을 완료한 뒤<br> 나중에 캘린더에서 예약이 가능한
					날짜를 선택하실 수 있습니다.<br> 이후 준비가 되는 대로 예약 접수를 시작하시면 됩니다.
				</h4>
				<input name="clause" type="checkbox" /> 본 숙박업체는 합법적으로 이 숙소를 운영하기 위해
				필요한 모든 인허가를 취득하였으며,<br> 요청 시 증빙서류를 제시할 수 있음을 보증합니다.<br>
				Booking.com B.V.는 숙소 등록 과정에서 숙소와 관련된 모든 정보에 대한<br> 검증과 조사 절차를 취할
				권리를 갖고 있습니다.<br> <input name="clause" type="checkbox" /><a
					href="javascript:clause()">일반 계약</a> 조건을 읽었으며, 이에 동의하고 수락합니다.
				<p />
				<input type="submit" value="입력완료" style="width: 400;" />
			</div>
		</form>
		</td>
		<td valign="top">
			<input style="width:120;" class="go" type="button" value="웹페이지 입력"><p/>
			<input style="width:120;" class="go" type="button" value="숙소 위치 입력"><p/>
			<input style="width:120;" class="go" type="button" value="수용가능 인원 입력"><p/>
			<input style="width:120;" class="go" type="button" value="숙소 시설들 입력"><p/>
			<input style="width:120;" class="go" type="button" value="숙소 이미지 입력"><p/>
			<input style="width:120;" class="go" type="button" value="숙소 이름 입력"><p/>
			<input style="width:120;" class="go" type="button" value="숙소 가격 입력"><p/>
			<input style="width:120;" class="go" type="button" value="숙소 정책 입력">
		</td>
	</tr>
</table>
</body>
</html>