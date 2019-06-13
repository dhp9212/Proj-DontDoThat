<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp" %>
<div class="col-lg-4">
	<div class="panel panel-default sidesearch">
		<div class="panel-body">
			<div class="col-lg-12 searchlabel"><h1>내 예약 정보</h1></div>
			<div class="col-lg-12">체크인 :</div>
			<div class="col-lg-12">${start_date}</div>
			<div class="col-lg-12">체크아웃 :</div>
			<div class="col-lg-12">${end_date}</div>
			<div class="col-lg-12">총 숙박 기간 :</div>
			<div class="col-lg-12 days">1박</div>
		</div>
		<div class="panel-body">
			<div class="col-lg-12">선택 객실 :</div>
			<div class="col-lg-12">${getRoom.roomname}</div>
			<div class="col-lg-12"><a href="">다른 객실로 변경</a></div>
		</div>
		<div class="panel-body">
			<div class="col-lg-12 searchlabel"><h1>결제 요금 내역</h1></div>
			<div class="col-lg-6">${getRoom.roomclass}</div>
			<div class="col-lg-6" style="text-align:right;">${getRoom.price*selectQty}</div>
		</div>
		<div class="panel-body">
			<div class="col-lg-12">기타 요금</div>
			<div class="col-lg-12">도시세 (적용될 수 있으며, 조건에 따라 달라질 수 있음)</div>
		</div>
	</div>
</div>
<div class="col-lg-8">
	<div class="panel panel-default">
 		<div class="panel-body">
 			<div class="col-lg-9">
			<c:forEach var="imgElement" items="${imgList}" varStatus="imgStatus">
				<c:if test="${imgStatus.count == 1}">
		  		<div class="item active">
		  		</c:if>
		  		<c:if test="${imgStatus.count != 1}">
		  		<div class="item">
		  		</c:if>
		      		<img src="${pageContext.request.contextPath}/resources/img/output/${getRoom.room_image}" style="width:100%; height:500px;">
		    	</div>
		    </c:forEach>
 			</div>
 		</div>
 	</div>
	<div class="row">
		<form name="reservation" action="accomodation_reservation.do" method="post">
		<input type="hidden" name="account_num" value="${getAccount.num}" />
		<input type="hidden" name="accomodation_num" value="${accomodation_num}" />
		<input type="hidden" name="room_num" value="${getRoom.num}" />
		<input type="hidden" name="checkIn_date" value="${start_date}" />
		<input type="hidden" name="checkOut_date" value="${end_date}" />
		<div class="col-lg-12"><h2>상세 정보 입력</h2></div>
		<div class="col-lg-6">성(영문)</div>
		<div class="col-lg-6">이름(영문)</div>
		<div class="col-lg-6"><input type="text" name="last_name" class="box"></div>
		<div class="col-lg-6"><input type="text" name="first_name" class="box"></div>
		<div class="col-lg-12">이메일 주소</div>
		<div class="col-lg-8"><input type="text" name="email" class="box" value="${getAccount.email}"></div>
		<div class="col-lg-4">예약 확인서가 전송될 이메일 주소 입력</div>
		<div class="col-lg-12">국가/지역</div>
		<div class="col-lg-8">
			<select name="country" id="country">
				<option value="default">-- --국가/지역 선택-- --</option>
			<c:forEach var="country" items="${countryList}">
				<option>${country.name}</option>
			</c:forEach>
			</select>
		</div>
		<div class="col-lg-12">전화번호 (가능한 경우 휴대폰)</div>
		<div class="col-lg-6">
			<input type="text" name="tel" id="tel" class="box" maxlength="13" value="${getAccount.tel}">
		</div>
		<div class="col-lg-12">
			<div class="col-lg-6">${getRoom.roomname}</div>
			<div class="col-lg-6" style="text-align:right;">${getRoom.price}</div>
			<div class="col-lg-12">이용 후기</div>
			<div class="col-lg-12">최대 투숙 인원 : ${getRoom.people}명</div>
		</div>
		<div class="col-lg-2" style="text-align:right;">
			<button type="button" class="btn btn-primary" style="width:100%; height:30px;" id="optionBtn" onClick="javascript:check();">예약 완료</button>
		</div>
		</form>
	</div>
</div>
	<script type="text/javascript">
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
	    	$('.col-lg-12.days').text(difDay + '박')
	    	
	    })
	})
	function check() {
		var session = '${userSession}'
		if (session == '') {
			alert("예약하시기 전에 로그인해주세요")
		}
		else {
			var emailValidation = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
			var telValidation = /^[0-9_\.\-]+-[0-9\-]+\-[0-9\-]+/;
			if (reservation.last_name.value == '') {
				alert("성(영문)을 입력해주세요")
				reservation.last_name.focus()
				return false
			}
			if (emailValidation.test(reservation.email.value) == false) {
				if (reservation.email.value == '') {
					alert("이메일 주소를 입력해주세요")
				} else {
					alert("유효한 이메일 주소를 입력해주세요")
				}
				reservation.email.focus()
				return false
			}
			if (reservation.country.value == 'default') {
				alert("국가/지역을 선택해주세요")
				reservation.country.focus()
				return false
			}
			if (telValidation.test(reservation.tel.value) == false) {
				if (reservation.tel.value == '') {
					alert("전화번호를 입력해주세요")
				} else {
					alert("유효한 전화번호를 입력해주세요")
				}
				reservation.tel.focus()
				return false
			}
			document.reservation.submit();
			alert("예약에 성공하였습니다")
			return true
		}
	}
	function autoHypenTel(str) {
        str = str.replace(/[^0-9]/g, '');
        var tmp = '';
        if (str.length < 4) {
            return str;
        } else if (str.length < 7) {
            tmp += str.substr(0, 3);
            tmp += '-';
            tmp += str.substr(3);
            return tmp;
        } else if (str.length < 11) {
            tmp += str.substr(0, 3);
            tmp += '-';
            tmp += str.substr(3, 3);
            tmp += '-';
            tmp += str.substr(6);
            return tmp;
        } else {              
            tmp += str.substr(0, 3);
            tmp += '-';
            tmp += str.substr(3, 4);
            tmp += '-';
            tmp += str.substr(7);
            return tmp;
        }
        return str;
    }
	var tel = document.getElementById('tel');
	tel.onkeyup = function(event) {
	    event = event || window.event;
	    var _val = this.value.trim();
	    this.value = autoHypenTel(_val);
	}
	var country = '${getAccount.country}'
	$(function() {
		if (country != '') {
			$('#country').val(country).prop('selected', true);
		}
	});
	</script>
</body>
</html>