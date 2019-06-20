<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../top.jsp" %>

<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyy/MM/dd" var="nowDate" /> 

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
			<div class="col-lg-4">
					<div class="col-lg-12"><h3><a href="#" data-toggle="modal" data-target="#infoModal${dto.num }">${dto.accomodation_name}</a></h3></div><br>
					<div class="col-lg-12">예약금액 : ${dto.payment}</div> 
			</div>
			<div class="col-lg-6">
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
			<div class="col-lg-2">
				<div class="col-lg-12" align="center">
					<c:if test="${nowDate <= dto.checkOut_date}">
						<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#cancelModal${dto.num }">예약 취소</button>
					</c:if>
				</div>
			</div>
			</form>
		</div>
	</div>


	<!-- InfoModal -->
<div id="infoModal${dto.num}" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">[${dto.category_accomodation}] ${dto.accomodation_name}</h4>
      </div>
      <div class="modal-body">
		<div class="col-lg-12">소재 : ${dto.accomodation_country} > ${dto.city}</div>
		<div class="col-lg-12">주소 : ${dto.address}</div>
		<div class="col-lg-12">대표 : ${dto.headname}</div>
		<div class="col-lg-12">소개</div>
		<div class="row">
			<div class="col-lg-12">${dto.content }</div>
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>
    </div>

  </div>
</div>


	<!-- CancelModal -->
<div id="cancelModal${dto.num}" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">예약을 취소하시겠습니까</h4>
      </div>
      <div class="modal-body">
      	
        <div class="col-lg-12"><h3>${dto.accomodation_name}</h3></div><br>
		<div class="col-lg-12">예약금액 : ${dto.payment}</div>
		<div class="col-lg-12">[${dto.roomclass}] ${dto.roomname}</div>
		<div class="col-lg-12">예약한 방 수 : ${dto.rooms}</div>
		<div class="row">
			<div class="col-lg-6" align="center">체크인</div>
			<div class="col-lg-6" align="center">체크아웃</div>
		</div>
		<div class="row">
			<div class="col-lg-6" align="center">${dto.checkIn_date}</div>
			<div class="col-lg-6" align="center">${dto.checkOut_date}</div>
		</div>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" onclick="javascript:check(${dto.num});">예약취소</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>
    </div>

  </div>
</div>
	
	
	
	
	
	
	
	</c:forEach>
	<div>페이지 : 
<c:if test="${listCount > 0}">
	<c:if test="${startPage > pageBlock}">
		<a href="reservation_list.do?num=${userSession.num}&pageNum=${startPage - 1}" title="이전 페이지"><</a>
	</c:if>
	<c:forEach var="i" begin="${startPage}" end="${endPage}">
		<a href="reservation_list.do?num=${userSession.num}&pageNum=${i}"><c:out value="${i}" /></a>
	</c:forEach>
	<c:if test="${endPage < pageCount}">
		<a href="reservation_list.do?num=${userSession.num}&pageNum=${startPage + pageBlock}" title="다음 페이지">></a>
	</c:if>
</c:if>
	</div>
	</c:otherwise>
</c:choose>
</div>

	<script type="text/javascript">
	function check(num) {
		location.href = "reservation_delete.do?num=" + num
		alert("예약이 취소되었습니다.")
	}
	</script>
</body>
</html>