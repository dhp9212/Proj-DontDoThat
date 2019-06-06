<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_buisness_top.jsp"%>
<style>
	.hide{
		visibility: hidden;
	}
	.pay{
		margin:20 20 0 15;
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
			if(i%3==2) $("input[name=" + str + "_pay]").attr("value", list[i])
		}
	})
	function accomodation_input(){
		var str = ''
		str = '인터넷,' + $('select[name=internet]').val() + ',' + $('input[name=internet_pay]').val() + ','
		str += '주차,' + $('select[name=parking]').val() + ',' + $('input[name=parking_pay]').val() + ','
		str += '조식,' + $('select[name=breakfast]').val() + ',' + $('input[name=breakfast_pay]').val() + ','
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
	<div class="row">
		<div class="col-sm-6">
			<div class="row">
				<div class="col-sm-3"><font size="5">인터넷</font></div>
				<div class="col-sm-3">
					<select name="internet" class="form-control">
						<option value="no">금지</option>
						<option value="pay">유료</option>
						<option value="free">무료</option>
					</select>
				</div>
			</div>
			<div class="row" style="height:100;">
				<div class="col-sm-6 pay">
					<span id="internet_pay" class="hide">가격 : <input type="text" name="internet_pay" value="0">원</span>
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="row">
				<div class="col-sm-3"><font size="5">주차</font></div>
				<div class="col-sm-3">
					<select name="parking" class="form-control">
						<option value="no">금지</option>
						<option value="pay">유료</option>
						<option value="free">무료</option>
					</select>
				</div>
			</div>
			<div class="row" style="height:100;">
				<div class="col-sm-6 pay">
					<span id="parking_pay" class="hide">가격 : <input type="text" name="parking_pay" value="0">원</span>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-6">
			<div class="row">
				<div class="col-sm-3"><font size="5">조식</font></div>
				<div class="col-sm-3">
					<select name="breakfast" class="form-control">
						<option value="no">금지</option>
						<option value="pay">유료</option>
						<option value="free">무료</option>
					</select>
				</div>
			</div>
			<div class="row" style="height:100;">
				<div class="col-sm-6 pay">
					<span id="breakfast_pay" class="hide">가격 : <input type="text" name="breakfast_pay" value="0">원</span>
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="row">
				<div class="col-sm-3"><font size="5">언어</font></div>
				<div class="col-sm-3">
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
	<p><input type="submit" value="변경하기"></p>
</div>
</form>
<%@ include file="../_buisness_bottom.jsp"%>