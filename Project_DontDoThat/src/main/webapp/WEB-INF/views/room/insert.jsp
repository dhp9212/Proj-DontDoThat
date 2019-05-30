<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/style.css">
<html>
<head>
	<title>숙소 카테고리</title>
</head>
<script src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('.insert').on('click', function(){
			var str = $(this).parents('td').text()
			if(str=='호텔 ') return
			$('input[name=category]').attr('value', $(this).parents('td').text())
			document.f.action = 'insertRoom1.do'
			document.f.submit()
		})
	})
	function insert2(select){
		$('input[name=category]').attr('value', $(select).parents('td').text())
		document.f.action = 'insertRoom2.do'
		document.f.submit()
	}
</script>
<body>
<form name="f" action="insertRoomPro.do" method="post" enctype="multipart/form-data" onsubmit="return check_clause()">
	<input type="hidden" name="category">
	<div align="left" id="1table">
		<h2>dontDoThat.com에 숙소를 등록하고 바로 고객을 맞이해보세요!</h2>
		<p>
		<h3>제일 먼저 dontDoThat.com에 등록하려는 숙소 유형을 선택해주세요</h3>
		<p>
		<table>
			<tr>
				<td width="150" align="center" style="margin:0px; padding:10px; float:left;">
					아파트<br>
					<input class="insert" type="button" value="숙소 등록하기">
				</td>
				<td width="150" align="center"  style="margin:0px; padding:0px; float:left;">
					홈<br>
					<input class="insert" type="button" value="숙소 등록하기">
				</td>
				<td width="150" align="center"  style="margin:0px; padding:0px; float:left;">
					호텔<br>
					<input type="button" value="숙소 등록하기" onclick="javascript:insert2(this)">
				</td>
				<td width="150" align="center"  style="margin:0px; padding:0px; float:left;">
					기타<br>
					<input class="insert" type="button" value="숙소 등록하기">
				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>