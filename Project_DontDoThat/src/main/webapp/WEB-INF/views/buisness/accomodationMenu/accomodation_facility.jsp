<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_buisness_top.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		$('select').change(function(){
			if($(this).val()=='pay') $('#' + $(this).attr('name') + '_pay').show()
			else {
				$('#' + $(this).attr('name') + '_pay').hide()
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
				if($("select[name=" + str + "]").val()=="pay") $('#' + str + '_pay').show()
			}
			if(i%3==2) $("input[name=" + str + "_pay]").attr("value", list[i])
		}
	})
	function accomodation_facilityInput(){
		var str = ''
		str = '인터넷,' + $('select[name=internet]').val() + ',' + $('input[name=internet_pay]').val() + ','
		str += '주차,' + $('select[name=parking]').val() + ',' + $('input[name=parking_pay]').val() + ','
		str += '조식,' + $('select[name=breakfast]').val() + ',' + $('input[name=breakfast_pay]').val() + ','
		str += '언어,' + $('select[name=language]').val()
		$('input[name=accomodation_facility]').attr('value', str)
	}
</script>
<form name="f" action="updateAccomodation_facility" method="post" onsubmit="return accomodation_facilityInput()">
<input type="hidden" name="accomodation_facility">
	<font size="5">인터넷</font><br>
	<select name="internet">
		<option value="no">금지</option>
		<option value="pay">유료</option>
		<option value="free">무료</option>
	</select><br>
	<span id="internet_pay" class="hide"><input type="text" name="internet_pay"></span><br><br>
	
	<font size="5">주차</font><br>
	<select name="parking">
		<option value="no">금지</option>
		<option value="pay">유료</option>
		<option value="free">무료</option>
	</select><br>
	<span id=parking_pay class="hide"><input type="text" name="parking_pay"></span><br><br>
	
	<font size="5">조식</font><br>
	<select name="breakfast">
		<option value="no">금지</option>
		<option value="pay">유료</option>
		<option value="free">무료</option>
	</select><br>
	<span id="breakfast_pay" class="hide"><input type="text" name="breakfast_pay"></span><br><br>
	
	<font size="5">언어</font><br>
	<select name="language">
		<option value="kor">한국어</option>
		<option value="eng">영어</option>
		<option value="chn">중국어</option>
		<option value="jpn">일본어</option>
	</select>
	<br><br>
	
	<input type="submit" value="변경하기">
</form>
<%@ include file="../_buisness_bottom.jsp"%>