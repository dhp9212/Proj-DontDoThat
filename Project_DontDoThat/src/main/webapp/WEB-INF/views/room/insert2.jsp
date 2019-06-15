<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<title>호텔류 입력</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/pattern.js"></script>
</head>
<style>
	div{
		margin: 5 0 5 0;
	}
	.box{
		padding: 0 0 0 20;
	}
	.facility{
		display: none;
		position: absolute;
		z-index:1002;
		overflow: auto;
	}
	.my_margin{
		margin: 50;
	}
	.form-control{
		background-color: #f1f1f1;
	}
	.myPopup{
		cursor:pointer;
	}
</style>
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
		$('.myPopup').on('click', function(){
			var obj = $('#' + $(this).attr('id') + 'span')
			var location = $(this).offset()
			obj.toggle()
			obj.css('left', 0)
			obj.css('top', 0)
			var facility = $('.facility')
			for(var i in facility){
				if(i==$(this).attr('id')) continue
				else $('#'+i+'span').hide()
			}
		})
	})
	function addHomepage(value){
		if(value=='yes') $('#homepage').show()
		else $('#homepage').hide()
	}
	function addForm(){
		$('#room').hide()
		$('#addForm').show()
		$('#room .row:last').remove()
	}
	function addOption(value){
		$('.roomCate').hide()
		$('#' + value).show()
	}
	function clearRoom(){
		$('#room .row:last').remove()
		$('#room .row:last').remove()
	}
	function addInit(){
		var list = new Array()
		list.push('roomname')
		list.push('qty')
		list.push('people')
		list.push('price')
		list.push('facility')
		var check = check_value(list)
		if(check==false) return
		
		var option =  $('#roomC option:selected').val()
		var selectOpt = $('#'+option+' option:selected').val()
		var init = $('input[name=roominit]').val()
		if(init!='') init += ','
		else clearRoom()
		init += $('input[name=roomname]').val() + ','
		init += selectOpt + ','
		init += $('input[name=qty]').val() + ','
		init += $('input[name=people]').val() + ','
		init += $('input[name=price]').val() + ','
		init += addFacility()
		$('input[name=roominit]').attr('value', init)
		$('#addForm').hide()
		addRoom(selectOpt)
	}
	function addFacility(){
		var str = ''
		var facility = $('input[name=facilities]')
		for(var i=0; i<facility.length; ++i){
			if(facility[i].checked) {
				if(str=='') str = facility[i].value
				else str += '|' + facility[i].value
			}
		}
		return str
	}
	function addRoom(selectOpt){
		$('#room .row:last').after('<div class="row"><div class="col-sm-6">' + selectOpt + '</div><div class="col-sm-3"> 가격 : ' + $('input[name=price]').val()*1000 + '</div><div class="col-sm-3"> 이 유형의 갯수 : ' + $('input[name=qty]').val() + '</div></div>')
		$('#room .row:last').after('<div class="row"><div class="col-sm-8"></div><div class="col-sm-2"><input type="button" value="다른 객실 추가하기" onclick="javascript:addForm()"></div><div class="col-sm-2"><input type="button" value="계속하기" onclick="javascript:clickEvent5()"</div></div>');
		$('#room').show()
		resetCheckbox()
	}
	function resetCheckbox(){
		$('input[name=facilities]').attr('checked', false)
		var facility = $('.facility')
		for(var i in facility){
			$('#'+i+'span').hide()
		}
	}
	function checkTime(select){
		$(select).prevAll().attr('style', 'color:black;')
		$(select).nextAll().attr('style', 'color:black;')
		var check = time_contradictionCheck(select)
		if(!check){
			if($(select).attr('class')=='select') $(select).val('기타').prop("selected", true)
			return
		}
		if($(select).attr('class')!='select') select.style.color = 'red'
		$('input[name=' + select.name + 'time]').attr('value', select.value)
	}
	function time_contradictionCheck(select){
		var value = 0
		if(select.name.charAt(9)=='s' || select.name.charAt(10)=='s'){
			if(select.name.charAt(9)=='s') value = $('input[name="check_in_etime"]').val().split(':')[0]
			else if(select.name.charAt(10)=='s') value = $('input[name="check_out_etime"]').val().split(':')[0]
			if(value>select.value.split(':')[0]) return true
			alert('시간을 제대로 설정해 주세요.')
			return false
		}else{
			if(select.name.charAt(9)=='e') value = $('input[name="check_in_stime"]').val().split(':')[0]
			if(select.name.charAt(10)=='e') value = $('input[name="check_out_stime"]').val().split(':')[0]
			if(value<select.value.split(':')[0]) return true
			alert('시간을 제대로 설정해 주세요.')
			return false
		}
		return true
	}
	function hideTable(num){
		$('#' + num + 'table').hide()
		$('#' + (num+1) + 'table').show()
		CompleteTable(num)
	}
	function CompleteTable(num){
		var go = $('.go')
		var go = $('.go')
		if(go[num-3].style.color=='red') return
		go[num-3].value += '(완)'
		go[num-3].style.color = 'red'
	}
	function check_value(list){
		var check_list = new Array()
		check_list['homepage'] = '웹사이트';
		check_list['accomodation_name'] = '숙소이름';
		check_list['headname'] = '담당자이름';
		check_list['tel'] = '연락처';
		check_list['city'] = '도시';
		check_list['roadname'] = '도로명';
		check_list['detail'] = '상세주소';
		check_list['postalcode'] = '우편번호';
		check_list['roomname'] = '객실이름'
		check_list['qty'] = '객실수량';
		check_list['people'] = '수용인원';
		check_list['price'] = '가격';
		for(var index in list){
			if(list[index]!='facility'){
				var input = $('input[name=' + list[index] + ']').val()
				if(input.trim()=='') {
					alert(check_list[list[index]] + ' 칸을 입력해 주세요.')
					input.focus()
					return false
				}
			}else{
				if(addFacility().trim()=='') {
					alert('시설을 선택해 주세요.')
					return false
				}
			}
		}
		return true
	}
	function clickEvent2(select){
		if(select.value=='계속하기') hideTable(2)
		else location.href = 'insertRoom.do'
	}
	function clickEvent3(){
		if($('input:radio[name=homepageAdd]:checked').val()=="yes"){
			var list = new Array()
			list.push('homepage')
			var check = check_value(list)
			if(check==false) return
		}
		hideTable(3)
	}
	function clickEvent4(){
		var list = new Array()
		list.push('accomodation_name')
		list.push('headname')
		list.push('tel')
		list.push('city')
		list.push('roadname')
		list.push('detail')
		list.push('postalcode')
		var check = check_value(list)
		if(check==false) return
		hideTable(4)
	}
	function clickEvent5(){
		hideTable(5)
	}
	function checkPay(name){
		if($('select[name="' + name + '"]').val()=='pay'){
			var pay = $('input[name="' + name + '_pay"]').val()
			if(pay==0){
				if(name=='children') var str = 'no-kid 가격 정책이'
				else var str = '반려동물 가격 정책이'
				alert('1000원 미만은 설정 할 수 없습니다.\n' + str + ' 무료정책으로 취급됩니다.')
				$('select[name="' + name + '"]').val('free')
				$('#' + name + '_pay').attr('class', 'hide')
				return '0'
			}
		}else{
			return '0'
		}
		return pay*1000
	}
	function clickEvent6(){
		var internet = checkPay('internet')
		var parking = checkPay('parking')
		var breakfast = checkPay('breakfast')
		var accomodation_facility = ''
		accomodation_facility += '인터넷,' + $('select[name=internet]').val() + ',' + internet*1000 + ','
		accomodation_facility += '주차,' + $('select[name=parking]').val() + ',' + parking*1000 + ','
		accomodation_facility += '조식,' + $('select[name=breakfast]').val() + ',' + breakfast*1000 + ','
		accomodation_facility += '언어,' + $('select[name=language]').val()
		$('input[name=accomodation_facility]').attr('value', accomodation_facility)
		hideTable(6)
	}
	function clickEvent7(){
		var check = image_total()
		if(!check) return
		hideTable(7)
	}
	function clickEvent8(){
		var policy = ''
		var children = checkPay('children')
		var pet = checkPay('pet')
		policy += 'cancel,' + $('select[name=cancel_time] option:selected').val() + ',' + $('select[name=cancel_pay] option:selected').val() + ','
		policy += 'children,' + $('select[name=children] option:selected').val() + ',' + children*1000 + ','
		policy += 'pet,' + $('select[name=pet] option:selected').val() + ',' + pet*1000
		$('input[name=policy]').attr('value', policy)
		
		$('input[name=checkin_date]').attr('value', $('input[name=check_in_stime]').val() + ' ~ ' + $('input[name=check_in_etime]').val())
		$('input[name=checkout_date]').attr('value', $('input[name=check_out_stime]').val() + ' ~ ' + $('input[name=check_out_etime]').val())
		hideTable(8)
	}
	function viewPay(select){
		var obj = $('#' + select.name + '_pay')
		if(select.value=='pay') obj.removeAttr('class')
		else{
			$('input[name="' + select.name + '_pay"]').val('0')
			obj.attr('class', 'hide')
		}
	}
	function addCard(select){
		if(select.value=='yes') $('#card').show()
		else $('#card').hide()
	}
	function check_clause(){
		inputPayment()
		var check = document.getElementsByName('clause')
		var str = ''
		for(var i in check){
			if(check[i].checked==false){
				alert('약정에 동의하셔야 등록이 가능합니다.')
				return false
			}
		}
		return check_level()
	}
	function inputPayment(){
		var str = 'card,'
		var cardStr = ''
		var card = $('input[name=card]')
		for(var i=0; i<card.length; ++i){
			if(card[i].checked==true){
				if(cardStr=='') cardStr = card[i].value
				else cardStr += '|' + card[i].value
			}
		}
		str += cardStr + ',' + 'VAT,' + $("input:radio[name='vat']:checked").val()
		$('input[name=payment]').attr('value', str)
	}
	function check_level(){
		var level = $('.go')
		for(var i=0; i<level.length-1; ++i){
			if(level[i].style.color!='red'){
				alert('상단의 완료되지 않은 단계를 완성해 주세요.')
				return false
			}
		}
		alert('숙소를 무사히 등록했습니다.')
		return true
	}
</script>
<body>
<form name="f" action="insertRoomPro2.do" method="post" enctype="multipart/form-data" onsubmit="return check_clause()">
<input type="hidden" name="account_num" value="${userSession.num}">
<input type="hidden" name="category_accomodation" value="${param.category}">
<input type="hidden" name="roominit">
<input type="hidden" name="accomodation_facility">
<input type="hidden" name="policy">
<input type="hidden" name="checkin_date">
<input type="hidden" name="checkout_date">
<input type="hidden" name="check_in_stime" value="00:00">
<input type="hidden" name="check_in_etime" value="24:00">
<input type="hidden" name="check_out_stime" value="00:00">
<input type="hidden" name="check_out_etime" value="24:00">
<input type="hidden" name="payment">
<div class="container-fluid full_color">
	<div class="row">
		<div class="col-sm-12"><a href="home.do">메인으로</a></div>
	</div>
	<div class="row">
		<div class="col-sm-12" style="white-space: nowrap;">
			<input style="width:140;" class="go" type="button" value="웹페이지 입력">
			<input style="width:140;" class="go" type="button" value="숙소 위치 입력">
			<input style="width:140;" class="go" type="button" value="객실 추가하기">
			<input style="width:140;" class="go" type="button" value="숙소 시설들 입력">
			<input style="width:140;" class="go" type="button" value="숙소 이미지 입력">
			<input style="width:140;" class="go" type="button" value="숙소 정책 입력">
			<input style="width:140;" class="go" type="button" value="결제 정보 입력">
		</div>
	</div>
	<div class="container">
		<div id="2table" class="row">
			<div class="col-sm-4 my_margin" align="center">
				<div class="row">
					<div class="col-sm-12"><font size="3">등록중인 숙박옵션</font></div>
				</div>
				<div class="row">
					<div class="col-sm-12"><font size="5">${param.category}</font></div>
				</div>
				<div class="row">
					<div class="col-sm-12"><input class="form-control" type="button" value="계속하기" onclick="javascript:clickEvent2(this)"></div>
				</div>
				<div class="row">
					<div class="col-sm-12"><input class="form-control" type="button" value="수정하기" onclick="javascript:clickEvent2(this)"></div>
				</div>
			</div>
		</div>
		<div id="3table" class="row hide">
			<div class="col-sm-12 my_margin">
				<div class="row">
					<div class="col-sm-2">
						<input type="radio" name="homepageAdd" value="yes" onchange="javascript:addHomepage(this.value)" checked>등록하겠습니다.
					</div>
					<div class="col-sm-3">
						<input type="radio" name="homepageAdd" value="no" onchange="javascript:addHomepage(this.value)">홈페이지가 없습니다.<br>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-4">
						<span id="homepage" style="display:inline-block;"><input type="text" class="form-inline" name="homepage"></span>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-4">
						<input class="form-control" type="button" value="계속하기" onclick="javascript:clickEvent3(this)">
					</div>
				</div>
			</div>
		</div>
		<div id="4table" class="row my_margin hide">
			<div class="col-sm-12">
				<div class="row">
					<div class="col-sm-10">
						<font size="4">숙소에 대해 더 알려주세요!</font>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-10">
						<font size="3">먼저 숙소 이름, 주소, 연락처를 알려주세요.</font>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-10 border">
						<div class="row">
							<div class="col-sm-12">
								<font size="3">숙소의 이름은 무엇인가요?</font>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<input type="text" name="accomodation_name" class="form-inline">
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<font size="3">숙소 검색 시 고객들이 보게 되는 이름입니다.</font>
							</div>
						</div>
					</div>
					<div class="col-sm-10 border">
						<div class="row">
							<div class="col-sm-12">
								<font size="3">숙소 연락처를 알려주세요.</font>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								담당자 이름<br>
								<input type="text" name="headname" class="form-inline">
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								연락처<br>
								<input type="text" name="tel" class="form-inline">
							</div>
						</div>
					</div>
					<div class="col-sm-10 border">
						<div class="row">
							<div class="col-sm-12">
								<font size="3">국가/지역</font>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<select name="country">
								<c:forEach var="country" items="${countryList}">
								<c:if test="${country.name=='대한민국'}">
									<option selected>${country.name}</option>
								</c:if>
								<c:if test="${country.name!='대한민국'}">
									<option>${country.name}</option>
								</c:if>
								</c:forEach>
								</select>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								도시명<br>
								<input type="text" name="city" class="form-inline">
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								도로명주소<br>
								<input type="text" name="roadname" class="form-inline">
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								상세주소<br>
								<input type="text" name="detail" class="form-inline">
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								우편번호<br>
								<input type="text" name="postalcode" class="form-inline">
							</div>
						</div>
					</div>
					<div class="col-sm-4">
						<input class="form-control" type="button" value="계속" onclick="javascript:clickEvent4()"/>
					</div>
				</div>
			</div>
		</div>
		<div id="5table" class="row my_margin hide">
			<div class="col-sm-12">
				<div id="room" class="row">
					<div class="col-sm-12">
						<div class="row">
							<div class="col-sm-10">
								<font size="4">구성 및 요금</font>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-10">
								<font size="3">우선 첫 번째  객실에 대해 알려주세요.<br>필요한 정보를 모두 입력한 뒤 다음 객실을 진행 할 수 있습니다.</font>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-10">
								<font size="3">숙소에 추가된 객실이 없습니다. 우선 객실을 추가해 주세요.</font>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-6" align="right">
								<input type="button" value="객실 추가하기" onclick="javascript:addForm()"/>
							</div>
						</div>
					</div>
				</div>
				<div id="addForm" class="row hide">
					<div class="col-sm-12">
						<div class="row">
							<div class="col-sm-12">
								<font size="5">객실종류</font><br>
							</div>
						</div>
						<div class="row border">
							<div class="col-sm-12">
								<div class="row">
									<div class="col-sm-6">
										<font size="4">객실유형</font><br>
										<select id="roomC" onchange="javascript:addOption(this.value)">
											<option>싱글룸</option>
											<option>더블룸</option>
											<option>도미토리룸</option>
										</select>
									</div>
									<div class="col-sm-6">
										<font size="4">객실종류</font><br>
										<c:forEach var="roomCate" items="${categoryRoom}" varStatus="numb">
										<c:if test="${numb.index==2}"><select id="${roomCate.key}" class="roomCate"></c:if>
										<c:if test="${numb.index!=2}"><select id="${roomCate.key}" class="roomCate hide"></c:if>
											<c:forEach var="str" items="${roomCate.value}">
											<option>${str}</option>
											</c:forEach>
										</select>
										</c:forEach>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-6">
										객실이름 : <input type="text" name="roomname">
									</div>
									<div class="col-sm-6">
										이 유형에 해당하는 룸 갯수 : <input type="text" maxlength="2" size="1"  name="qty" class="onlyNumber"> 개
									</div>
								</div>
								<div class="row">
									<div class="col-sm-6">
										수용가능 인원 : <input type="text" maxlength="2" size="1"  name="people" class="onlyNumber"> 명
									</div>
									<div class="col-sm-6">
										KRW/1박 : <input type="text"  maxlength="5" size="4" name="price" class="onlyNumber">,000원
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<font size="5">시설</font><br>
							</div>
						</div>
						<div class="row border">
							<div class="col-sm-12">
								<div class="row">
									<div class="col-sm-4">
									<c:forEach var="list" items="${facilities}" varStatus="num">
									<br><font size="4" id="${num.index}" class="myPopup">${list.key}<br></font>
									</c:forEach>
									</div>
									<div class="col-sm-8">
									<c:forEach var="list" items="${facilities}" varStatus="num">
										<div id="${num.index}span" class="row facility hide">
											<div class="col-sm-12">
												<div class="row">
													<c:forEach var="item" items="${list.value}" varStatus="num2">
													<div class="col-sm-6">
														<input type="checkbox" name="facilities" value="${item}">${item}<br>
													</div>
													</c:forEach>
												</div>
											</div>
										</div>
									</c:forEach>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-10"></div>
							<div class="col-sm-2">
								<input class="form-control" type="button" value="추가하기" onclick="javascript:addInit()"/>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="6table" class="row hide">
			<div class="col-sm-10 border">
				<div class="row">
					<div class="col-sm-12">
						<font size="4">시설 및 서비스</</font>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12">
						<font size="3">이제 숙소 전반에 관한 정보를 입력해 주세요.<br>(예시 : 이용가능한 시설, 인터넷, 주차, 언어)</</font>
					</div>
				</div>
				<div class="row border">
					<div class="col-sm-12">
						<div class="row">
							<div class="col-sm-12">
								<font size="4">인터넷<br><br></font>
								<font size="2">
									많은 여행객들이 인터넷 사용을 중요시 합니다. 무료 WiFi 또한 굉장한 매력포인트가 될 수 있습니다.<br>
								</font>
								<font size="4">인터넷 사용이 가능한가요?<br></font>
								<select name="internet" onchange="javascript:viewPay(this)">
									<option value="no">아니요</option>
									<option value="pay">예(유료옵션)</option>
									<option value="free">예(무료옵션)</option>
								</select>
							</div>
						</div>
						<div class="row hide" id="internet_pay">
							<div class="col-sm-12">
								추가 가격 : <input type="text" name="internet_pay" value="0" class="onlyNumber" maxlength="2" size="1">,000원
							</div>
						</div>
					</div>
				</div>
				<div class="row border">
					<div class="col-sm-12">
						<div class="row">
							<div class="col-sm-12">
								<font size="4">주차<br><br></font>
								<font size="2">
									차를 이용하는 투숙객에게 매우 중요한 정보입니다.<br>
								</font>
								<font size="4">주차가 가능한가요?<br></font>
								<select name="parking" onchange="javascript:viewPay(this)">
									<option value="no">아니요</option>
									<option value="pay">예(유료옵션)</option>
									<option value="free">예(무료옵션)</option>
								</select>
							</div>
						</div>
						<div class="row hide" id="parking_pay">
							<div class="col-sm-12">
								추가 가격 : <input type="text" name="parking_pay" value="0" class="onlyNumber" maxlength="2" size="1">,000원
							</div>
						</div>
					</div>
				</div>
				<div class="row border">
					<div class="col-sm-12">
						<div class="row">
							<div class="col-sm-12">
								<font size="4">조식<br><br></font>
								<font size="4">조식을 제공하시나요?<br></font>
								<select name="breakfast" onchange="javascript:viewPay(this)">
									<option value="no">아니요</option>
									<option value="pay">예(유료옵션)</option>
									<option value="free">예(무료옵션)</option>
								</select>
							</div>
						</div>
						<div class="row hide" id="breakfast_pay">
							<div class="col-sm-12">
								추가 가격 : <input type="text" name="breakfast_pay" value="0" class="onlyNumber" maxlength="2" size="1">,000원
							</div>
						</div>
					</div>
				</div>
				<div class="row border">
					<div class="col-sm-12">
						<div class="row">
							<div class="col-sm-12">
								<font size="4">언어<br><br></font>
								<font size="4">귀하 또는 직원이 구사하는 언어는 무엇인가요?<br></font>
								<select name="language">
									<option value="kor">한국어</option>
									<option value="eng">영어</option>
									<option value="chn">중국어</option>
									<option value="jpn">일본어</option>
								</select>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-10">
						<input class="form-control" type="button" value="계속" onclick="javascript:clickEvent6()"/>
					</div>
				</div>
			</div>
		</div>
		<div id="7table" class="row hide">
			<div class="col-sm-10">
				<div class="row">
					<div class="col-sm-12">
						<font size="4">숙박시설 사진</font>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12">
						<font size="3">좋은 사진은 고객이 숙소에 호기심을 가지게 됩니다.</font>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12">
						<%@ include file="insertImage_include.jsp"%>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-10">
						<input class="form-control" type="button" value="계속" onclick="javascript:clickEvent7()"/>
					</div>
				</div>
			</div>
		</div>
		<div id="8table" class="row hide">
			<div class="col-sm-12">
				<div class="row">
					<div class="col-sm-12">
						<font size="4">정책</font>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12">
						<font size="3">속소의 기본 정책을 설정해주세요. 아동 및 반려동물이 함께 숙박할 수 있나요?<br>취소 정책은 얼마나 유연하게 운영하시나요?</font>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12 border">
						취소<br>
						체크인 며칠전까지 무료 취소 기능으로 설정하시겠습니까?<br>
						<select name="cancel_time">
							<option value="0" selected>도착일(18:00)</option>
							<option value="1">1일</option>
							<option value="2">2일</option>
							<option value="3">3일</option>
							<option value="7">7일</option>
							<option value="14">14일</option>
						</select>
						<br><br>
						그렇지 않으면 투숙객이<br>
						<select name="cancel_pay">
							<option value="all">숙박료 전액을 지불합니다.</option>
							<option value="one" selected>첫 1박 요금을 지불합니다.</option>
						</select>
						<br><br>
						예약 취소의 경우, 체크인 당일 18:00까지 취소되지 않을 시 전체 숙박료를 100% 부과합니다.<br>
						정책은 차후 수정이 가능합니다. 부담없이 설정을 시작해보세요.
						<br><br>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12 border">
						실수로 진행된 예약 처리 간소화<br><br>
						실수로 진행된 예약에 대한 후속 조치에 소모되는 시간을 최소화 하기 위해 <br>
						예약이 이뤄진 시점으로부터 24시간 내에 취소 시 위약금이 자동 면제되도록 설정하였습니다.<br>
						취소 위약금 면제 시점은 숙소 관리 플랫폼에서 변경하실 수 있습니다.
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12">
						<div class="row">
							<div class="col-sm-12 border">
								체크인
								<div class="row">
									<div class="col-sm-5 border">
										시작<br>
										<input name="check_in_s" type="button" value="12:00" onclick="javascript:checkTime(this)">
										<input name="check_in_s" type="button" value="14:00" onclick="javascript:checkTime(this)">
										<input name="check_in_s" type="button" value="15:00" onclick="javascript:checkTime(this)">
										<select class="select" name="check_in_s" onchange="javascript:checkTime(this)">
											<option>기타</option>
											<option>00:00</option>
											<option>01:00</option>
											<option>02:00</option>
											<option>03:00</option>
											<option>04:00</option>
											<option>05:00</option>
											<option>06:00</option>
											<option>07:00</option>
											<option>08:00</option>
											<option>09:00</option>
											<option>10:00</option>
											<option>11:00</option>
											<option>12:00</option>
											<option>13:00</option>
											<option>14:00</option>
											<option>15:00</option>
											<option>16:00</option>
											<option>17:00</option>
											<option>18:00</option>
											<option>19:00</option>
											<option>20:00</option>
											<option>21:00</option>
											<option>22:00</option>
											<option>23:00</option>
										</select>
									</div>
									<div class="col-sm-1" style="padding: 15 0 0 30;"><font size="5">~</font></div>
									<div class="col-sm-5 border">
										마감<br>
										<input name="check_in_e" type="button" value="12:00" onclick="javascript:checkTime(this)">
										<input name="check_in_e" type="button" value="22:00" onclick="javascript:checkTime(this)">
										<input name="check_in_e" type="button" value="24:00" onclick="javascript:checkTime(this)">
										<select class="select" name="check_in_e" onchange="javascript:checkTime(this)">
											<option>기타</option>
											<option>01:00</option>
											<option>02:00</option>
											<option>03:00</option>
											<option>04:00</option>
											<option>05:00</option>
											<option>06:00</option>
											<option>07:00</option>
											<option>08:00</option>
											<option>09:00</option>
											<option>10:00</option>
											<option>11:00</option>
											<option>12:00</option>
											<option>13:00</option>
											<option>14:00</option>
											<option>15:00</option>
											<option>16:00</option>
											<option>17:00</option>
											<option>18:00</option>
											<option>19:00</option>
											<option>20:00</option>
											<option>21:00</option>
											<option>22:00</option>
											<option>23:00</option>
											<option>24:00</option>
										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 border">
							체크아웃
								<div class="row">
									<div class="col-sm-5 border">
										시작<br>
										<input name="check_out_s" type="button" value="12:00" onclick="javascript:checkTime(this)">
										<input name="check_out_s" type="button" value="14:00" onclick="javascript:checkTime(this)">
										<input name="check_out_s" type="button" value="15:00" onclick="javascript:checkTime(this)">
										<select class="select" name="check_out_s" onchange="javascript:checkTime(this)">
											<option>기타</option>
											<option>00:00</option>
											<option>01:00</option>
											<option>02:00</option>
											<option>03:00</option>
											<option>04:00</option>
											<option>05:00</option>
											<option>06:00</option>
											<option>07:00</option>
											<option>08:00</option>
											<option>09:00</option>
											<option>10:00</option>
											<option>11:00</option>
											<option>12:00</option>
											<option>13:00</option>
											<option>14:00</option>
											<option>15:00</option>
											<option>16:00</option>
											<option>17:00</option>
											<option>18:00</option>
											<option>19:00</option>
											<option>20:00</option>
											<option>21:00</option>
											<option>22:00</option>
											<option>23:00</option>
										</select>
									</div>
									<div class="col-sm-1" style="padding: 15 0 0 30;"><font size="5">~</font></div>
									<div class="col-sm-5 border">
										마감<br>
										<input name="check_out_e" type="button" value="12:00" onclick="javascript:checkTime(this)">
										<input name="check_out_e" type="button" value="22:00" onclick="javascript:checkTime(this)">
										<input name="check_out_e" type="button" value="24:00" onclick="javascript:checkTime(this)">
										<select class="select" name="check_out_e" onchange="javascript:checkTime(this)">
											<option>기타</option>
											<option>01:00</option>
											<option>02:00</option>
											<option>03:00</option>
											<option>04:00</option>
											<option>05:00</option>
											<option>06:00</option>
											<option>07:00</option>
											<option>08:00</option>
											<option>09:00</option>
											<option>10:00</option>
											<option>11:00</option>
											<option>12:00</option>
											<option>13:00</option>
											<option>14:00</option>
											<option>15:00</option>
											<option>16:00</option>
											<option>17:00</option>
											<option>18:00</option>
											<option>19:00</option>
											<option>20:00</option>
											<option>21:00</option>
											<option>22:00</option>
											<option>23:00</option>
											<option>24:00</option>
										</select>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-6 border">
						<font size="4">어린이</font><br>
						<font size="2">어린이를 동반할 수 있다면 가족단위의 손님이 더욱 찾아올 것입니다.</font><br><br><br>
						<font size="3">어린이를 동반 할 수 있습니까?</font><br>
						<select name="children" onchange="javascript:viewPay(this)">
							<option value="no" selected>아니오</option>
							<option value="pay">예(유료)</option>
							<option value="free">예(무료)</option>
						</select>
						<br><br>
						<div class="row hide" id="children_pay">
							<div class="col-sm-12">
								추가 가격 : <input type="text" name="children_pay" value="0" class="onlyNumber" maxlength="2" size="1">,000원
							</div>
						</div>
					</div>
					<div class="col-sm-6 border">
						<font size="4">반려동물</font><br>
						<font size="2">요즘 반려동물과 함께 여행하는 분들이 늘고 있습니다.<br>반려동물 허용 및 추가요금 여부를 명시해 주시기 바랍니다.</font><br><br>
						<font size="3">반려동물을 허락하시나요?</font><br>
						<select name="pet" onchange="javascript:viewPay(this)">
							<option value="no" selected>아니오</option>
							<option value="pay">예(유료)</option>
							<option value="free">예(무료)</option>
						</select>
						<br><br>
						<div class="row hide" id="pet_pay">
							<div class="col-sm-12">
								추가 가격 : <input type="text" name="pet_pay" value="0" class="onlyNumber" maxlength="2" size="1">,000원
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-10">
						<input class="form-control" type="button" value="계속" onclick="javascript:clickEvent8()"/>
					</div>
				</div>
			</div>
		</div>
		<div id="9table" class="row hide">
			<div class="col-sm-12">
				<div class="row border">
					<div class="col-sm-12">
						<font size="4">결제</font><br>
						<font size="3">귀사에서 사용하는 결제방식, 세금 정보, 추가 비용 등의 옵션을 설정하세요.</font>
					</div>
				</div>
				<div class="row border">
					<div class="col-sm-12">
						<font size="4">투숙객 결제 옵션</font><br>
						<font size="3">숙소에서 신용카드 결제가 가능합니까?</font><br>
						<input type="radio" name="card" onclick="javascript:addCard(this)" value="yes">예&emsp;<input type="radio" name="card" onclick="javascript:addCard(this)" value="no" checked>아니오<br>
						<table id="card" style="display:none;">
							<tr>
							<c:forEach var="str" items="${card}" varStatus="num">
							<c:if test="${num.count%2==1}"></tr><tr></c:if>
								<td width="200"><input type="checkbox" name="card" value="${str}">${str}</td>
							</c:forEach>
							</tr>
						</table>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12 border">
						<font size="4">수수료 결제</font><br>
						<font size="3">전월에 완료된 모든 예약에 대한 청구서를 매월 초에 전송해 드립니다.</font><br>
						<font size="3">수수료는 계약요금의 15%이며 매달 마지막 날에 청구됩니다.</font><br><br>
						<input name="clause" type="checkbox"/>
							본 숙박업체는 합법적으로 이 숙소를 운영하기 위해 필요한 모든 인허가를 취득하였으며,<br>
							요청 시 증빙서류를 제시할 수 있음을 보증합니다.<br>
							Booking.com B.V.는 숙소 등록 과정에서 숙소와 관련된 모든 정보에 대한<br>
							검증과 조사 절차를 취할 권리를 갖고 있습니다.<br>
						<input name="clause" type="checkbox"/><a href="javascript:clause()">일반 계약</a> 조건을 읽었으며, 이에 동의하고 수락합니다.
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12">
						<input class="form-control" type="submit" value="입력완료"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</form>
</body>
</html>