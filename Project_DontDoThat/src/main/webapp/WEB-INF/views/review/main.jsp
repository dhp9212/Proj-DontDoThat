<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>
<style>
.mybutton23 {
           display: inline-block;
           width: 100px;
           text-align: center;
           line-height: 20px;
           padding: 8px;
           background-color: #0898FF;
           color: #fff;
           text-decoration: none;
           border-radius: 5px;
    }
</style>
<script type="text/javascript">
	function writeReview(reservation_num, accomodation_num, lodge_date){
		var myform = document.v6;
		window.open("" ,"v6", 
		       "toolbar=no, width=500, height=600"); 
		myform.action = "reviewWrite.do"; 
		myform.method = "post";
		myform.target = "v6";
		myform.reservation_num.value = reservation_num;
		myform.accomodation_num.value = accomodation_num;
		myform.lodge_date.value = lodge_date;
		myform.submit();
	}
</script>
<br>
<div class="container" style="width:70%;">
	<table style="border:1px solid #BDBDBD; background-color:white">
			<tr>
				<td align="center">예약번호</td>
				<td align="center">숙소이름</td>
				<td align="center">방번호</td>
				<td align="center">체크인 날짜</td>
				<td align="center">체크아웃 날짜</td>
				<td align="center">후기 작성</td>
			</tr>
		<c:if test="${not empty listReservation}">
			<c:forEach var="dcc" items="${listReservation}">
				<tr>
					<td align="center">${dcc.num}</td>
					<td align="center">${dcc.accomodation_name}</td>
					<td align="center">${dcc.rooms}</td>
					<td align="center">${dcc.checkIn_date}</td>
					<td align="center">${dcc.checkOut_date}</td>
					<td align="center">
						<c:choose>
							<c:when test="${dcc.check_review == 1}">
								<div class="mybutton23">작성완료</div>
							</c:when>
							<c:otherwise>
								<a href="javascript:writeReview('${dcc.num}','${dcc.accomodation_num}','${dcc.checkIn_date}')"
								class="mybutton23">작성하기</a>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty listReservation}">
			<tr>
				<td colspan="6" align="center">예약 내역이 없습니다.</td>
			</tr>
		</c:if>
	</table>
		<form name="v6">
			<input type="hidden" name="reservation_num">
			<input type="hidden" name="accomodation_num">
			<input type="hidden" name="lodge_date">
		</form>
</div>