<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_buisness_top.jsp"%>
<style>
	.hide{
		display: none;
	}
	.pay{
		margin:20 20 0 15;
	}
	.cardCheck, .radioCheck{
		cursor:pointer;
	}
	.border{
		background-color: white;
		padding: 20;
		margin: 10;
	}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$('select').change(function(){
			if($(this).attr('name')!='cancel'){
				if($(this).val()=='pay') $('#' + $(this).attr('name') + '_pay').show()
				else {
					$('input[name="' + $(this).attr('name') + '_pay"]').val('0')
					$('#' + $(this).attr('name') + '_pay').hide()
				}
			}
		})
		$('.cardCheck').click(function(){
			$(this).children('input').trigger('click')
		})
		$('input[type=checkbox]').click(function(){
			e.stopPropagation()
		})
		$('.radioCheck').click(function(){
			$(this).children('input').trigger('click')
		})
		$('input[type=radio]').click(function(e){
			e.stopPropagation()
			addCard($(this).val())
		})
		
		var accomodation_policy = "${accomodation_dto.policy}"
		var list = accomodation_policy.split(',')
		for(var i=1; i<list.length; ++i){
			var str = ''
			if(i<3) str = 'cancel_time'
			else if(i<6) str = 'children'
			else if(i<9) str = 'pet'
			if(i%3==1){
				$("select[name=" + str + "]").val(list[i]).prop("selected", true)
				if($("select[name=" + str + "]").val()=="pay") $('#' + str + '_pay').show()
			}
			if(i%3==2){
				if(i<3) $("select[name=" + str + "_pay]").val(list[i]).prop("selected", true)
				else {
					if(list[i]!='0') $("input[name='" + str + "_pay']").val(list[i]/1000)
				}
			}
		}
		var checkin_date = '${accomodation_dto.checkin_date}'.split(' ~ ')
		$('#check_in_s').val(checkin_date[0]).prop("selected", true)
		$('#check_in_e').val(checkin_date[1]).prop("selected", true)
		var checkout_date = '${accomodation_dto.checkout_date}'.split(' ~ ')
		$('#check_out_s').val(checkout_date[0]).prop("selected", true)
		$('#check_out_e').val(checkout_date[1]).prop("selected", true)
		$('input[name="check_in_stime"]').val(checkin_date[0])
		$('input[name="check_in_etime"]').val(checkin_date[1])
		$('input[name="check_out_stime"]').val(checkin_date[0])
		$('input[name="check_out_etime"]').val(checkin_date[1])
		
		var payment = "${accomodation_dto.payment}".split(',')[1].split('|')
		for(var i in payment){
			if(payment[i]=='yes') addCard('yes')
			$('input[value="' + payment[i] + '"]').attr('checked', true)
		}
	})
	function checkPay(name){
		if($('select[name="' + name + '"]').val()=='pay'){
			var pay = $('input[name="' + name + '_pay"]').val()
			if(pay==0){
				if(name=='children') var str = 'no-kid 가격 정책이'
				else var str = '반려동물 가격 정책이'
				alert('1000원 미만은 설정 할 수 없습니다.\n' + str + ' 무료정책으로 취급됩니다.')
				$('select[name="' + name + '"]').val('free')
				return '0'
			}
		}else{
			return '0'
		}
		return pay*1000
	}
	function policyInput(){
		var children = checkPay('children')
		var pet = checkPay('pet')
		var str = ''
		str = 'cancel,' + $('select[name=cancel_time]').val() + ',' + $('select[name=cancel_time_pay]').val() + ','
		str += 'children,' + $('select[name=children]').val() + ',' + children + ','
		str += 'pet,' + $('select[name=pet]').val() + ',' + pet
		$('input[name=policy]').attr('value', str)
		
		str = 'card,' + $("input:radio[name='card']:checked").val()
		var card = ''
		if($("input:radio[name='card']:checked").val()=='yes'){
			var checkbox = $('input[type=checkbox]')
			for(var i=0; i<checkbox.length; ++i){
				if(checkbox[i].checked==true) card += '|' + checkbox[i].value
			}
		}
		if(card=='') str = 'card,no'
		else str += card
		$('input[name=payment]').attr('value', str)
		
		$('input[name=checkin_date]').val($('#check_in_s').val() + ' ~ ' + $('#check_in_e').val())
		$('input[name=checkout_date]').val($('#check_out_s').val() + ' ~ ' + $('#check_out_e').val())
	}
	function addCard(value){
		if(value=='yes') $('#card_list').show(100)
		else $('#card_list').hide(100)
	}
	function checkTime(select){
		var check = time_contradictionCheck(select)
		if(!check){
			if(select.id.charAt(9)=='s' || select.name.charAt(10)=='s'){
				$(select).val('00:00').prop("selected", true)
			}else{
				$(select).val('24:00').prop("selected", true)
			}
			return
		}
		$('input[name=' + select.id + 'time]').attr('value', select.value)
	}
	function time_contradictionCheck(select){
		var value = 0
		if(select.id.charAt(9)=='s' || select.id.charAt(10)=='s'){
			if(select.id.charAt(9)=='s') value = $('input[name="check_in_etime"]').val().split(':')[0]
			else if(select.id.charAt(10)=='s') value = $('input[name="check_out_etime"]').val().split(':')[0]
			if(value>select.value.split(':')[0]) return true
			alert('시간을 제대로 설정해 주세요.')
			return false
		}else{
			if(select.id.charAt(9)=='e') value = $('input[name="check_in_stime"]').val().split(':')[0]
			else if(select.id.charAt(10)=='e') value = $('input[name="check_out_stime"]').val().split(':')[0]
			if(value<select.value.split(':')[0]) return true
			alert('시간을 제대로 설정해 주세요.')
			return false
		}
		return true
	}
</script>
<form name="f" action="updatePolicy" method="post" onsubmit="return policyInput()">
<input type="hidden" name="policy">
<input type="hidden" name="payment" value="${accomodation_dto.payment}">
<input type="hidden" name="checkin_date">
<input type="hidden" name="checkout_date">
<div class="container">
	<div class="row" style="height:150;">
		<div class="col-sm-12" align="center">
			<font size="6">여기서는 귀하의 숙소 정책에 대해 설정할 수 있습니다.<br>취소부담금, no-kid설정, 사용카드변경, 체크타임 설정이 가능합니다.</font>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12 border">
			<div class="row">
				<div class="col-sm-11"><font size="5">취소정책</font></div>
			</div>
			<div class="row pay">
				<div class="col-sm-4">
					<select name="cancel_time" class="form-control">
						<option value="0">도착일(18:00)</option>
						<option value="1">1일</option>
						<option value="2">2일</option>
						<option value="3">3일</option>
						<option value="7">7일</option>
						<option value="14">14일</option>
					</select>
				</div>
				<div class="col-sm-6">
					<font size="4">까지 무료취소 됩니다.</font>
				</div>
			</div>
			<div class="row pay" style="height:70;">
				<div class="col-sm-5"><font size="4">그렇지 않은 경우 예약자는</font> </div>
				<div class="col-sm-6">
					<select name="cancel_time_pay" class="form-control">
						<option value="all">숙박료 전액을 지불합니다.</option>
						<option value="one">첫 1박 요금을 지불합니다.</option>
					</select>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-5 border">
			<div class="row">
				<div class="col-sm-4"><font size="5">어린이</font></div>
				<div class="col-sm-5">
					<select name="children" class="form-control">
						<option value="no">금지</option>
						<option value="pay">유료</option>
						<option value="free">무료</option>
					</select>
				</div>
			</div>
			<div class="row" style="height:100;">
				<div class="col-sm-6 pay">
					<span id="children_pay" class="hide">가격 : <input type="text" class="onlyNumber" name="children_pay" size="1" maxlength="2" style="padding: 0 0 0 10;" value="0"> ,000 원</span>
				</div>
			</div>
		</div>
		<div class="col-sm-5 border">
			<div class="row">
				<div class="col-sm-4"><font size="5">반려동물</font></div>
				<div class="col-sm-5">
					<select name="pet" class="form-control">
						<option value="no">금지</option>
						<option value="pay">유료</option>
						<option value="free">무료</option>
					</select>
				</div>
			</div>
			<div class="row" style="height:100;">
				<div class="col-sm-6 pay">
					<span id="pet_pay" class="hide">가격 : <input type="text" class="onlyNumber"  name="pet_pay" size="1" maxlength="2" style="padding: 0 0 0 10;" value="0"> ,000 원</span>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12 border">
			<div class="row">
				<div class="col-sm-12 pay"><font size="5">카드 설정</font></div>
			</div>
			<div class="row pay">
				<div class="col-sm-2 radioCheck"><input type="radio" name="card" class="form-check-input" value="yes">예</div>
				<div class="col-sm-2 radioCheck"><input type="radio" name="card" class="form-check-input" value="no">아니오</div>
			</div>
		</div>
	</div>
	<div id="card_list" class="row hide">
		<div class="col-sm-12 border">
			<div class="row pay">
				<div class="col-sm-5 cardCheck"><input type="checkbox" name="card" class="form-check-input" value="American Express">American Express</div>
				<div class="col-sm-5 cardCheck"><input type="checkbox" name="card" class="form-check-input" value="Visa">Visa</div>
			</div>
			<div class="row pay">
				<div class="col-sm-5 cardCheck"><input type="checkbox" name="card" class="form-check-input" value="Euro/Mastercard">Euro/Mastercard</div>
				<div class="col-sm-5 cardCheck"><input type="checkbox" name="card" class="form-check-input" value="Diners Club">Diners Club</div>
			</div>
			<div class="row pay">
				<div class="col-sm-5 cardCheck"><input type="checkbox" name="card" class="form-check-input" value="JCB">JCB</div>
				<div class="col-sm-5 cardCheck"><input type="checkbox" name="card" class="form-check-input" value="Maestro">Maestro</div>
			</div>
			<div class="row pay">
				<div class="col-sm-5 cardCheck"><input type="checkbox" name="card" class="form-check-input" value="Discover">Discover</div>
				<div class="col-sm-5 cardCheck"><input type="checkbox" name="card" class="form-check-input" value="UnionPay debit card">UnionPay debit card</div>
			</div>
			<div class="row pay">
				<div class="col-sm-5 cardCheck"><input type="checkbox" name="card" class="form-check-input" value="BC-Card">BC-Card</div>
				<div class="col-sm-5 cardCheck"><input type="checkbox" name="card" class="form-check-input" value="UnionPay credit card">UnionPay credit card</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-10"><font size="5">체크인, 체크아웃 설정</font></div>
	</div>
	<div class="row">
		<div class="col-sm-5 border">
			<div class="row">
				<div class="col-sm-6"><font size="4">체크인 시작</font></div>
				<div class="col-sm-5"><font size="4">체크인 마감</font></div>
			</div>
			<div class="row">
				<div class="col-sm-5">
					<select id="check_in_s" class="form-control check_in" onchange="javascript:checkTime(this)">
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
				<div class="col-sm-1">~</div>
				<div class="col-sm-5">
					<select id="check_in_e" class="form-control check_in" onchange="javascript:checkTime(this)">
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
		<div class="col-sm-5 border">
			<div class="row">
				<div class="col-sm-6"><font size="4">체크아웃 시작</font></div>
				<div class="col-sm-5"><font size="4">체크아웃 마감</font></div>
			</div>
			<div class="row">
				<div class="col-sm-5">
					<select id="check_out_s" class="form-control check_out" onchange="javascript:checkTime(this)">
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
				<div class="col-sm-1">~</div>
				<div class="col-sm-5">
					<select id="check_out_e" class="form-control check_out" onchange="javascript:checkTime(this)">
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
	<input type="hidden" name="check_in_stime">
	<input type="hidden" name="check_in_etime">
	<input type="hidden" name="check_out_stime">
	<input type="hidden" name="check_out_etime">
	<div class="row" style="height:50;"></div>
	<p><input type="submit" value="변경하기"></p>
</div>
</form>
<%@ include file="../_buisness_bottom.jsp"%>