<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_buisness_top.jsp"%>
<style>
	.hide{
		visibility: hidden;
	}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$('select').change(function(){
			if($(this).val()=='pay') $('#' + $(this).attr('name') + '_pay').attr('style', 'visibility: visible;')
			else {
				$('#' + $(this).attr('name') + '_pay').attr('style', 'visibility: hidden;')
				$('input[name=' + $(this).attr('name') + '_pay]').attr('value', '0')
			}
		})
		
		var list = new Array()
		var accomodation_facilities = "${accomodation_dto.accomodation_facility}"
		list = accomodation_facilities.split(',')
		for(var i=1; i<list.length; ++i){
			var str = ''
			if(i<4) str = 'internet'
			else if(i<7) str = 'parking'
			else if(i<10) str = 'breakfast'
			else if(i>=10) str = 'language'
			if(i%3==1){
				$("select[name=" + str + "]").val(list[i]).prop("selected", true)
				if($("select[name=" + str + "]").val()=="pay") $('#' + str + '_pay').attr('style', 'visibility: visible;')
			}
			if(i%3==2) $("input[name=" + str + "_pay]").attr("value", list[i])
		}
		
		var policy = "${accomodation_dto.policy}"
		for(var i in policy){
			if(i<4) str = 'cancel'
			else if(i<7) str = 'children'
			else if(i<10) str = 'pet'
			if(i%3==1){
				$("select[name=" + str + "]").val(list[i]).prop("selected", true)
				if($("select[name=" + str + "]").val()=="pay") $('#' + str + '_pay').attr('style', 'visibility: visible;')
			}
			if(i%3==2) $("input[name=" + str + "_pay]").attr("value", list[i])
		}
		
		var payment = "${accomodation_dto.payment}"[1].split('|')
		for(var i in payment){
			$('input[value=' + payment[i] + ']').attr('checked', true)
		}
	})
	function accomodation_input(){
		var str = ''
		str = '인터넷,' + $('select[name=internet]').val() + ',' + $('input[name=internet_pay]').val() + ','
		str += '주차,' + $('select[name=parking]').val() + ',' + $('input[name=parking_pay]').val() + ','
		str += '조식,' + $('select[name=breakfast]').val() + ',' + $('input[name=breakfast_pay]').val() + ','
		str += '언어,' + $('select[name=language]').val()
		$('input[name=accomodation_facility]').attr('value', str)
		
		str = ''
		str = '취소,' + $('select[name=cancel_time]').val() + ',' + $('input[name=cancel_pay]').val() + ','
		str += '어린이,' + $('select[name=children]').val() + ',' + $('input[name=children_pay]').val() + ','
		str += '동물,' + $('select[name=pet]').val() + ',' + $('input[name=pet_pay]').val()
		$('input[name=policy]').attr('value', str)
		
		str = ''
		var payment = "${accomodation_dto.payment}".split(',')[1]
		var card = $('input[name=card]')
		for(var i in card){
			/* if(card[i].checked) */
		}
		str = '카드,' + $('select[name=cancel_time]').val() + ',' + $('input[name=cancel_pay]').val() + ','
		str += '어린이,' + $('select[name=children]').val() + ',' + $('input[name=children_pay]').val() + ','
		str += '동물,' + $('select[name=pet]').val() + ',' + $('input[name=pet_pay]').val()
		$('input[name=payment]').attr('value', str)
	}
	function addCard(value){
		if(value=='yes') $('#card_list').attr('style', 'visibility: visible;')
		else $('#card_list').attr('style', 'visibility: hidden;')
	}
</script>
<form name="f" action="updateAccomodation_facility" method="post" onsubmit="return accomodation_input()">
<input type="hidden" name="accomodation_facility">
<input type="hidden" name="policy" value="${accomodation_dto.policy}">
<input type="hidden" name="payment" value="${accomodation_dto.payment}">
<div class="container">
	<div class="row">
		<div class="col-sm-4">
			<font size="5">인터넷</font><br>
			<select name="internet">
				<option value="no">금지</option>
				<option value="pay">유료</option>
				<option value="free">무료</option>
			</select>
		</div>
		<div class="col-sm-4">
			<font size="5">주차</font><br>
			<select name="parking">
				<option value="no">금지</option>
				<option value="pay">유료</option>
				<option value="free">무료</option>
			</select>
		</div>
		<div class="col-sm-3">
			<font size="5">조식</font><br>
			<select name="breakfast">
				<option value="no">금지</option>
				<option value="pay">유료</option>
				<option value="free">무료</option>
			</select>
		</div>
	</div>
	<div class="row" style="height:100;">
		<div class="col-sm-4">
			<span id="internet_pay" class="hide">가격 : <input type="text" name="internet_pay" value="0">원</span>
		</div>
		<div class="col-sm-4">
			<span id="parking_pay" class="hide">가격 : <input type="text" name="parking_pay" value="0">원</span>
		</div>
		<div class="col-sm-3">
			<span id="breakfast_pay" class="hide">가격 : <input type="text" name="breakfast_pay" value="0">원</span>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-4">
			<font size="5">취소정책</font><br>
			<select name="cancel_time">
				<option value="0" selected>도착일(18:00)</option>
				<option value="1">1일</option>
				<option value="2">2일</option>
				<option value="3">3일</option>
				<option value="7">7일</option>
				<option value="14">14일</option>
			</select>
		</div>
		<div class="col-sm-4">
			<font size="5">어린이 정책</font><br>
			<select name="children">
				<option value="no">금지</option>
				<option value="pay">유료</option>
				<option value="free">무료</option>
			</select>
		</div>
		<div class="col-sm-3">
			<font size="5">반려동물 정책</font><br>
			<select name="pet">
				<option value="no">금지</option>
				<option value="pay">유료</option>
				<option value="free">무료</option>
			</select>
		</div>
	</div>
	<div class="row" style="height:100;">
		<div class="col-sm-4">
			<select name="cancel_pay">
				<option value="all">숙박료 전액을 지불합니다.</option>
				<option value="one" selected>첫 1박 요금을 지불합니다.</option>
			</select>
		</div>
		<div class="col-sm-4">
			<span id="children_pay" class="hide">가격 : <input type="text" name="children_pay" value="0">원</span>
		</div>
		<div class="col-sm-3">
			<span id="pet_pay" class="hide">가격 : <input type="text" name="pet_pay" value="0">원</span>
		</div>
	</div>
	<div class="row" style="height:100;">
		<div class="col-sm-4">
			<font size="5">언어</font><br>
			<select name="language">
				<option value="kor">한국어</option>
				<option value="eng">영어</option>
				<option value="chn">중국어</option>
				<option value="jpn">일본어</option>
			</select>
		</div>
	</div>
	<div class="row" style="height:200;">
		<div class="col-sm-11">
			<font size="5">card</font><br>
			<input type="radio" name="card" onclick="javascript:addCard(this.value)" value="yes">예&emsp;
			<input type="radio" name="card" onclick="javascript:addCard(this.value)" value="no" checked>아니오
			<br>
			<span id="card_list" class="hide">
				<span style="width:30%; display:inline-block;"><input type="checkbox" name="card" value="American Express">American Express</span>
				<span style="width:30%; display:inline-block;"><input type="checkbox" name="card" value="Visa">Visa<br></span>
				<span style="width:30%; display:inline-block;"><input type="checkbox" name="card" value="Euro/Mastercard">Euro/Mastercard</span>
				<span style="width:30%; display:inline-block;"><input type="checkbox" name="card" value="Diners Club">Diners Club<br></span>
				<span style="width:30%; display:inline-block;"><input type="checkbox" name="card" value="JCB">JCB</span>
				<span style="width:30%; display:inline-block;"><input type="checkbox" name="card" value="Maestro">Maestro<br></span>
				<span style="width:30%; display:inline-block;"><input type="checkbox" name="card" value="Discover">Discover</span>
				<span style="width:30%; display:inline-block;"><input type="checkbox" name="card" value="UnionPay debit card">UnionPay debit card<br></span>
				<span style="width:30%; display:inline-block;"><input type="checkbox" name="card" value="BC-Card">BC-Card</span>
				<span style="width:30%; display:inline-block;"><input type="checkbox" name="card" value="UnionPay credit card">UnionPay credit card<br></span>
			</span>
		</div>
	</div>
	${accomodation_dto.policy}
	${accomodation_dto.payment}
	<p><input type="submit" value="변경하기"></p>
</div>
</form>
<%@ include file="../_buisness_bottom.jsp"%>