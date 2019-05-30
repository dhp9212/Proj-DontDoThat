<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_buisness_top.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		$('select').change(function(){
			if($(this).attr('name')!='cancel'){
				if($(this).val()=='pay') $('#' + $(this).attr('name') + '_pay').show()
				else {
					$('#' + $(this).attr('name') + '_pay').hide()
					$('input[name=' + $(this).attr('name') + '_pay]').attr('value', '0')
				}
			}else{
				$('select[name=cancel_pay] option:first').attr('selected', true)
			}
		})
		var list = new Array()
		var accomodation_policy = "${accomodation_dto.policy}"
		list = accomodation_policy.split(',')
		for(var i=1; i<list.length; ++i){
			var str = ''
			if(i<4) str = 'cancel'
			else if(i<7) str = 'children'
			else if(i<10) str = 'pet'
			if(i%3==1){
				$("select[name=" + str + "]").val(list[i]).prop("selected", true)
				if($("select[name=" + str + "]").val()=="pay") $('#' + str + '_pay').show()
			}
			if(i%3==2) $("input[name=" + str + "_pay]").attr("value", list[i])
		}
	})
	function policyInput(){
		var str = ''
		str = 'cancel,' + $('select[name=cancel]').val() + ',' + $('select[name=cancel_pay]').val() + ','
		str += 'children,' + $('select[name=children]').val() + ',' + $('input[name=children_pay]').val() + ','
		str += 'pet,' + $('select[name=pet]').val() + ',' + $('input[name=pet_pay]').val()
		$('input[name=policy]').attr('value', str)
	}
</script>
<form name="f" action="updatePolicy" method="post" onsubmit="return policyInput()">
<input type="hidden" name="policy">
	<font size="5">취소옵션</font><br>
	<select name="cancel">
		<option value="0" selected>도착일(18:00)</option>
		<option value="1">1일</option>
		<option value="2">2일</option>
		<option value="3">3일</option>
		<option value="7">7일</option>
		<option value="14">14일</option>
	</select><br>
	<span id="cancel_pay">
		<select name="cancel_pay">
			<option value="one">하루</option>
			<option value="all">전체금액</option>
		</select>
	</span><br><br>
	
	<font size="5">어린이</font><br>
	<select name="children">
		<option value="no">금지</option>
		<option value="pay">유료</option>
		<option value="free">무료</option>
	</select><br>
	<span id=children_pay class="hide"><input type="text" name="children_pay"></span><br><br>
	
	<font size="5">애완동물</font><br>
	<select name="pet">
		<option value="no">금지</option>
		<option value="pay">유료</option>
		<option value="free">무료</option>
	</select><br>
	<span id="pet_pay" class="hide"><input type="text" name="pet_pay"></span><br><br>
	
	<input type="submit" value="변경하기">
</form>
${accomodation_dto.payment}
${accomodation_dto.checkin_date}
${accomodation_dto.checkout_date}
<%@ include file="../_buisness_bottom.jsp"%>