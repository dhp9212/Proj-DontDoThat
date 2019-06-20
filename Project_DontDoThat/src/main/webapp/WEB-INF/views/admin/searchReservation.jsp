<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../top.jsp" %>
<div class="col-lg-12">
	<div class="col-lg-12"><h1>예약</h1></div>
<c:choose>
	<c:when test="${empty listCount}">
	<div class="col-lg-12" align="center">예약하신 숙소가 없습니다.</div>
	</c:when>
	<c:otherwise>
		<c:forEach var="dto" items="${listReservation}" varStatus="status">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="col-lg-2">
					<div class="col-lg-12">
						<div class="col-lg-12" align="center">예약번호</div><br>
						<div class="col-lg-12" align="center">${dto.num}</div>
				</div>
			</div>
			<div class="col-lg-6">
					<div class="col-lg-12"><h3>${dto.accomodation_name}</h3></div><br>
					<div class="col-lg-12">${dto.payment}</div>
			</div>
			<div class="col-lg-3">
				<div class="row">
					<div class="col-lg-12">
						<div class="col-lg-6" align="center">체크인</div>
						<div class="col-lg-6" align="center">체크아웃</div>
					</div>
				</div>
				<div class="row">
				<div class="col-lg-12">
					<div class="col-lg-6" align="center">${dto.checkIn_date}</div>
					<div class="col-lg-6" align="center">${dto.checkOut_date}</div>
				</div>
				</div>
			</div>
			<div class="col-lg-1">
				<div class="col-lg-12" align="center">
					<button type="button" class="btn btn-primary" onclick="javascript:check(${dto.num});">예약 취소</button>
				</div>
			</div>
			</form>
		</div>
	</div>
		</c:forEach>
	<div>페이지 : 
<c:if test="${listCount > 0}">
	<c:if test="${startPage > pageBlock}">
		<a href="searchReservation.do?content=${param.content}&num=${userSession.num}&pageNum=${startPage - 1}" title="이전 페이지"><</a>
	</c:if>
	<c:forEach var="i" begin="${startPage}" end="${endPage}">
		<a href="searchReservation.do?content=${param.content}&num=${userSession.num}&pageNum=${i}"><c:out value="${i}" /></a>
	</c:forEach>
	<c:if test="${endPage < pageCount}">
		<a href="searchReservation.do?content=${param.content}&num=${userSession.num}&pageNum=${startPage + pageBlock}" title="다음 페이지">></a>
	</c:if>
</c:if>
	</div>
	</c:otherwise>
</c:choose>
</div>
<form name="hh" method="post" action="searchReservation.do">
<div align="center">
	<div class="col-lg-2">
		<input type="button" value="전체보기" onclick="location.href='allListReservation.do'">
	</div>
	<div class="col-lg-2">
		<select name="reservation_num">
			<option value="ff">예약번호</option>
		</select>
	</div>
	<div class="col-lg-2">
		<input type="text" name="content">
	</div>
	<div class="col-lg-1">
		<input type="button" value="검색" onclick="javascript:checkvalue()">
	</div>
</div>
</form>
	<script type="text/javascript">
	function checkvalue(){
		if(hh.content.value==''){
			return false;
		}
		document.hh.submit();
	}
	function check(num) {
		location.href = "deleteReservation.do?num=" + num
		alert("예약이 취소되었습니다.")
	}
	</script>
</body>
</html>