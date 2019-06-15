<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/style.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<title>홈 입력</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/pattern.js"></script>
	
<style>
	div{
		margin: 5 0 5 0;
	}
</style>
</head>
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
	function addHomepage(value){
		if(value=='yes') $('#homepage').show()
		else $('#homepage').hide()
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
		check_list['people'] = '수용인원';
		check_list['price'] = '가격';
		for(var index in list){
			var input = $('input[name=' + list[index] + ']').val()
			if(input.trim()=='') {
				alert(check_list[list[index]] + ' 칸을 입력해 주세요.')
				input.focus()
				return false
			}
		}
		return true
	}
	function hideTable(num){
		$('#' + num + 'table').hide()
		$('#' + num + 'table').next().show()
		CompleteTable(num)
	}
	function CompleteTable(num){
		var go = $('.go')
		if(go[num-3].style.color=='red') return
		go[num-3].value += '(완)'
		go[num-3].style.color = 'red'
	}
	function value_insert(check){
		var str = ''
		for (var i=0; i<check.length; i++) {
			if (check[i].checked == true){
				if(str=='') str = check[i].value
				else str += ',' + check[i].value
			}
		}
		return str
	}
	function clickEvent2(a) {
		if (a.value == '계속하기') {
			hideTable(2)
		} else {
			location.href = 'insertRoom.do'
		}
	}
	function clickEvent3() {
		if($('input:radio[name=homepageAdd]:checked').val()=="yes"){
			var list = new Array()
			list.push('homepage')
			var check = check_value(list)
			if(check==false) return
		}
		hideTable(3)
	}
	function clickEvent4() {
		var list = new Array()
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
	function clickEvent5() {
		var list = new Array()
		list.push('people')
		var check = check_value(list)
		if(check==false) return
		hideTable(5)
	}
	function clickEvent6() {
		var check = document.getElementsByName('facilities')
		var str = value_insert(check)
		document.f.accomodation_facility.value = str
		hideTable(6)
	}
	function clickEvent7(){
		var check = image_total()
		if(!check) return
		hideTable(7)
	}
	function clickEvent8() {
		var list = new Array()
		list.push('accomodation_name')
		var check = check_value(list)
		if(check==false) return
		hideTable(8)
	}
	function clickEvent9() {
		var list = new Array()
		list.push('price')
		var check = check_value(list)
		if(check==false) return
		hideTable(9)
	}
	function clickEvent10() {
		var check = document.getElementsByName('policies')
		var str = value_insert(check)
		document.f.policy.value = str
		hideTable(10)
	}
	function clickEvent11() {
		hideTable(11)
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
		return check_level()
	}
	function check_level(){
		var level = $('.go')
		for(var i=0; i<level.length; ++i){
			if(level[i].style.color!='red'){
				alert('상단의 완료되지 않은 단계를 완성해 주세요.')
				return false
			}
		}
		var price = $('input[name="price"]').val()*1000
		$('input[name="price"]').val(price)
		alert('숙소를 무사히 등록했습니다.')
		return true
	}
</script>
<body>
<form name="f" action="insertRoomPro.do" method="post" enctype="multipart/form-data" onsubmit="return check_clause()">
<input type="hidden" name="account_num" value="${userSession.num}">
<input type="hidden" name="category_accomodation" value="${param.category}">
<input type="hidden" name="accomodation_facility">
<input type="hidden" name="policy">
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
			<input style="width:140;" class="go" type="button" value="인원 입력하기">
			<input style="width:140;" class="go" type="button" value="숙소 시설들 입력">
			<input style="width:140;" class="go" type="button" value="숙소 사진 입력">
			<input style="width:140;" class="go" type="button" value="숙소 이름 입력">
			<input style="width:140;" class="go" type="button" value="숙소 수익 입력">
			<input style="width:140;" class="go" type="button" value="정책 입력">
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
						<font size="3">주소, 연락처를 알려주세요.</font>
					</div>
				</div>
				<div class="row">
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
		<div id="5table" class="row hide">
			<div class="row">
				<div class="col-sm-12">
					<font size="5">수용 가능한 인원은 몇 명인가요?</font>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<input type="text" name="people" maxlength="2" class="form-inline onlyNumber">
				</div>
			</div>
			<div class="row">
				<div class="col-sm-4">
					<input class="form-control" type="button" value="계속하기" onclick="javascript:clickEvent5(this)">
				</div>
			</div>
		</div>
		<div id="6table" class="row hide">
			<div class="row">
				<div class="col-sm-12">
					<font size="5">투숙객이 숙소에서 이용할 수 있는 것은 무엇인가요?</font>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<input name="facilities" type="checkbox" value="난방 시설" />난방<br>
					<input name="facilities" type="checkbox" value="무료 Wi-Fi" />무료 Wi-Fi<br>
					<input name="facilities" type="checkbox" value="에어컨" />에어컨<br>
					<input name="facilities" type="checkbox" value="구내 주차" />구내 주차<br>
					<input name="facilities" type="checkbox" value="수영장" />수영장
				</div>
			</div>
			<div class="row">
				<div class="col-sm-4">
					<input class="form-control" type="button" value="계속하기" onclick="javascript:clickEvent6(this)">
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
			<div class="col-sm-10">
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
				</div>
				<div class="row">
					<div class="col-sm-10">
						<input class="form-control" type="button" value="계속" onclick="javascript:clickEvent8()"/>
					</div>
				</div>
			</div>
		</div>
		<div id="9table" class="row hide">
			<div class="col-sm-10">
				<div class="row">
					<div class="col-sm-10 border">
						<div class="row">
							<div class="col-sm-12">
								<font size="3">1박당 수익 목표는 얼마인가요?</font>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								KRW/1박 : <input type="text"  maxlength="5" size="4" name="price" class="onlyNumber">,000원
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-10">
						<input class="form-control" type="button" value="계속" onclick="javascript:clickEvent9()"/>
					</div>
				</div>
			</div>
		</div>
		<div id="10table" class="row hide">
			<div class="row">
				<div class="col-sm-12">
					<font size="5">투숙객이 숙소에서 이용할 수 있는 것은 무엇인가요?</font>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<input name="policies" type="checkbox" value="흡연 가능" />흡연 가능<br>
					<input name="policies" type="checkbox" value="반려동물 동반 가능" />반려동물 동반 가능<br>
					<input name="policies" type="checkbox" value="아동 동반 가능" />아동 동반 가능<br>
					<input name="policies" type="checkbox" value="파티/행사를 허용합니다" />파티/행사를 허용합니다<br>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-4">
					<input class="form-control" type="button" value="계속하기" onclick="javascript:clickEvent10(this)">
				</div>
			</div>
		</div>
		<div id="11table" class="row hide">
			<div class="row">
				<div class="col-sm-12">
					<font size="5">유의사항</font>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<font size="4">성공적인 숙소 운영을 위해 반드시 숙지하셔야 할 정보를 엄선하여 안내해드립니다.</font>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<font size="4">
						예약 즉시 확정<br>
						캘린더에서 특정 날짜에 예약이 가능하도록 설정하시면 Booking.com에 숙소가 표시되며, 접수된 모든 예약은 즉시 확정됩니다.
					</font>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<font size="4">
						예약 자동 승인<br>
						접수된 예약은 자동 승인됩니다. 따라서 별도로 예약을 승인하거나 거부해야
						할 번거로움이 없어 업무를 최소화하고 예약률을 극대화하실 수 있습니다.
					</font>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<font size="4">
						최신 상태로 캘린더 관리<br>
						캘린더를 최신으로 유지하면 모든 예약을 정상적으로 진행하실 수 있습니다.
						또한 같은 날짜에 여러 건의 예약이 접수되는 오버부킹이 발생할 여지가 없습니다.
					</font>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-4">
					<input class="form-control" type="button" value="계속하기" onclick="javascript:clickEvent11(this)">
				</div>
			</div>
		</div>
		<div id="12table" class="row hide">
			<div class="row">
				<div class="col-sm-12">
					<font size="5">거의 완료되었습니다!</font>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<font size="4">숙소 등록 절차가 거의 완료되었습니다. 그전에 몇 가지 주의 사항을 안내해드립니다.</font>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<font size="4">
						온라인으로 예약을 접수할 준비가 된 경우 다음 페이지로 이동하여<br> 캘린더에서 숙소를 판매할 날짜를 선택하실
						수 있습니다.<br> 숙소 등록이 완료되면 고객이 해당 날짜에 예약을 진행할 수 있게 됩니다.<br>
						아직 예약을 접수할 준비가 되지 않은 경우, 우선 숙소 등록을 완료한 뒤<br> 나중에 캘린더에서 예약이 가능한
						날짜를 선택하실 수 있습니다.<br> 이후 준비가 되는 대로 예약 접수를 시작하시면 됩니다.
					</font>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<font size="4">
						예약 자동 승인<br>
						접수된 예약은 자동 승인됩니다. 따라서 별도로 예약을 승인하거나 거부해야
						할 번거로움이 없어 업무를 최소화하고 예약률을 극대화하실 수 있습니다.
					</font>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<input name="clause" type="checkbox" />
					본 숙박업체는 합법적으로 이 숙소를 운영하기 위해 필요한 모든 인허가를 취득하였으며,<br>
					요청 시 증빙서류를 제시할 수 있음을 보증합니다.<br>
					Booking.com B.V.는 숙소 등록 과정에서 숙소와 관련된 모든 정보에 대한<br>
					검증과 조사 절차를 취할 권리를 갖고 있습니다.<br>
					<input name="clause" type="checkbox" />
						<a href="javascript:clause()">일반 계약</a>
						조건을 읽었으며, 이에 동의하고 수락합니다.
				</div>
			</div>
			<div class="row">
				<div class="col-sm-4">
					<input class="form-control" type="submit" value="입력완료"">
				</div>
			</div>
		</div>
	</div>
</div>
</form>
</body>
</html>