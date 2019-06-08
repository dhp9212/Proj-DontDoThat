<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_buisness_top.jsp"%>
<style>
	.my_button {
		display: inline-block;
		width: 90px;
		text-align: center;
		margin: 10;
		padding: 5px;
		background-color: #006BCC;
		color: #fff;
		border-radius: 3px;
	}
	.form-control{
		margin: 5;
	}
</style>
<script type="text/javascript">
	var str = ['restaurant', 'cafe', 'market', 'mountain', 'lake', 'river', 'sea', 'beach', 'ski']
	$(document).ready(function() {
		$('input[type=button]').click(function(){
			var name = $(this).attr('id')
			if(name==str[0] || name==str[1] || name==str[2]){
				if($('input[name="' + name + '"]').length>5) return
			}else {
				if($('input[name="' + name + '"]').length>2) return
			}
			$(this).parent().parent().prev().after('<div class="row"><div class="col-sm-10"><input class="form-control" maxlength="30" type="text" name="' + name + '"></div><div class="col-sm-2"><input type="text" class="form-control length" maxlength="3" name="' + name + '_length"></div></div>')
		})
		$(document).on('keydown', '.length', function(e){
			if((e.keyCode<48||e.keyCode>105||(e.keyCode>57&&e.keyCode<96))&&(e.keyCode!=8&&e.keyCode!=116)){
				alert(e.target.name)
				$('input[name="' + e.target.name + '"]').trigger('blur')
			}
		})
		var nearby = "${accomodation_dto.nearby}"
		var split = nearby.split(',')
		for(var i=0; i<split.length; ++i){
			var split2 = split[i].split('|')
			for(var j=1; j<split2.length; j++){
				if(j>2){
					if(j%2==1) var su = (j-1)/2
					else var su = (j-2)/2
				}else{
					var su = 0
				}
				if(j%2==1){
					$('#' + str[i]).trigger('click')
					var inputs = $('input[name="' + str[i] + '"]')
					inputs[su].value = split2[j]
				}else{
					var inputs = $('input[name="' + str[i] + '_length"]')
					inputs[su].value = split2[j]
				}
			}
		}
	})
	function makeNearby(){
		var nearby = ''
		for(var i=0; i<str.length; ++i){
			nearby += str[i]
			var inputs = $('input[name="' + str[i] + '"]')
			var inputs_length = $('input[name="' + str[i] + '_length"]')
			for(var j=0; j<inputs.length; ++j){
				if(inputs[j].value.trim()!='' ){
					nearby += '|' + inputs[j].value.trim() + '|' + inputs_length[j].value
					if(inputs_length[j].value==''){
						alert('거리가 적혀있지 않습니다.')
						inputs_length[j].focus()
						return false
						
					}
				}
			}
			if(i!=str.length-1) nearby += ','
		}
		alert(nearby)
		$('input[name=nearby]').val(nearby)
		return true
	}
</script>
<div class="container">
<form name="f" action="updateNearby.do" method="post" onsubmit="return makeNearby()">
<input type="hidden" name="nearby">
	<div class="row">
		<div class="col-sm-6">
			<div class="row">
				<div class="col-sm-6"><font size="5">쇼핑 및 식당가</font></div>
			</div>
			<div class="row">
				<div class="col-sm-10">레스토랑<br><input class="form-control" maxlength="30" type="text" name="restaurant"></div>
				<div class="col-sm-2">거리(m)<br><input class="form-control length" maxlength="3" type="text" name="restaurant_length"></div>
			</div>
			<div class="row">
				<div class="col-sm-12"><input id="restaurant" type="button" class="my_button" value="추가하기"></div>
			</div>
			<div class="row">
				<div class="col-sm-10">카페/바<br><input class="form-control" maxlength="30" type="text" name="cafe"></div>
				<div class="col-sm-2">거리(m)<br><input class="form-control length" maxlength="3" type="text" name="cafe_length"></div>
			</div>
			<div class="row">
				<div class="col-sm-12"><input id="cafe" type="button" class="my_button" value="추가하기"></div>
			</div>
			<div class="row">
				<div class="col-sm-10">식품점/슈퍼마켓<br><input class="form-control" maxlength="30" type="text" name="market"></div>
				<div class="col-sm-2">거리(m)<br><input class="form-control length" maxlength="3" type="text" name="market_length"></div>
			</div>
			<div class="row">
				<div class="col-sm-12"><input id="market" type="button" class="my_button" value="추가하기"></div>
			</div>
		</div>
		
		<div class="col-sm-6">
			<div class="row">
				<div class="col-sm-6"><font size="5">관광명소</font></div>
			</div>
			<div class="row">
				<div class="col-sm-10">산<br><input class="form-control" maxlength="30" type="text" name="mountain"></div>
				<div class="col-sm-2">거리(m)<br><input class="form-control length" maxlength="3" type="text" name="mountain_length"></div>
			</div>
			<div class="row">
				<div class="col-sm-12"><input id="mountain" type="button" class="my_button" value="추가하기"></div>
			</div>
			<div class="row">
				<div class="col-sm-10">호수<br><input class="form-control" maxlength="30" type="text" name="lake"></div>
				<div class="col-sm-2">거리(m)<br><input class="form-control length" maxlength="3" type="text" name="lake_length"></div>
			</div>
			<div class="row">
				<div class="col-sm-12"><input id="lake" type="button" class="my_button" value="추가하기"></div>
			</div>
			<div class="row">
				<div class="col-sm-10">강<br><input class="form-control" maxlength="30" type="text" name="river"></div>
				<div class="col-sm-2">거리(m)<br><input class="form-control length" maxlength="3" type="text" name="river_length"></div>
			</div>
			<div class="row">
				<div class="col-sm-12"><input id="river" type="button" class="my_button" value="추가하기"></div>
			</div>
			<div class="row">
				<div class="col-sm-10">바다/대양<br><input class="form-control" maxlength="30" type="text" name="sea"></div>
				<div class="col-sm-2">거리(m)<br><input class="form-control length" maxlength="3" type="text" name="sea_length"></div>
			</div>
			<div class="row">
				<div class="col-sm-12"><input id="sea" type="button" class="my_button" value="추가하기"></div>
			</div>
			<div class="row">
				<div class="col-sm-10">해변<br><input class="form-control" maxlength="30" type="text" name="beach"></div>
				<div class="col-sm-2">거리(m)<br><input class="form-control length" maxlength="3" type="text" name="beach_length"></div>
			</div>
			<div class="row">
				<div class="col-sm-12"><input id="beach" type="button" class="my_button" value="추가하기"></div>
			</div>
			<div class="row">
				<div class="col-sm-10">스키리프트<br><input class="form-control" maxlength="30" type="text" name="ski"></div>
				<div class="col-sm-2">거리(m)<br><input class="form-control length" maxlength="3" type="text" name="ski_length"></div>
			</div>
			<div class="row">
				<div class="col-sm-12"><input id="ski" type="button" class="my_button" value="추가하기"></div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12"><font size="4">잘못된 정보는 숙소에 대한 신뢰도를 떨어뜨립니다. 허위정보를 적는경우 사이트 이용에 불이익이 있을수도 있습니다.</font></div>
	</div>
	<div class="row">
		<div class="col-sm-6"><input type="submit" value="추가하기"></div>
	</div>
</form>
</div>
<%@ include file="../_buisness_bottom.jsp"%>