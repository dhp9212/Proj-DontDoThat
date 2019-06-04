<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../top.jsp" %>
	<div class="bodyconstraint">
		<div id="subheader-wrapper">
			<nav>
				<ol>
					<li>a</li>
					<li>b</li>
					<li>c</li>
				</ol>
			</nav>
		</div>
		<div id="bodyconstraint-inner">
		test text
		
		</div>
	
	<%-- <c:choose>
		<c:when test="${empty listAccomodation}">
		<table border="0" width="100%">
	  		<tr>
				<td align="left">
					<h1>이 지역 내, 혹은 인근 예약 가능한 숙소 0개</h1>
				</td>
				<td align="right">
					<a href="">지도로 보기</a>
				</td>
			</tr>
		</table>
		<table border="1" width="100%">
	  		<tr>
				<td align="center">
					<h2>원하는 검색결과를 얻는 방법</h2><br>
					<h3>다음 옵션을 사용하여 원하는 숙소를 찾아보세요 :</h3>
				</td>
			</tr>
			<tr>
				<td align="left">
					좌측 검색창 사용<br>
					<a href="">검색 조건 변경</a><br>
					<a href="">다른 날짜로 검색</a>
				</td>
			</tr>
		</table>
		</c:when>
		<c:otherwise>
		<table border="0" width="100%">
			<tr>
				<td align="left">
					<h1>검색된 숙소</h1>
				</td>
				<td align="right">
					<a href="">지도로 보기</a>
				</td>
			</tr>
		</table>
		<table border="1" width="100%">
			<tr>
				<th width="20%">저희가 추천하는 숙소</th>
				<th width="15%">요금(낮은 순)</th>
				<th width="10%">성급</th>
				<th width="15%">성급 + 요금 순</th>
				<th width="20%">도시 중심으로부터의 거리</th>
				<th width="20%">고평점 후기가 많은 순</th>
			</tr>
		</table>
			<c:forEach var="dto" items="${listAccomodation}">
		<table border="0" width="100%">
			<tr>
				<td width="25%" rowspan="4">
					<img src="image/${dto.image}" width="200" height="200" border="0">
				</td>
				<td width="50%">
					<a href="search_accomodation_content.do?num=${dto.num}">
						<h3>[${dto.category_accomodation}]${dto.accomodation_name}</h3>
					</a>
				</td>
				<td width="25%" align="right">이용 후기 평점</td>
			</tr>
			<tr>
				<td width="50%">
					<a href="">${dto.city} - 지도에서 표시</a>
				</td>
				<td width="25%" align="right" rowspan="2">
					<input type="button" value="요금 표시" onClick="location.href=''">
				</td>
			</tr>
			<tr>
				<td width="50%">${dto.content}</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="button" value="예약 가능 옵션 보기" onClick="location.href='search_accomodation_content.do?num=${dto.num}'">
				</td>
			</tr>
		</table>
			</c:forEach>
		</c:otherwise>
	</c:choose> --%>
	</div>
	</div>
</body>
</html>