<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../top.jsp" %>
<div class="col-lg-12">
	<div class="col-lg-12"><h1>예약</h1></div>
<c:choose>
	<c:when test="${empty listReservation}">
	<div class="col-lg-12" align="center">예약하신 숙소가 없습니다.</div>
	</c:when>
	<c:otherwise>
		<c:forEach var="dto" items="${listReservation}" varStatus="status">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<form name="cancel" action="reservation_delete.do" method="post">
			<input type="hidden" name="num" value="${dto.num}" />
			<div class="col-lg-6">
				<div class="row">
					<div class="col-lg-6"><h3>숙소 이름</h3></div><br>
					<div class="col-lg-6">${dto.payment}</div>
				</div>
			</div>
			<div class="col-lg-6">
				<div class="col-lg-6">
					<div class="col-lg-3" align="center">체크인</div>
					<div class="col-lg-3" align="center">체크아웃</div>
				</div><br>
				<div class="col-lg-6">
					<div class="col-lg-3" align="center">${dto.checkIn_date}</div>
					<div class="col-lg-3" align="center">${dto.checkOut_date}</div>
				</div><br>
				<div class="col-lg-6">
					<div class="col-lg-6" align="center">
						<button type="button" class="btn btn-primary" onclick="javascript:check();">예약 취소</button>
					</div>
				</div>
			</div>
			</form>
		</div>
	</div>
		</c:forEach>
	</c:otherwise>
</c:choose>
	<div>
<c:if test="${listCount > 0}">
	<c:if test="${startPage > pageBlock}">
		<a href="reservation_list.do?num=${userSession.num}&pageNum=${startPage - 1}" title="이전 페이지"><</a>
	</c:if>
	<c:forEach var="i" begin="${startPage}" end="${endPage}">
		페이지 : <a href="reservation_list.do?num=${userSession.num}&pageNum=${i}"><c:out value="${i}" /></a>
	</c:forEach>
	<c:if test="${endPage < pageCount}">
		<a href="reservation_list.do?num=${userSession.num}&pageNum=${startPage + pageBlock}" title="다음 페이지">></a>
	</c:if>
	</div>
</c:if>
</div>
	<script type="text/javascript">
	function check() {
		document.cancel.submit();
		alert("예약이 취소되었습니다.")
	}
	</script>
</body>
</html>