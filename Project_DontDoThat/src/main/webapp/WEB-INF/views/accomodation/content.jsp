<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../top.jsp" %>

<script type="text/javascript">

</script>
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
			<div class="col-lg-12"><input type="text"  name="end_date" autocomplete="off" value="${end_date }"></div>
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

	<div class="btn-group sortbar">
					  <button type="button" class="btn btn-primary" id="optionBtn">옵션 정보 & 요금</button>
					  <button type="button" class="btn btn-primary" id="facilityBtn">시설</button>
					  <button type="button" class="btn btn-primary" id="ruleBtn">하우스 룰</button>
					  <button type="button" class="btn btn-primary" id="infoBtn">중요 정보</button>
					  <button type="button" class="btn btn-primary" id="commentBtn">고객 후기</button>
	</div>
	<hr>
	<div class="panel panel-default">
 		 <div class="panel-body">
 		 	<div class="col-lg-9">
 		 		<h2><span class="badge">${getAccomodationInfo.category_accomodation}</span>${getAccomodationInfo.accomodation_name}</h2>
 		 	</div>
 		 	<div class="col-lg-3 now" style="text-align:right;">
 		 		<button type="button" class="btn btn-primary" id="optionBtn">지금 예약</button>
 		 	</div>
 		 </div>
	</div>
	<div class="panel panel-default">
  		<div class="panel-body">
	
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
		  <!-- Indicators -->
		
		  <!-- Wrapper for slides -->
		  <div class="carousel-inner" align="center">
		  	<c:forEach var="imgElement" items="${imgList}" varStatus="imgStatus">
		  		<c:if test="${imgStatus.count == 1}">
		  		<div class="item active">
		  		</c:if>
		  		<c:if test="${imgStatus.count != 1}">
		  		<div class="item">
		  		</c:if>
		      		<img src="${pageContext.request.contextPath}/resources/img/output/${imgElement}" style="width:100%; height:500px;">
		    	</div>
		  	</c:forEach>
		    
		    <!-- <ol class="carousel-indicators">
			    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			    <li data-target="#myCarousel" data-slide-to="1"></li>
			    <li data-target="#myCarousel" data-slide-to="2"></li>
			    <li data-target="#myCarousel" data-slide-to="3"></li>
			    <li data-target="#myCarousel" data-slide-to="4"></li>
			    <li data-target="#myCarousel" data-slide-to="5"></li>
		  	</ol> -->
		  </div>
		
		  <!-- Left and right controls -->
		  <a class="left carousel-control" href="#myCarousel" data-slide="prev">
		    <span class="glyphicon glyphicon-chevron-left"></span>
		    <span class="sr-only">Previous</span>
		  </a>
		  <a class="right carousel-control" href="#myCarousel" data-slide="next">
		    <span class="glyphicon glyphicon-chevron-right"></span>
		    <span class="sr-only">Next</span>
		  </a>
		</div>

		</div>
	</div>
	<hr>
	<div class="row">
	<div class="col-lg-8">
	${getAccomodationInfo.content}
When I find myself in times of trouble, Mother Mary comes to me
Speaking words of wisdom, let it be
And in my hour of darkness she is standing right in front of me
Speaking words of wisdom, let it be
Let it be, let it be, let it be, let it be
Whisper words of wisdom, let it be
And when the broken-hearted people living in the world agree
There will be an answer, let it be
For though they may be parted, there is still a chance that they will see
There will be an answer, let it be
Let it be, let it be, let it be, let it be
Yeah, there will be an answer, let it be
Let it be, let it be, let it be, let it be
Whisper words of wisdom, let it be
Let it be, let it be, let it be, yeah, let it be
Whisper words of wisdom, let it be
And when the night is cloudy there is still a light that shines on me
Shine until tomorrow, let it be
I wake up to the sound of music, Mother Mary comes to me
Speaking words of wisdom, let it be
Let it be, let it be, let it be, yeah, let it be
There will be an answer, let it be
Let it be, let it be, let it be, yeah, let it be
There will be an answer, let it be
Let it be, let it be, let it be, yeah, let it be
Whisper words of wisdom, let it be

	</div>
	<div class="col-lg-4">
		<div class="panel panel-default">
 		 <div class="panel-body">
 		 		<h1>투숙객이 좋아하나요?</h1>
 		 	<div class="col-lg-12">
 		 		<button type="button" class="btn btn-primary" style="width:100%; height:30px;" id="optionBtn">지금 예약</button>
 		 	</div>
 		 </div>
		 </div>
		 <div class="panel panel-default">
 		 	<div class="panel-body">
 		 		<h1>옵션에 포함된 사항</h1>
 		 		${getAccomodationInfo.accomodation_facility}
 		 	</div>
 		 </div>
	</div>
	</div>
	<div><hr></div>
	<div class="alert alert-success alert-dismissible fade in">
	  <a href="#" class="close" data-dismiss="alert" aria-label="close" style="text-decoration:none;">&times;</a>
	  <strong>팁: 융통성 있게 예약하기</strong><br/>
		출발일이 아직 멀었습니다. 일정 변경에도 안심할 수 있는 무료 취소를 선택하세요.
	</div>
	
	<div class="col-lg-12">
		<div id="option"><h2>예약 가능 여부</h2></div>
 		<table class="table table-bordered" data-spy="scroll" data-target=".tablecontent" data-offset="50" style="position: relative;">
    	<thead>
      	<tr>
        	<th>객실 유형</th>
        	<th>정원</th>
        	<th>요금</th>
        	<th>객실선택</th>
      	</tr>
    	</thead>
    	<tbody class="tablecontent">
    	<c:forEach var="roomElement" items="${getRoomList}">
      	<tr>
      		<td><a href="#">${roomElement.value.roomclass}</a></td>
      		<td>${roomElement.value.people}</td>
      		<td>${roomElement.value.price}</td>
      		<td>${roomElement.value.qty}
      		
      		</td>
      	</tr>
      	</c:forEach>
    	</tbody>
  		</table>
	</div>
	<span>&nbsp;<hr></span>
	
	
	<div class="col-lg-12">
		요금은 숙소 현지 통화(US$)로 결제 진행됩니다. 명시된 요금(기준 통화: KRW)은 예약 당시 환율로 계산한 것이며 편의를 목적으로 제공됩니다.
	</div>
	<br/>
	
	<span>&nbsp;<hr></span>
	
	<div class="col-lg-12">
	<h2>숙소 주변 시설</h2>
	<div>${getAccomodationInfo.nearby}</div>
	*모든 거리는 직선 거리 기준이며, 실제 이동 거리는 다를 수 있습니다.
	</div>
	
	<span>&nbsp;<hr></span>
	
	<div class="col-lg-12">
		<div id="facility"><h2>시설</h2></div>
		<h1>최고의 인기 시설</h1>
		<div class="panel panel-default">
 		 <div class="panel-body">
 		 	${getAccomodationInfo.accomodation_facility}
 		 </div>
 		</div>
	</div>
	
	<span>&nbsp;<hr></span>
	
	
	<div class="col-lg-12">
		<div id="rule"><h2>하우스 룰</h2></div>
		<div class="panel panel-default">
 		 <div class="panel-body">
 		 	${getAccomodationInfo.policy}
 		 </div>
 		</div>
	</div>

	<span>&nbsp;<hr></span>
	
	
	<div class="col-lg-12">
		<div id="info"><h2>중요 정보</h2></div>
		<div class="panel panel-default">
 		 <div class="panel-body">
 		 	만 18세 이상의 성인만 체크인하실 수 있습니다.<br/>
			모든 투숙객은 체크인 시 사진이 부착된 유효한 신분증과 신용카드를 제시하셔야 합니다. 
			모든 별도 요청 사항은 체크인 시 가능한 경우에 한해 제공되며, 추가 비용이 부과될 수도 있음을 안내드립니다.<br>
			예상 도착 시간을 미리 알려주십시오. 예약 시 별도 요청란에 기재하거나 예약 확인서에 기재된 숙소 연락처로 직접 연락하셔도 됩니다.
 		 </div>
 		</div>
	</div>
</div>
<span>&nbsp;<hr></span>
<div class="col-lg-12">
	<div id="aftercomment">
	<h3>이곳 최신 이용 후기</h3>
	<div class="panel panel-default">
 		 <div class="panel-body">
 		 	이용후기 자리
 		 </div>
	</div>
	</div>
</div>
	
	<script>
	function myMap() {
		var mapProp= {
		  center:new google.maps.LatLng(51.508742,-0.120850),
		  zoom:5,
		};
		var map = new google.maps.Map(document.getElementById("googleMap"),mapProp);
	}
	
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
	
	$(document).ready(function(){
	    $("#optionBtn").on("click",function(event){
	      var offset = $("#option").offset();
	      $("html, body").stop().animate({scrollTop:offset.top},1000);
	    });
	    $("#facilityBtn").on("click",function(event){
		      var offset = $("#facility").offset();
		      $("html, body").stop().animate({scrollTop:offset.top},1000);
		    });
	    $("#ruleBtn").on("click",function(event){
		      var offset = $("#rule").offset();
		      $("html, body").stop().animate({scrollTop:offset.top},1000);
		    });
	    $("#infoBtn").on("click",function(event){
		      var offset = $("#info").offset();
		      $("html, body").stop().animate({scrollTop:offset.top},1000);
		    });
	    $("#commentBtn").on("click",function(event){
		      var offset = $("#aftercomment").offset();
		      $("html, body").stop().animate({scrollTop:offset.top},1000);
		    });
	  }); // end of ready()
	</script>
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD_7jiKyn69S94Q7zgR4IOgQ4-BJ4sL6B4&callback=myMap"></script>
</body>
</html>