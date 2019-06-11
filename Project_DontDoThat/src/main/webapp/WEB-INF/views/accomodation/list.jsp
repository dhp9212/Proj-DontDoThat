<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../top.jsp" %>
<br/>

	<div class="col-lg-10"><h4>${input_place}</h4></div>
	<div id="googleMap" style="text-align:right; border-radius:6px; width:100px;height:40px;"></div>

<br/>
<div class="col-lg-4">
	<div class="panel panel-default sidesearch">
		<div class="panel-body">
			<div class="col-lg-12 searchlabel"><h1>검색</h1></div>
			<form name="search_form" method="post" action="accomodation_list.do">
			<div class="col-lg-12">여행지/숙소 이름</div>
			<div class="col-lg-12"><input type="text" id="input_place" name="input_place" autocomplete="off" value="${input_place}"></div>
			<div class="col-lg-12">체크인 날짜</div>
			<div class="col-lg-12"><input type="text" name="start_date" autocomplete="off" value="${start_date }"></div>
			<div class="col-lg-12">체크아웃 날짜</div>
			<div class="col-lg-12"><input type="text" name="end_date" autocomplete="off" value="${end_date }"></div>
			<div class="col-lg-12 days">1박 선택</div>
			<div class="col-lg-12">
				<select name="adult">
				<option value="1">성인 1명</option>
				<option value="2">성인 2명</option>
				<option value="3">성인 3명</option>
				<option value="4">성인 4명</option>
				<option value="5">성인 5명</option>
				<option value="6">성인 6명</option>
				<option value="7">성인 7명</option>
				<option value="8">성인 8명</option>
				<option value="9">성인 9명</option>
				<option value="10">성인 10명</option>
				</select>
			</div>
			<div class="col-lg-12">&nbsp;</div>
			<div class="col-lg-6">
				<select name="child">
				<option value="0">동반아동 없음</option>
				<option value="1">아동 1명</option>
				<option value="2">아동 2명</option>
				<option value="3">아동 3명</option>
				<option value="4">아동 4명</option>
				<option value="5">아동 5명</option>
				<option value="6">아동 6명</option>
				<option value="7">아동 7명</option>
				<option value="8">아동 8명</option>
				<option value="9">아동 9명</option>
				<option value="10">아동 10명</option>
				</select>
			</div>
			<div class="col-lg-6">
				<select name="room">
				<option value="1">객실 1개</option>
				<option value="2">객실 2개</option>
				<option value="3">객실 3개</option>
				<option value="4">객실 4개</option>
				<option value="5">객실 5개</option>
				<option value="6">객실 6개</option>
				<option value="7">객실 7개</option>
				<option value="8">객실 8개</option>
				<option value="9">객실 9개</option>
				<option value="10">객실 10개</option>
				</select>
			</div>
			<div class="col-lg-12">&nbsp;</div>
			<div class="col-lg-12"><input type="button" value="검색" style="width:100%; height:50px;" onclick="javascript:search_form.submit()"></div>
			</form>
		</div>
	</div>
</div>
<div class="col-lg-8">
		
		<div>
			<h1>검색된 숙소 ${listCount}개</h1>
		</div>
	<div class="btn-group sortbar">
					  <button type="button" class="btn btn-primary" id="selected">요금</button>
					  <button type="button" class="btn btn-primary">후기 평점</button>
					  <button type="button" class="btn btn-primary">후기 평점 + 요금</button>
					  <button type="button" class="btn btn-primary">성급</button>
					  <button type="button" class="btn btn-primary">성급 + 요금</button>
					</div>
					<br/>
			<c:forEach var="dto" items="${listAccomodation}">
					<div class="panel panel-default">
					  <div class="panel-body itemspanel">
					  	<div class="col-lg-4">
					  		<a href="search_accomodation_content.do?num=${dto.num}">
					  			<img src="${pageContext.request.contextPath}/resources/img/accomodation/${dto.image}">
					  			${dto.image}
					  		</a>
					  	</div>
					  	<div class="col-lg-8">
					  		<div class="row">
							  	<div class="col-lg-8">
								  	<a href="search_accomodation_content.do?num=${dto.num}">
								  		<h3>[${dto.category_accomodation}]${dto.accomodation_name}</h3>
								  	</a>
							  	</div>
							  	<div class="col-lg-4">
							  		이용 후기 평점 넣어야됨
							  	</div>
						  	</div>
						  	<div class="row">
						  		<a href="">${dto.city} - 지도에서 표시</a>
						  	</div>
						  	<div class="row details">
						  		<div class="col-lg-4">
								  	<a href="search_accomodation_content.do?num=${dto.num}">
								  		방 옵션 수량 나와야됨
								  	</a>
							  	</div>
							  	<div class="col-lg-8 cost">
							  		금액 나와야됨
							  	</div>
						  	</div>
						  	<div class="lastline">
						  		 <button type="button" class="btn btn-primary">예약 가능 옵션 보기 ></button>
						  	</div>
					  	</div>
					  </div>
					</div>
			</c:forEach>
	<div>
	<c:if test="${listCount > 0}">
		<c:if test="${startPage > pageBlock}">
			<a href="accomodation_list.do?input_place=${input_place}&start_date=${start_date}&end_date=${end_date}&pageNum=${startPage - 1}" title="이전 페이지"><</a>
		</c:if>
		<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<a href="accomodation_list.do?input_place=${input_place}&start_date=${start_date}&end_date=${end_date}&pageNum=${i}"><c:out value="${i}" /></a>
		</c:forEach>
		<c:if test="${endPage < pageCount}">
			<a href="accomodation_list.do?input_place=${input_place}&start_date=${start_date}&end_date=${end_date}&pageNum=${startPage + pageBlock}" title="다음 페이지">></a>
		</c:if>
	</div>
	<div align="right">페이지 ${startRow} - ${endRow}</div>
	</c:if>
</div>
<%-- 

<table width="100%">

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
							<td align="right"><div id="googleMap" style="text-align:right; border-radius:6px; width:100px;height:40px;"></div></td>
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
							<td><h1>검색된 숙소 ${fn:length(listAccomodation)}개</h1></td>
							<td align="right"><div id="googleMap" style="text-align:right; border-radius:6px; width:100px;height:40px;"></div></td>
						</tr>
					</table>
					
					<div class="btn-group sortbar">
					  <button type="button" class="btn btn-primary" id="selected">요금</button>
					  <button type="button" class="btn btn-primary">후기 평점</button>
					  <button type="button" class="btn btn-primary">후기 평점 + 요금</button>
					  <button type="button" class="btn btn-primary">성급</button>
					  <button type="button" class="btn btn-primary">성급 + 요금</button>
					</div>
					<br/>
			<c:forEach var="dto" items="${listAccomodation}">
					<div class="panel panel-default">
					  <div class="panel-body itemspanel">
					  	<div class="col-lg-4">
					  		<a href="search_accomodation_content.do?num=${dto.num}">
					  			<img src="${pageContext.request.contextPath}/resources/img/accomodation/${dto.image}">
					  		</a>
					  	</div>
					  	<div class="col-lg-8">
					  		<div class="row">
							  	<div class="col-lg-8">
								  	<a href="search_accomodation_content.do?num=${dto.num}">
								  		<h3>[${dto.category_accomodation}]${dto.accomodation_name}</h3>
								  	</a>
							  	</div>
							  	<div class="col-lg-4">
							  		이용 후기 평점 넣어야됨
							  	</div>
						  	</div>
						  	<div class="row">
						  		<a href="">${dto.city} - 지도에서 표시</a>
						  	</div>
						  	<div class="row details">
						  		<div class="col-lg-4">
								  	<a href="search_accomodation_content.do?num=${dto.num}">
								  		방 옵션 수량 나와야됨
								  	</a>
							  	</div>
							  	<div class="col-lg-8 cost">
							  		금액 나와야됨
							  	</div>
						  	</div>
						  	<div class="lastline">
						  		 <button type="button" class="btn btn-primary">예약 가능 옵션 보기 ></button>
						  	</div>
					  	</div>
					  </div>
					</div>
			</c:forEach>
		</c:otherwise>
	</c:choose>
				</div>
			</td>
		</tr>
	</table> --%>
	
	<script>
	function myMap() {
		var mapProp= {
		  center:new google.maps.LatLng(51.508742,-0.120850),
		  zoom:5,
		};
		var map = new google.maps.Map(document.getElementById("googleMap"),mapProp);
	}
	
	function resetSelected(){
		$('.sortbar .btn').attr('id', '')
	}
	
	$('.sortbar > .btn').click(function setSelected(){
		resetSelected();
		$( this ).attr('id', 'selected')
	});
	
	
	$(function() {
	    var $startDate = $('input[name="start_date"]');
	    var $endDate = $('input[name="end_date"]');
	    $startDate.datepicker({
	      autoHide: true,
	      startDate : new Date(this.date)
	    });
	    $endDate.datepicker({
	      autoHide: true,
	      startDate: $startDate.datepicker('getDate'),
	    });

	    $startDate.on('change', function () {
	  	  
	      $endDate.datepicker('setStartDate', $startDate.datepicker('getDate'));
	    });
	  
	});
	
	$(function(){
		var $startDate = $('input[name="start_date"]');
	    var $endDate = $('input[name="end_date"]');
	    
	    $startDate.on('change', function(){
	    	$endDate.focus();
	    })
	})
	
	$(function(){
		var $startDate = $('input[name="start_date"]');
	    var $endDate = $('input[name="end_date"]');
	    
	   
	    
	    $endDate.on('change', function(){
	    	var startDateArr = $startDate.val().split('/')
	 	    var endDateArr = $endDate.val().split('/')
	 	    
	 	    var startDateSet = new Date(startDateArr[0], startDateArr[1], startDateArr[2])
	 	    var endDateSet = new Date(endDateArr[0], endDateArr[1], endDateArr[2])
	
	 	    var dif = endDateSet - startDateSet
	 	    var day = 1000*60*60*24
	 	    
	 	    var difDay = parseInt(dif/day)
	    	$('.col-lg-12.days').text(difDay + '박 선택')
	    	
	    })
	})

	
	$(function(){
		$('#input_place').autoComplete({
            minChars: 1,
            source: function(term, suggest){
            	var str = new Array();
            	<c:forEach var="country" items="${countryList}">
				str += '${country.name}' + '/'
            	</c:forEach>     	
                term = term.toLowerCase();
                var choices = str.split("/");
                var suggestions = [];
                
                for (i=0;i<choices.length;i++)
                    if (~choices[i].toLowerCase().indexOf(term)) suggestions.push(choices[i]);
                suggest(suggestions);
            }
        });
	});
	
	</script>
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD_7jiKyn69S94Q7zgR4IOgQ4-BJ4sL6B4&callback=myMap"></script>
</body>
</html>