<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_buisness_top.jsp"%>
<style>
	.hide{
		visibility: hidden;
	}
	.pay{
		align: center;
		margin: 10 10 0 15;
		padding: 15;
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
			if($(this).val()=='pay') $('#' + $(this).attr('name') + '_pay').removeAttr('class')
			else {
				$('#' + $(this).attr('name') + '_pay').attr('class', 'hide')
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
				if($("select[name=" + str + "]").val()=="pay") $('#' + str + '_pay').removeAttr('class')
			}
			if(i%3==2){
				if(list[i]!='0') list[i] = list[i]/1000
				$("input[name=" + str + "_pay]").attr("value", list[i])
			}
		}
	})
	function checkPay(name){
		if($('select[name="' + name + '"]').val()=='pay'){
			var pay = $('input[name="' + name + '_pay"]').val()
			if(pay==0){
				if(name=='internet') var str = '인터넷 가격 정책이'
				else if(name=='parking') var str = '주차 가격 정책이'
				else var str = '조식의 가격 정책이'
				alert('1000원 미만은 설정 할 수 없습니다.\n' + str + ' 무료정책으로 취급됩니다.')
				$('select[name="' + name + '"]').val('free')
				return '0'
			}
		}else{
			return '0'
		}
		return pay*1000
	}
	/* 정보취합 */
	function accomodation_input(){
		var internet = checkPay('internet')
		var parking = checkPay('parking')
		var breakfast = checkPay('breakfast')
		var str = ''
		str = '인터넷,' + $('select[name=internet]').val() + ',' + internet + ','
		str += '주차,' + $('select[name=parking]').val() + ',' + parking + ','
		str += '조식,' + $('select[name=breakfast]').val() + ',' + breakfast + ','
		str += '언어,' + $('select[name=language]').val()
		$('input[name=accomodation_facility]').attr('value', str)
	}
</script>
<form name="f" action="updateAccomodation_facility" method="post" onsubmit="return accomodation_input()">
<input type="hidden" name="accomodation_facility">
<div class="container">
	<div class="row" style="height:150;">
		<div class="col-sm-12" align="center">
			<font size="6">여기서는 귀하의 숙소 시설에 대해 설정할 수 있습니다.<br>이용부담금 및 조식종류 등 설정해 보세요.</font>
		</div>
	</div>
	<div class="row pay">
		<div class="col-sm-5 border">
			<div class="row">
				<div class="col-sm-5"><font size="5">인터넷</font></div>
				<div class="col-sm-5">
					<select name="internet" class="form-control">
						<option value="no">금지</option>
						<option value="pay">유료</option>
						<option value="free">무료</option>
					</select>
				</div>
			</div>
			<div class="row" style="height:100;">
				<div class="col-sm-10 pay">
					<span id="internet_pay" class="hide">가격 : <input type="text" class="onlyNumber" size="1" maxlength="2"style="padding: 0 0 0 10;" name="internet_pay" value="0"> ,000 원</span>
				</div>
			</div>
		</div>
		<div class="col-sm-5 border">
			<div class="row">
				<div class="col-sm-5"><font size="5">주차</font></div>
				<div class="col-sm-5">
					<select name="parking" class="form-control">
						<option value="no">금지</option>
						<option value="pay">유료</option>
						<option value="free">무료</option>
					</select>
				</div>
			</div>
			<div class="row" style="height:100;">
				<div class="col-sm-10 pay">
					<span id="parking_pay" class="hide">가격 : <input type="text" class="onlyNumber" size="1" maxlength="2" style="padding: 0 0 0 10;" name="parking_pay" value="0"> ,000원</span>
				</div>
			</div>
		</div>
	</div>
	<div class="row pay">
		<div class="col-sm-5 border">
			<div class="row">
				<div class="col-sm-5"><font size="5">조식</font></div>
				<div class="col-sm-5">
					<select name="breakfast" class="form-control">
						<option value="no">금지</option>
						<option value="pay">유료</option>
						<option value="free">무료</option>
					</select>
				</div>
			</div>
			<div class="row" style="height:100;">
				<div class="col-sm-10 pay">
					<span id="breakfast_pay" class="hide">가격 : <input type="text" class="onlyNumber" size="1" maxlength="2" style="padding: 0 0 0 10;" name="breakfast_pay" value="0"> ,000원</span>
				</div>
			</div>
		</div>
		<div class="col-sm-5 border">
			<div class="row">
				<div class="col-sm-5"><font size="5">언어</font></div>
				<div class="col-sm-5">
					<select name="language" class="form-control">
						<option value="kor">한국어</option>
						<option value="eng">영어</option>
						<option value="chn">중국어</option>
						<option value="jpn">일본어</option>
					</select>
				</div>
			</div>
		</div>
	</div>
	<div class="row pay">
		<div class="col-sm-4"><p><input type="submit" value="변경하기"></p></div>
	</div>
</div>
</form>
<%@ include file="../_buisness_bottom.jsp"%>