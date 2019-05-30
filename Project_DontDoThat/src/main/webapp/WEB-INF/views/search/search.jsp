<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp" %>

<table width="100%">
<tr><th colspan="2">지역</th><td><div id="map"></div></td></tr>
<tr>
	<td width="30%;">
	<table border="2">
		<tr>
			<tr><th>검색</th>	</tr>
			<tr><td>여행지/숙소이름</td></tr>
			<tr><td><input type="text" value="${place}"></td></tr>
			<tr><td>체크인 날짜</td></tr>
			<tr><td><input type="text" value="${start_date}"></td></tr>
			<tr><td>체크아웃 날짜</td></tr>
			<tr><td><input type="text" value="${end_date}"></td></tr>
			<tr></tr>
			<tr><td><select>
						<option>1</option>
						<option>2</option>
						<option>3</option>
					</select></td></tr>
			<tr><td><input type="text"><input type="text"></td></tr>
			<tr><td><input type="button" value="검 색"></td></tr>
	</table>
	</td>
	<!-- datalist -->
	<td width="70%;"><table>
		<tr><th>검색된 숙소</th><th><div id="map"></div></tr>
		<tr><th>추천 숙소</th><th>요금</th><th>성급</th><th>거리</th><th>고평점 후기순</th></tr>
		<tr>
			<td><img src="#" style="width:100px; height:100px;"></td>
			<td>TEST HOTEL</td>
		</tr>
		<tr>
			<td><img src="#" style="width:100px; height:100px;"></td>
			<td>TEST HOTEL</td>
		</tr>
		<tr>
			<td><img src="#" style="width:100px; height:100px;"></td>
			<td>TEST HOTEL</td>
		</tr>
		<tr>
			<td><img src="#" style="width:100px; height:100px;"></td>
			<td>TEST HOTEL</td>
		</tr>
	</table></td>
</tr>
</table>

    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 50%;
      }
    </style>
  </head>  <body>

    <div id="map"></div>

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