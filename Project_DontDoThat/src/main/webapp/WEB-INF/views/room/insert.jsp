<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<title>숙소 카테고리</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/pattern.js"></script>
</head>
<script src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('.insert').on('click', function(){
			var str = 'insertRoom'+$(this).parents('table').attr('id')+'.do'
			$('input[name=category]').attr('value', this.name)
			document.f.action = str
			document.f.submit()
		})
		$('#1').hide()
		$('#2').hide()
	})
	function showTable(table){
		$('#1').hide()
		$('#2').hide()
		$('#'+table).show()
	}
</script>
<body>
<form name="f" action="insertRoomPro.do" method="post" enctype="multipart/form-data" onsubmit="return check_clause()">
<input type="hidden" name="category">
<div class="container">
	<div>
		<font size="6"><a href="home.do">Hacking.com</a>에 숙소를 등록하고 바로 고객을 맞이해보세요!</font>
		<h4>제일 먼저 등록하려는 숙소 유형을 선택해주세요</h4>
		<br>
		<table align="center">
			<tr>
				<td width="150" align="center"><input class="btn btn-secondary m-2" type="button" value="한개의 방 등록하기" onclick="javascript:showTable(1)"></td>
				<td width="150" align="center"><input class="btn btn-secondary m-2" type="button" value="여러개의 방 등록하기" onclick="javascript:showTable(2)"></td>
			</tr>
		</table>
	</div>
	<br>
	<div align="center">
		<table id="1" class="table">
			<tr align="center">
				<td><h3>숙소종류 선택</h3></td>
			</tr>
			<tr>
			<c:forEach var="category" items="${categoryAccomodationList}">
			<c:if test="${category.category==1}">
				<td width="200" align="center" style="float: left; margin: 10;">
					${category.name}<br>
					<input type="hidden" value="${category.name}">
					<input name="${category.name}" class="btn btn-primary insert" type="button" value="숙소 등록하기">
				</td>
			</c:if>
			</c:forEach>
			</tr>
		</table>
	</div>
	<div align="center">
		<table id="2" class="table">
			<tr align="center">
				<td><h3>숙소종류 선택</h3></td>
			</tr>
			<tr>
			<c:forEach var="category" items="${categoryAccomodationList}">
			<c:if test="${category.category==2}">
				<td width="200" align="center" style="float: left; margin: 10;">
					${category.name}<br>
					<input type="hidden" value="${category.name}">
					<input name="${category.name}" class="btn btn-primary insert" type="button" value="숙소 등록하기">
				</td>
			</c:if>
			</c:forEach>
			</tr>
		</table>
	</div>
</div>
</form>
</body>
</html>