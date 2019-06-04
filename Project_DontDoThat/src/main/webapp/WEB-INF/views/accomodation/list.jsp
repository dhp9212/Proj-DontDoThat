<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../top.jsp" %>
	<table width="100%">
		<tr>
			<th colspan="2">지역</th><td><div id="map"></div></td>
		</tr>
		<tr>
			<td width="30%;">
				<div>
					<table border="2">
						<tr>
							<tr><th>검색</th></tr>
							<tr><td>여행지/숙소이름</td></tr>
							<tr><td><input type="text" value="${input_place}"></td></tr>
							<tr><td>체크인 날짜</td></tr>
							<tr><td><input type="text" value="${start_date}"></td></tr>
							<tr><td>체크아웃 날짜</td></tr>
							<tr><td><input type="text" value="${end_date}"></td></tr>
							<tr></tr>
							<tr>
								<td>
									<select name="adults">
									<c:forEach var="i" begin="1" end="30">
										<option value="i">성인 ${i}명</option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td>
									<select name="children">
										<option value="0">동반 아동 없음</option>
									<c:forEach var="i" begin="1" end="10">
										<option value="i">아동 ${i}명</option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td>
									<select name="rooms">
									<c:forEach var="i" begin="1" end="30">
										<option value="i">객실 ${i}개</option>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td>
									<input type="button" value="검 색" onClick="location.href=''">
								</td>
							</tr>
					</table>
				</div>
			</td>
	<!-- datalist -->
			<td width="70%;">
				<div>
	<c:choose>
		<c:when test="${empty listAccomodation}">
					<table border="0" width="70%">
				  		<tr>
				  			<td><h1>이 지역 내, 혹은 인근 예약 가능한 숙소 0개</h1></td>
							<td align="right"><a href="">지도로 보기</a></td>
						</tr>
					</table>
					<table border="1" width="100%">
				  		<tr>
							<td align="center">
								<h2>원하는 검색결과를 얻는 방법</h2><br>
								<h3>다음 옵션을 사용하여 원하는 숙소를 찾아보세요 :</h3>
							</td>
						</tr>
						<tr><td>좌측 검색창 사용</td></tr>
					</table>
		</c:when>
		<c:otherwise>
					<table border="0" width="100%">
						<tr>
							<td><h1>검색된 숙소</h1></td>
							<td align="right"><a href="">지도로 보기</a></td>
						</tr>
					</table>
					<table border="1" width="100%">
						<tr>
							<th width="15%">요금</th>
							<th width="20%">후기 평점</th>
							<th width="30%">후기 평점 + 요금</th>
							<th width="15%">성급</th>
							<th width="20%">성급 + 요금</th>
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
							<td width="50%"><a href="">${dto.city} - 지도에서 표시</a></td>
							<td width="25%" align="right" rowspan="2">
								<input type="button" value="요금 표시" onClick="location.href=''">
							</td>
						</tr>
						<tr><td width="50%">${dto.content}</td></tr>
						<tr>
							<td colspan="2" align="right">
								<input type="button" value="예약 가능 옵션 보기" onClick="location.href='search_accomodation_content.do?num=${dto.num}'">
								<input type="hidden" name="start_date" value="${start_date}" />
								<input type="hidden" name="end_date" value="${end_date}" />
							</td>
						</tr>
					</table>
			</c:forEach>
		</c:otherwise>
	</c:choose>
				</div>
			</td>
		</tr>
	</table>
	<script>
      var map;
      function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: -34.397, lng: 150.644},
          zoom: 8
        });
      }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD_7jiKyn69S94Q7zgR4IOgQ4-BJ4sL6B4&callback=initMap"
    async defer></script>
</body>
</html>