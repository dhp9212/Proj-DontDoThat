<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_buisness_top.jsp"%>
<script type="text/javascript">
$(document).ready(function() {
	$('.image').click(function(){
		
	})
})
</script>


<font size="5">쇼핑 및 식당가</font>
<div>
	<table>
		<tr>
			<td>레스토랑</td>
			<td><br><br><img class="image" src="${pageContext.request.contextPath}/resources/image/insert.png"></td>
		</tr>
		<tr>
			<td>
				카페/바
				<br><br><img class="image" src="${pageContext.request.contextPath}/resources/image/insert.png">
			</td>
		</tr>
		<tr>
			<td>
				식품점/슈퍼마켓
				<br><br><img class="image" src="${pageContext.request.contextPath}/resources/image/insert.png">
			</td>
		</tr>
		<tr>
			<td>
				시장
				<br><br><img class="image" src="${pageContext.request.contextPath}/resources/image/insert.png">
			</td>
		</tr>
	</table>
</div>
<font size="5">관광명소</font>
<div>
	<table>
		<tr>
			<td>
				산
				<br><br><img class="image" src="${pageContext.request.contextPath}/resources/image/insert.png">
			</td>
		</tr>
		<tr>
			<td>
				호수
			</td>
			<td><br><br><img class="image" src="${pageContext.request.contextPath}/resources/image/insert.png"></td>
		</tr>
		<tr>
			<td>
				강
				<br><br><img class="image" src="${pageContext.request.contextPath}/resources/image/insert.png">
			</td>
		</tr>
		<tr>
			<td>
				바다/대양
				<br><br><img class="image" src="${pageContext.request.contextPath}/resources/image/insert.png">
			</td>
		</tr>
		<tr>
			<td>
				해변
				<br><br><img class="image" src="${pageContext.request.contextPath}/resources/image/insert.png">
			</td>
		</tr>
		<tr>
			<td>
				스키리프트
				<br><br><img class="image" src="${pageContext.request.contextPath}/resources/image/insert.png">
			</td>
		</tr>
	</table>
</div>
<%@ include file="../_buisness_bottom.jsp"%>