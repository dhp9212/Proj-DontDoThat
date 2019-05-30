<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../_buisness_top.jsp"%>
<script type="text/javascript">
	$(document).ready(function(){
		var list = new Array()
		var facilities = "${roomDTO.room_facility}"
		list = facilities.split('|')
		$("input[value='X']").attr("checked",true);
		for(var i=0; i<list.length-1; ++i){
			$("input[name='" + list[i] + "']:radio[value='O']").attr("checked",true);
		}
	})
	function facilityInput(){
		var facilities = $("input:radio[value='O']")
		var str = ''
		for(var i=0; i<facilities.length-1; ++i){
			if(facilities[i].checked==true) str += facilities[i].name + '|'
		}
		$("input[name=room_facility]").attr('value', str)
		return true
	}
</script>
<form name="f" action="updateRoom.do" method="post" onsubmit="return facilityInput()">
<input type="hidden" name="num" value="${roomDTO.num}">
<input type="hidden" name="accomodation_num" value="${roomDTO.accomodation_num}">
<input type="hidden" name="room_facility">
	방이름 : <input type="text" name="roomname" value="${roomDTO.roomname}"><br>
	방 사양 : <input type="text" name="roomclass" value="${roomDTO.roomclass}"><br>
	방 갯수 : <input type="text" name="qty" size="1" value="${roomDTO.qty}"><br>
	수용가능  인원 : <input type="text" name="people" size="1" value="${roomDTO.people}"><br>
	가격 : <input type="text" name="price" size="5" value="${roomDTO.price}"><br><br>
	<font size="7">시설 변경</font><br><br>
	<c:forEach var="table" items="${facility}">
	<c:if test="${table.key!='인기있는 시설'}">
		<font size="5">${table.key}<br></font>
		<c:forEach var="str" items="${table.value}" varStatus="num">
		<span style="width:5%; display:inline-block;"></span>
		<span style="width:35%; display:inline-block;">
			<font size="3">${str}</font>
		</span>
		<span style="width:8%; display:inline-block;">
			<input name="${str}" type="radio" value="O">O
			<input name="${str}" type="radio" value="X">X
		</span>
		<c:if test="${num.count%2==0}"><br></c:if>
		</c:forEach>
		<br><br>
	</c:if>
	</c:forEach>
	<br><br>
	<input type="submit" value="변경하기">
</form>
<%@ include file="../_buisness_bottom.jsp"%>