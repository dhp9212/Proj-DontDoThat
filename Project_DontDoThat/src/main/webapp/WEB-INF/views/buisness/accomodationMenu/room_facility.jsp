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
		$("input[name=price]").val("${roomDTO.price}"/1000)
	})
	function facilityInput(){
		var facilities = $("input:radio[value='O']")
		var str = ''
		for(var i=0; i<facilities.length-1; ++i){
			if(facilities[i].checked==true) str += facilities[i].name + '|'
		}
		$("input[name=room_facility]").attr('value', str)
		$("input[name=price]").val($("input[name=price]").val()*1000)
		return true
	}
</script>
<form name="f" action="updateRoom.do" method="post" onsubmit="return facilityInput()">
<input type="hidden" name="num" value="${roomDTO.num}">
<input type="hidden" name="accomodation_num" value="${roomDTO.accomodation_num}">
<input type="hidden" name="room_facility">
<div class="container-fluid" style="background-color:#fafafa">
	<div class="container">
		<p><font size="6">기본정보 변경</font></p>
		<div class="row">
			<div class="col-sm-2">방이름</div>
			<div class="col-sm-3"><input type="text" name="roomname" class="form-control" value="${roomDTO.roomname}"></div>
		</div>
		<div class="row">
			<div class="col-sm-2">방 사양</div>
			<div class="col-sm-3">
				<select name="roomclass" class="form-control">
				<c:forEach var="list" items="${categoryRoom}">
					<c:forEach var="str" items="${list.value}">
						<option>${str}</option>
					</c:forEach>
				</c:forEach>
				</select>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-2">방 갯수</div>
			<div class="col-sm-1"><input type="text" name="qty" maxlength="2" class="form-control onlyNumber" value="${roomDTO.qty}"></div>
			<div class="col-sm-1">개</div>
		</div>
		<div class="row">
			<div class="col-sm-2">수용가능  인원</div>
			<div class="col-sm-1"><input type="text" name="people" maxlength="2" class="form-control onlyNumber" value="${roomDTO.people}"></div>
			<div class="col-sm-1">명</div>
		</div>
		<div class="row">
			<div class="col-sm-2">가격</div>
			<div class="col-sm-2"><input type="text" name="price" maxlength="5" class="form-control onlyNumber"></div>
			<div class="col-sm-1">,000원</div>
		</div>
		<br>
		<p><font size="6">시설 변경</font></p>
		<c:forEach var="table" items="${facilities}">
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
	</div>
</div>
</form>
<%@ include file="../_buisness_bottom.jsp"%>