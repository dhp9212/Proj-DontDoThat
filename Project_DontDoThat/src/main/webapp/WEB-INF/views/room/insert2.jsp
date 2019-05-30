<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/style.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>호텔류 입력</title>
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
	
	function view_facility(){
		$('#room_facility').toggle()
	}
	function addForm(){
		document.getElementById('room').style.display = 'none'
		document.getElementById('addForm').style.display = 'block'
		$('#room > tbody:last > tr:last').remove()
	}
	function addOption(select){
		$('#sin').attr('style', 'display:none')
		$('#dou').attr('style', 'display:none')
		$('#dor').attr('style', 'display:none')
		if(select=='sin') $('#sin').attr('style', 'display:block')
		else if(select=='dou') $('#dou').attr('style', 'display:block')
		else $('#dor').attr('style', 'display:block')
	}
	function addInit(){
		var option =  $('#roomC option:selected').val()
		var selectOpt = ''
		if(option=='sin') selectOpt = $('#sin option:selected').val()
		else if(option=='dou') selectOpt = $('#dou option:selected').val()
		else selectOpt = $('#dor option:selected').val()
		var init = $('input[name=roominit]').val()
		if(init!='') init += ','
		init += $('input[name=roomname]').val() + ','
		init += selectOpt + ','
		init += $('input[name=qty]').val() + ','
		init += $('input[name=people]').val() + ','
		init += $('input[name=price]').val() + ','
		init += addFacility(init)
		$('input[name=roominit]').attr('value', init)
		$('#addForm').hide()
		addRoom(selectOpt)
		$('#room').show()
		resetCheckbox()
	}
	function addFacility(){
		var str = ''
		var facility = $('input[name=facilities]')
		for(var i=0; i<facility.length; ++i){
			if(facility[i].checked) str += facility[i].value + '|'
		}
		return str
	}
	function resetCheckbox(){
		$('input[name=facilities]').attr('checked', false)
	}
	function addRoom(selectOpt){
		$('#room > tbody:last').append('<tr><td>' + selectOpt + '</td><td> 이 유형의 갯수 : ' + $('input[name=qty]').val() + '</td></tr>')
		$('#room > tbody:last').append("<tr><td colspan='2' align='right'><input type='button' value='다른 객실 추가하기' onclick='javascript:addForm()'></td><td><input type='button' value='계속하기' onclick='javascript:clickEvent5()'</td></tr>");
	}
	function viewFac(select){
		for(var i=0; i<9; ++i){
			if(i==select) continue;
			$('#'+i).attr('style', 'display:none;')
		}
		
		if($('#'+select).attr('style')=='DISPLAY: block') $('#'+select).attr('style', 'display:none;')
		else $('#'+select).attr('style', 'display:block;')
	}
	function checkInS(select){
		$(select).prevAll().attr('style', 'color:black;')
		$(select).nextAll().attr('style', 'color:black;')
		select.style.color = 'red'
		$('input[name=check_in_stime]').attr('value', select.value)
	}
	function checkInE(select){
		$(select).prevAll().attr('style', 'color:black;')
		$(select).nextAll().attr('style', 'color:black;')
		select.style.color = 'red'
		$('input[name=check_in_etime]').attr('value', select.value)
	}
	function checkOutS(select){
		$(select).prevAll().attr('style', 'color:black;')
		$(select).nextAll().attr('style', 'color:black;')
		select.style.color = 'red'
		$('input[name=check_out_stime]').attr('value', select.value)
	}
	function checkOutE(select){
		$(select).prevAll().attr('style', 'color:black;')
		$(select).nextAll().attr('style', 'color:black;')
		select.style.color = 'red'
		$('input[name=check_out_etime]').attr('value', select.value)
	}
	function clickEvent2(a){
		if(a.value=='계속하기'){
			document.getElementById('2table').style.display = 'none'
			document.getElementById('3table').style.display = 'block'
		}else{
			location.href = 'insertRoom.do'
		}
	}
	function clickEvent3(){
		document.getElementById('3table').style.display = 'none'
		document.getElementById('4table').style.display = 'block'
	}
	function clickEvent4(){
		document.getElementById('4table').style.display = 'none'
		document.getElementById('5table').style.display = 'block'
	}
	function clickEvent5(){
		document.getElementById('5table').style.display = 'none'
		document.getElementById('6table').style.display = 'block'
	}
	function clickEvent6(){
		var accomodation_facility = ''
		accomodation_facility += '인터넷,' + $('select[name=internet]').val() + ',' + $('input[name=internet_pay]').val() + ','
		accomodation_facility += '주차,' + $('select[name=parking]').val() + ',' + $('input[name=parking_pay]').val() + ','
		accomodation_facility += '조식,' + $('select[name=breakfast]').val() + ',' + $('input[name=breakfast_pay]').val() + ','
		accomodation_facility += '언어,' + $('select[name=language]').val()
		$('input[name=accomodation_facility]').attr('value', accomodation_facility)
		document.getElementById('6table').style.display = 'none'
		document.getElementById('7table').style.display = 'block'
	}
	function clickEvent7(){
		document.getElementById('7table').style.display = 'none'
		document.getElementById('8table').style.display = 'block'
	}
	function clickEvent8(){
		var policy = ''
		policy += 'cancel,' + $('select[name=cancel_time] option:selected').val() + ',' + $('select[name=cancel_pay] option:selected').val() + ','
		policy += 'children,' + $('select[name=children] option:selected').val() + ',' + $('input[name=children_pay]').val() + ','
		policy += 'pet,' + $('select[name=pet] option:selected').val() + ',' + $('input[name=pet_pay]').val()
		$('input[name=policy]').attr('value', policy)
		
		$('input[name=checkin_date]').attr('value', $('input[name=check_in_stime]').val() + ' ~ ' + $('input[name=check_in_etime]').val())
		$('input[name=checkout_date]').attr('value', $('input[name=check_out_stime]').val() + ' ~ ' + $('input[name=check_out_etime]').val())
		document.getElementById('8table').style.display = 'none'
		document.getElementById('9table').style.display = 'block'
	}
	function viewPay(select){
			var id = ''
			if(select.name=='children') id = 'children_pay'
			else if(select.name=='pet') id = 'pet_pay'
			else if(select.name=='internet') id='internet_pay'
			else if(select.name=='parking') id='parking_pay'
			else if(select.name=='breakfast') id='breakfast_pay'
			
		if(select.value=='pay') $('#'+id).show()
		else $('#'+id).hide()
	}
	function addCard(select){
		if(select.value=='yes') $('#card').attr('style', 'display:block;')
		else $('#card').attr('style', 'display:none;')
	}
	function check_clause(){
		inputPayment()
		var check = document.getElementsByName('clause[]')
		var str = ''
		for(var i=0;i<check.length;i++){
			if(check[i].checked==false){
				alert('약정에 동의하셔야 등록이 가능합니다.')
				return false
			}
		}
		return true
	}
	function inputPayment(){
		var str = 'card,'
		var card = $('input[name=card]')
		for(var i=0; i<card.length; ++i){
			if(card[i].checked==true) str += card[i].value + '-'
		}
		str += ',' + 'VAT,' + $("input:radio[name='vat']:checked").val()
		$('input[name=payment]').attr('value', str)
	}
</script>
<body>
<table>
	<tr>
		<td width="550">
		<form name="f" action="insertRoomPro2.do" method="post" enctype="multipart/form-data" onsubmit="return check_clause()">
			<input type="hidden" name="account_num" value="${userSession.num}">
			<input type="hidden" name="category_accomodation" value="${param.category}">
			<input type="hidden" name="roominit">
			<input type="hidden" name="accomodation_facility">
			<input type="hidden" name="policy">
			<input type="hidden" name="checkin_date">
			<input type="hidden" name="checkout_date">
			<input type="hidden" name="check_in_stime">
			<input type="hidden" name="check_in_etime">
			<input type="hidden" name="check_out_stime">
			<input type="hidden" name="check_out_etime">
			<input type="hidden" name="payment">
			<div id="2table" style="display:black;">
				<table>
					<tr>
						<td width="250" align="center" style="margin:0px; padding:10px; float:left;">
							등록중인 숙박옵션<br>
							<h2>${param.category}</h2>
							<p/>
							<input style="margin:7px; width:200;" type="button" value="계속하기" onclick="javascript:clickEvent2(this)">
							<input style="margin:7px; width:200;" type="button" value="수정하기" onclick="javascript:clickEvent2(this)">
						</td>
					</tr>
				</table>
			</div>
			<div id="3table" style="display:none;">
				<h3>아래에 숙소가 등록된 웹사이트를 입력해 주세요.</h3>
				<table>
					<tr>
						<td>
							<input type="text" name="homepage">
							<p/>
							<input type="button" value="계속" onclick="javascript:clickEvent3()" style="width:400;"/>
						</td>
					</tr>
				</table>
			</div>
			<div id="4table" style="display:none;">
				<h2>숙소에 대해 더 알려주세요!</h2>
				<h3>먼저 숙소 이름, 주소, 연락처를 알려주세요.</h3>
				<table>
					<tr>
						<td width="300">
							숙소의 이름은 무엇인가요?<br>
							<input type="text" name="accomodation_name"><br>
							숙소 검색 시 고객들이 보게 되는 이름입니다.
						</td>
					</tr>
					<tr>
						<td class="m2">숙소 연락처를 알려주세요.<br></td>
					</tr>
					<tr>
						<td class="m3">
							담당자 성명<br>
							<input type="text" name="headname"><br>
							<br>
							연락처<br>
							<input type="text" name="tel"><br>
							<br>
						</td>
					</tr>
					<tr>
						<td>
							국가/지역<br>
							<select name="country">
							<c:forEach var="str" items="${country}">
							<c:if test="${str.name=='대한민국'}">
								<option selected>${str.name}</option>
							</c:if>
							<c:if test="${str.name!='대한민국'}">
								<option>${str.name}</option>
							</c:if>
							</c:forEach>
							</select><br>
							도시명<br>
							<input name="city" type="text"><br>
							도로명주소<br>
							<input name="roadname" type="text"><br>
							상세주소<br>
							<input name="detail" type="text"><br>
							 우편번호<br>
							<input name="postalcode" type="text">
							<p/>
							<input type="button" value="계속" onclick="javascript:clickEvent4()" style="width:350;"/>
						</td>
					</tr>
				</table>
			</div>
			<div id="5table" style="display:none;">
				<h2>구성 및 요금</h2>
				<h3>우선 첫 번째  객실에 대해 알려주세요.<br>필요한 정보를 모두 입력한 뒤 다음 객실을 진행 할 수 있습니다.</h3>
				<table id="room">
					<tr>
						<td>숙소에 추가된 객실이 없습니다. 우선 객실을 추가해 주세요.</td>
					</tr>
					<tr>
						<td><input type="button" value="객실 추가하기" onclick="javascript:addForm()" style="width:350;"/></td>
					</tr>
				</table>
				<table id="addForm" style="display:none;">
					<tr>
						<td>확인중</td>
					</tr>
					<tr>
						<td>
							객실유형<br>
							<select id="roomC" onchange="javascript:addOption(this.options[this.selectedIndex].value)">
								<option value="sin">싱글룸</option>
								<option value="dou">더블룸</option>
								<option value="dor">도미토리룸</option>
							</select>
							<p/>
							객실종류<br>
							<select id="sin" style="display:block;">
								<c:forEach var="str" items="${sin}">
								<option>${str}</option>
								</c:forEach>
							</select>
							<select id="dou" style="display:none;">
								<c:forEach var="str" items="${dou}">
								<option>${str}</option>
								</c:forEach>
							</select>
							<select id="dor" style="display:none;">
								<c:forEach var="str" items="${dor}">
								<option>${str}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							객실별칭<br>
							<input type="text" name="roomname">
						</td>
					</tr>
					<tr>
						<td>
							이 유형에 해당하는 룸 갯수 : <input type="text" name="qty" size="2">
						</td>
					</tr>
					<tr>
						<td>
							수용가능 인원 : <input type="text" name="people" size="2">
						</td>
					</tr>
					<tr>
						<td class="m2">
							1박 최저가
						</td>
					</tr>
					<tr>
						<td class="m3">
							해당 객실의 모든 날짜에 자동으로 적용할 최저 요금 입니다.<br>
							귀사의  숙소페이지가 실제로 게재되기 전에<br>
							관리자 페이지에서 계절별 요금을 설정할 수 있습니다.
						</td>
					</tr>
					<tr>
						<td class="m3">
							1인 숙박요금<br>
							KRW/1박 : <input type="text" name="price">
						</td>
					</tr>
					<tr>
						<td><input type="button" value="편의시설 보기" onclick="javascript:view_facility()"></td>
					</tr>
					<tr>
						<td>
							<div id="room_facility" style="display:none;">
								<table>
								</table>
								<c:forEach var="list" items="${facilities}" varStatus="num">
								<table>
									<tr>
										<td class="m1" onclick="viewFac(${num.count})">${list.key}<br></td>
									</tr>
								</table>
								<table id="${num.count}" style="display:none;">
									<c:forEach var="item" items="${list.value}">
									<tr>
										<td class="m3"><input type="checkbox" name="facilities" value="${item}">${item}</td>
									</tr>
									</c:forEach>
								</table>
								</c:forEach>
							</div>
						</td>
					</tr>
					<tr>
						<td><input type="button" value="계속" onclick="javascript:addInit()" style="width:350;"/></td>
					</tr>
				</table>
			</div>
			<div id="6table" style="display:none;">
				<h2>시설 및 서비스</h2>
				<h4>이제 숙소 전반에 관한 정보를 입력해 주세요.<br>(예시 : 이용가능한 시설, 인터넷, 주차, 언어)</h4>
				<table>
					<tr>
						<td width="300" class="m2">인터넷</td>
					</tr>
					<tr>
						<td width="300" class="m4">많은 여행객들이 인터넷 사용을 중요시 합니다. 무료 WiFi 또한 굉장한 매력포인트가 될 수 있습니다.</td>
					</tr>
					<tr>
						<td width="300" class="m3">인터넷 사용이 가능한가요?</td>
					</tr>
					<tr>
						<td width="300" class="m3">
							<select name="internet" onchange="javascript:viewPay(this)">
								<option value="no">아니요</option>
								<option value="pay">예(유료옵션)</option>
								<option value="free">예(무료옵션)</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<table id="internet_pay" style="display:none;">
								<tr>
									<td>추가 가격 : <input type="text" name="internet_pay"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<table>
					<tr>
						<td width="300" class="m2">주차</td>
					</tr>
					<tr>
						<td width="300" class="m4">차를 이용하는 투숙객에게 매우 중요한 정보입니다.</td>
					</tr>
					<tr>
						<td width="300" class="m3">주차가 가능한가요?</td>
					</tr>
					<tr>
						<td width="300" class="m3">
							<select name="parking" onchange="javascript:viewPay(this)">
								<option value="no">아니요</option>
								<option value="pay">예(유료옵션)</option>
								<option value="free">예(무료옵션)</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<table id="parking_pay" style="display:none;">
								<tr>
									<td>추가 가격 : <input type="text" name="parking_pay"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<table>
					<tr>
						<td width="300" class="m2">조식</td>
					</tr>
					<tr>
						<td width="300" class="m3">조식을 제공하시나요?</td>
					</tr>
					<tr>
						<td width="300" class="m3">
							<select name="breakfast" onchange="javascript:viewPay(this)">
								<option value="no">아니요</option>
								<option value="pay" onselect="">예(유료옵션)</option>
								<option value="free">예(무료옵션)</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<table id="breakfast_pay" style="display:none;">
								<tr>
									<td>추가 가격 : <input type="text" name="breakfast_pay"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<table>
					<tr>
						<td width="300" class="m2">언어</td>
					</tr>
					<tr>
						<td width="300" class="m4">귀하 또는 직원이 구사하는 언어는 무엇인가요?</td>
					</tr>
					<tr>
						<td width="300" class="m3">
							<select name="language" onchange="javascript:addOption(this.options[this.selectedIndex].value)">
								<option value="kor">한국어</option>
								<option value="eng">영어</option>
								<option value="chn">중국어</option>
								<option value="jpn">일본어</option>
							</select>
						</td>
					</tr>
				</table>
				<table>
					<tr>
						<td><input type="button" value="계속" onclick="javascript:clickEvent6()" style="width:350;"/></td>
					</tr>
				</table>
			</div>
			<div id="7table" style="display:none">
				<h2>숙박시설 사진</h2>
				<h4>좋은 사진은 고객이 숙소에 호기심을 가지게 됩니다.</h4>
				<table>
					<tr>
						<td>
							<input name="image" type="file"/>
							<p/>
							<input type="button" value="계속" onclick="javascript:clickEvent7()" style="width:400;"/>
						</td>
					</tr>
				</table>
			</div>
			<div id="8table" style="display:none;">
				정책<br>
				속소의 기본 정책을 설정해주세요. 아동 및 반려동물이 함께 숙박할 수 있나요?취소 정책은 얼마나 유연하게 운영하시나요?
				<table border="1" style="rules:none;">
					<tr>
						<td>취소<br>체크인 며칠전까지 무료 취소 기능으로 설정하시겠습니까?</td>
					</tr>
					<tr>
						<td>
							<select name="cancel_time">
								<option value="0" selected>도착일(18:00)</option>
								<option value="1">1일</option>
								<option value="2">2일</option>
								<option value="3">3일</option>
								<option value="7">7일</option>
								<option value="14">14일</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>그렇지 않으면 투숙객이</td>
					</tr>
					<tr>
						<td><select name="cancel_pay">
							<option value="all">숙박료 전액을 지불합니다.</option>
							<option value="one" selected>첫 1박 요금을 지불합니다.</option>
						</select></td>
					</tr>
					<tr>
						<td>
							<table border="1">
								<tr><td>예약 취소의 경우, 체크인 당일 18:00까지 취소되지 않을 시 전체 숙박료를 100% 부과합니다.<br>
								주의:정책은 차후 수정이 가능합니다.설정을 시작해보세요.
								</td></tr>
							</table>
						</td>
					</tr>
				</table>
				<table>
					<tr><td>실수로 진행된 예약 처리 간소화</td></tr>
					<tr><td>실수로 진행된 예약에 대한 후속 조치에 소모되는 시간을 최소화 하기 위해 예약이 이뤄진 시점으로부터
					24시간 내에 취소 시 위약금이 자동 면제되도록 설정하였습니다.취소 위약금 면제 시점은 숙소 관리 플랫폼에서 변경하실 수 있습니다.</td></tr>
				</table>
				<table>
					<tr>
						<td class="m2">체크인</td>
						<td class="m2">체크아웃</td>
					</tr>
					<tr>
						<td>
							시작<br>
							<input type="button" value="12:00" onclick="javascript:checkInS(this)">
							<input type="button" value="14:00" onclick="javascript:checkInS(this)">
							<input type="button" value="15:00" onclick="javascript:checkInS(this)">
							<select name="check_in_stime" onchange="javascript:checkInS(this)">
								<option>기타</option>
								<option value="00:00">00:00</option>
								<option value="00:00">01:00</option>
								<option value="00:00">02:00</option>
								<option value="00:00">03:00</option>
								<option value="00:00">04:00</option>
								<option value="00:00">05:00</option>
								<option value="00:00">06:00</option>
								<option value="00:00">07:00</option>
								<option value="00:00">08:00</option>
								<option value="00:00">09:00</option>
								<option value="00:00">10:00</option>
								<option value="00:00">11:00</option>
								<option value="00:00">12:00</option>
								<option value="00:00">13:00</option>
								<option value="00:00">14:00</option>
								<option value="00:00">15:00</option>
								<option value="00:00">16:00</option>
								<option value="00:00">17:00</option>
								<option value="00:00">18:00</option>
								<option value="00:00">19:00</option>
								<option value="00:00">20:00</option>
								<option value="00:00">21:00</option>
								<option value="00:00">22:00</option>
								<option value="00:00">23:00</option>
							</select>
							<p/>
							마감<br>
							<input type="button" value="12:00" onclick="javascript:checkInE(this)">
							<input type="button" value="22:00" onclick="javascript:checkInE(this)">
							<input type="button" value="00:00" onclick="javascript:checkInE(this)">
							<select name="check_in_etime" onchange="javascript:checkInE(this)">
								<option>기타</option>
								<option value="00:00">00:00</option>
								<option value="00:00">01:00</option>
								<option value="00:00">02:00</option>
								<option value="00:00">03:00</option>
								<option value="00:00">04:00</option>
								<option value="00:00">05:00</option>
								<option value="00:00">06:00</option>
								<option value="00:00">07:00</option>
								<option value="00:00">08:00</option>
								<option value="00:00">09:00</option>
								<option value="00:00">10:00</option>
								<option value="00:00">11:00</option>
								<option value="00:00">12:00</option>
								<option value="00:00">13:00</option>
								<option value="00:00">14:00</option>
								<option value="00:00">15:00</option>
								<option value="00:00">16:00</option>
								<option value="00:00">17:00</option>
								<option value="00:00">18:00</option>
								<option value="00:00">19:00</option>
								<option value="00:00">20:00</option>
								<option value="00:00">21:00</option>
								<option value="00:00">22:00</option>
								<option value="00:00">23:00</option>
							</select>
						</td>
						<td>
							시작<br>
							<input type="button" value="00:00" onclick="javascript:checkOutS(this)">
							<input type="button" value="10:00" onclick="javascript:checkOutS(this)">
							<input type="button" value="12:00" onclick="javascript:checkOutS(this)">
							<select name="checkInStime" onchange="javascript:checkOutS(this)">
								<option>기타</option>
								<option value="00:00">00:00</option>
								<option value="00:00">01:00</option>
								<option value="00:00">02:00</option>
								<option value="00:00">03:00</option>
								<option value="00:00">04:00</option>
								<option value="00:00">05:00</option>
								<option value="00:00">06:00</option>
								<option value="00:00">07:00</option>
								<option value="00:00">08:00</option>
								<option value="00:00">09:00</option>
								<option value="00:00">10:00</option>
								<option value="00:00">11:00</option>
								<option value="00:00">12:00</option>
								<option value="00:00">13:00</option>
								<option value="00:00">14:00</option>
								<option value="00:00">15:00</option>
								<option value="00:00">16:00</option>
								<option value="00:00">17:00</option>
								<option value="00:00">18:00</option>
								<option value="00:00">19:00</option>
								<option value="00:00">20:00</option>
								<option value="00:00">21:00</option>
								<option value="00:00">22:00</option>
								<option value="00:00">23:00</option>
							</select>
							<p/>
							마감<br>
							<input type="button" value="10:00" onclick="javascript:checkOutE(this)">
							<input type="button" value="11:00" onclick="javascript:checkOutE(this)">
							<input type="button" value="12:00" onclick="javascript:checkOutE(this)">
							<select name="check_in_etime" onchange="javascript:checkOutE(this)">
								<option>기타</option>
								<option value="00:00">00:00</option>
								<option value="00:00">01:00</option>
								<option value="00:00">02:00</option>
								<option value="00:00">03:00</option>
								<option value="00:00">04:00</option>
								<option value="00:00">05:00</option>
								<option value="00:00">06:00</option>
								<option value="00:00">07:00</option>
								<option value="00:00">08:00</option>
								<option value="00:00">09:00</option>
								<option value="00:00">10:00</option>
								<option value="00:00">11:00</option>
								<option value="00:00">12:00</option>
								<option value="00:00">13:00</option>
								<option value="00:00">14:00</option>
								<option value="00:00">15:00</option>
								<option value="00:00">16:00</option>
								<option value="00:00">17:00</option>
								<option value="00:00">18:00</option>
								<option value="00:00">19:00</option>
								<option value="00:00">20:00</option>
								<option value="00:00">21:00</option>
								<option value="00:00">22:00</option>
								<option value="00:00">23:00</option>
							</select>
						</td>
					</tr>
				</table>
				<table>
					<tr>
						<td class="m2">어린이</td>
					</tr>
					<tr>
						<td class="m3">어린이를 동반 할 수 있습니까?</td>
					</tr>
					<tr>
						<td>
							<select name="children" onchange="javascript:viewPay(this)">
								<option value="no" selected>아니오</option>
								<option value="pay">예(유료)</option>
								<option value="free">예(무료)</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<table id="children_pay" style="display:none;">
								<tr>
									<td>추가 가격 : <input type="text" name="children_pay"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<table>
					<tr>
						<td class="m2">반려동물</td>
					</tr>
					<tr>
						<td class="m4">요즘 반려동물과 함께 여행하는 분들이 늘고 있습니다. 반려동물 허용 및 추가요금 여부를 명시해 주시기 바랍니다.</td>
					</tr>
					<tr>
						<td class="m3">반려동물을 허락하시나요?</td>
					</tr>
					<tr>
						<td>
							<select name="pet" onchange="javascript:viewPay(this)">
								<option value="no" selected>아니오</option>
								<option value="pay">예(유료)</option>
								<option value="free">예(무료)</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<table id="pet_pay" style="display:none;">
								<tr>
									<td>추가 가격 : <input type="text" name="pet_pay"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<table>
					<tr>
						<td><input type="button" value="계속" onclick="javascript:clickEvent8()" style="width:400;"/></td>
					</tr>
				</table>
			</div>
			<div id="9table" style="display:none;">
				<table>
					<tr>
						<td class="m2">결제</td>
					</tr>
					<tr>
						<td class="m3">귀사에서 사용하는 결제방식, 세금 정보, 추가 비용 등의 옵션을 설정하세요.</td>
					</tr>
				</table>
				<table>
					<tr>
						<td class="m2">투숙객 결제 옵션</td>
					</tr>
					<tr>
						<td class="m3">숙소에서 신용카드 결제가 가능합니까?</td>
					</tr>
					<tr>
						<td><input type="radio" name="card" onclick="javascript:addCard(this)" value="yes">예&emsp;<input type="radio" name="card" onclick="javascript:addCard(this)" value="no">아니오</td>
					</tr>
					<tr>
						<td>
							<table id="card" style="display:none;">
								<c:forEach var="str" items="${card}">
								<tr>
									<td><input type="checkbox" name="card" value="${str}">${str}</td>
								</tr>
								</c:forEach>
							</table>
						</td>
					</tr>
				</table>
				<table>
					<tr>
						<td class="m2">세금</td>
					</tr>
					<tr>
						<td class="m3">VAT/세금 설정</td>
					</tr>
					<tr>
						<td class="m3">
							<input type="radio" name="vat" value="yes">기본값 설정(기본적으로 10%가 포함됨)
							<input type="radio" name="vat" value="no">부가가치세(VAT) 낼 필요 없음
						</td>
					</tr>
				</table>
				<table>
					<tr>
						<td class="m2">수수료 결제</td>
					</tr>
					<tr>
						<td class="m3">전월에 완료된 모든 예약에 대한 청구서를 매월 초에 전송해 드립니다.</td>
					</tr>
					<tr>
						<td class="m3">수수료는 계약요금의 15%이며 매달 마지막 날에 청구됩니다.</td>
					</tr>
					<tr>
						<td>
							<input name="clause[]" type="checkbox"/>
							본 숙박업체는 합법적으로 이 숙소를 운영하기 위해 필요한 모든 인허가를 취득하였으며,<br>
							요청 시 증빙서류를 제시할 수 있음을 보증합니다.<br>
							Booking.com B.V.는 숙소 등록 과정에서 숙소와 관련된 모든 정보에 대한<br>
							검증과 조사 절차를 취할 권리를 갖고 있습니다.<br>
							<input name="clause[]" type="checkbox"/><a href="javascript:clause()">일반 계약</a> 조건을 읽었으며, 이에 동의하고 수락합니다.
							<p/>
							<input type="submit" value="입력완료" style="width:400;"/>
						</td>
					</tr>
				</table>
			</div>
		</form>
		</td>
		<td valign="top">
			<input style="width:120;" class="go" type="button" value="웹페이지 입력"><p/>
			<input style="width:120;" class="go" type="button" value="숙소 위치 입력"><p/>
			<input style="width:120;" class="go" type="button" value="객실 추가하기"><p/>
			<input style="width:120;" class="go" type="button" value="숙소 시설들 입력"><p/>
			<input style="width:120;" class="go" type="button" value="숙소 이미지 입력"><p/>
			<input style="width:120;" class="go" type="button" value="숙소 정책 입력"><p/>
			<input style="width:120;" class="go" type="button" value="결제 정보 입력"><p/>
		</td>
	</tr>
</table>
</body>
</html>