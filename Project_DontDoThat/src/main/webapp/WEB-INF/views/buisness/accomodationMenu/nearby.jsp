<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_buisness_top.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		$('.image').click(function(){
			var obj = $(this).attr('id')
			$(this).parents('tr').prev().after('<tr><td><input type="text" name="' + obj + '"></td><td><input type="text" name="' + obj +'_length"></td></tr>')
		})
	})
	function makeNearby(){
		var str = ['restaurant', 'cafe', 'market', 'mountain', 'lake', 'river', 'sea', 'beach', 'ski']
		var nearby = ''
		for(var i=0; i<str.length; ++i){
			var inputs = $('input[name=' + str[i] + ']')
			var inputs_length = $('input[name=' + str[i] + '_length]')
			if(inputs[0]=='') alert('확인중')
			for(var j=0; j<inputs.length; ++j){
				if(j==inputs.length-1) nearby += inputs[j].value + '|' + inputs_length[j].value
				else{
					if(inputs[j].value!='') nearby += inputs[j].value + '|' + inputs_length[j].value + '|'
				}
			}
			nearby += ','
		}
		$('input[name=nearby]').val(nearby)
		alert($('input[name=nearby]').val())
		return false
	}
</script>

<form name="f" action="updateNearby.do" method="post" onsubmit="javascript:makeNearby()">
<input type="hidden" name="nearby">
<font size="5">쇼핑 및 식당가</font>
<div>
	<table>
		<tr>
			<td width="30%">
				레스토랑<br>
				<input type="text" name="restaurant">
			</td>
			<td width="30%">
				거리<br>
				<input type="text" name="restaurant_length">
			</td>
		</tr>
		<tr>
			<td><img  id="restaurant" class="image" src="${pageContext.request.contextPath}/resources/img/insert.png"></td>
		</tr>
	</table>
	<table>
		<tr>
			<td width="30%">
				카페/바<br>
				<input type="text" name="cafe">
			</td>
			<td width="30%">
				거리<br>
				<input type="text" name="cafe_length">
			</td>
		</tr>
		<tr>
			<td><img  id="cafe" class="image" src="${pageContext.request.contextPath}/resources/img/insert.png"></td>
		</tr>
	</table>
	<table>
		<tr>
			<td width="30%">
				식품점/슈퍼마켓<br>
				<input type="text" name="market">
			</td>
			<td width="30%">
				거리<br>
				<input type="text" name="market_length">
			</td>
		</tr>
		<tr>
			<td><img id="market" class="image" src="${pageContext.request.contextPath}/resources/img/insert.png"></td>
		</tr>
	</table>
</div>
<font size="5">관광명소</font>
<div>
	<table>
		<tr>
			<td width="30%">
				산<br>
				<input type="text" name="mountain">
			</td>
			<td width="30%">
				거리<br>
				<input type="text" name="mountain_length">
			</td>
		</tr>
		<tr>
			<td><img id="mountain" class="image" src="${pageContext.request.contextPath}/resources/img/insert.png"></td>
		</tr>
	</table>
	<table>
		<tr>
			<td width="30%">
				호수<br>
				<input type="text" name="lake">
			</td>
			<td width="30%">
				거리<br>
				<input type="text" name="lake_length">
			</td>
		</tr>
		<tr>
			<td><img id="lake" class="image" src="${pageContext.request.contextPath}/resources/img/insert.png"></td>
		</tr>
	</table>
	<table>
		<tr>
			<td width="30%">
				강<br>
				<input type="text" name="river">
			</td>
			<td width="30%">
				거리<br>
				<input type="text" name="river_length">
			</td>
		</tr>
		<tr>
			<td><img id="river" class="image" src="${pageContext.request.contextPath}/resources/img/insert.png"></td>
		</tr>
	</table>
	<table>
		<tr>
			<td width="30%">
				바다/대양<br>
				<input type="text" name="sea">
			</td>
			<td width="30%">
				거리<br>
				<input type="text" name="sea_length">
			</td>
		</tr>
		<tr>
			<td><img id="sea" class="image" src="${pageContext.request.contextPath}/resources/img/insert.png"></td>
		</tr>
	</table>
	<table>
		<tr>
			<td width="30%">
				해변<br>
				<input type="text" name="beach">
			</td>
			<td width="30%">
				거리<br>
				<input type="text" name="beach_length">
			</td>
		</tr>
		<tr>
			<td><img id="beach" class="image" src="${pageContext.request.contextPath}/resources/img/insert.png"></td>
		</tr>
	</table>
	<table>
		<tr>
			<td width="30%">
				스키리프트<br>
				<input type="text" name="ski">
			</td>
			<td width="30%">
				거리<br>
				<input type="text" name="ski_length">
			</td>
		</tr>
		<tr>
			<td><img id="ski" class="image" src="${pageContext.request.contextPath}/resources/img/insert.png"></td>
		</tr>
	</table>
</div>
<div>
	<input type="submit" value="추가하기">
</div>
</form>
<%@ include file="../_buisness_bottom.jsp"%>