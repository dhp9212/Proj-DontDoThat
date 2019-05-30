<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../top.jsp" %>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
   <script type="text/javascript">
       $(document).ready(function() {
    	   $(".region").show();
           $("#a").hide();
           $("#b").hide();
           $("#c").hide();
           $("#d").hide();
           $("span.a").click(function() {
               $("#a").toggle('3000');
           });
           $("span.b").click(function() {
        	   $("#b").toggle('3000');
           });
           $("span.c").click(function() {
        	   $("#c").toggle('3000');
           });
           $("span.d").click(function() {
        	   $("#d").toggle('3000');
           });
       });
   </script>
<div class="region" align="center" style="display:none;" width="90%">
	<c:if test="${mbId != null}">
		<b>안녕하세요, ${mbId} 님!</b>
	</c:if>
	<h2>무엇이든 물어보세요!</h2>
	도움이 필요하세요? 아래에서 선택해주세요
	<table border="1" cellspacing="10px">
		<tr>
			<td><span class="a">정보 찾기</span><br>
				어떤 문제를 겪고 있는지 알려주세요. 문제 해결을 위한 최적의 방법을 알려드릴게요.
			<div id="a">
       		  <table>
       		  	<tr><td align="center">
       		  		<select name="cstmcate">
						<option value="">우선 이 목록에서 도움이 필요한 사항을 선택해주세요</option>
						<option value="">취소</option>
						<option value="">결제</option>
						<option value="">예약 상세 정보</option>
						<option value="">커뮤니케이션</option>
						<option value="">객실 유형</option>
						<option value="">요금</option>
						<option value="">신용카드</option>
       		  		</select>
       		  	</td></tr>
       		  </table>
        	</div>
         </td>
		</tr>
		<tr>
			<td><h3>예약 관리하기</h3><br>
				온라인으로 쉽게 날짜를 변경하고 객실을 추가하거나 예약을 취소하실 수 있습니다.
				<div id="moreRegion">
				</div>
				</td>
		</tr>
		<tr>
			<td><h3>숙소에 문의하기</h3><br>
				숙박 관련 문의사항은 일반적으로 숙소 측에서 가장 정확하게 안내해드릴 수 있습니다.</td>
		</tr>
		<tr>
			<td><span class="d">문의하기</span><br>
				문의하기
				<div id="d">
					급하지 않은 사안일 경우 메시지로 문의하시면 편리합니다
					<table border="1" cellspacing="10px">
						<tr>
							<td colspan="2"><b>참고</b><br>
							자주 묻는 질문에 대한 답변은 셀프 서비스 도구를 이용해 더 빠르고 쉽게 찾아보실 수 있습니다.
							그 뒤에도 궁금한 점이 남아있는 경우 언제든 저희 고객 서비스 팀에게 문의해주시기 바랍니다.
							</td>
						</tr>
						<tr>
							<td><input type="text" value="예약 번호(권장)"></td>
							<td><input type="text" value="PIN 코드"></td>
						</tr>
						<tr>
							<td><input type="text" value="이름"></td>
							<td><input type="text" value="이메일"></td>
						</tr>
						<tr>
							<td colspan="2"><input type="text" value="전화번호(선택)"></td>
						</tr>
						<tr>
							<td><textarea rows="8" cols="50" class="box">메시지를 입력하세요. 정보가 자세할수록 답변이 빠릅니다!</textarea>
						</tr>
					</table>
					<input type="submit" value="전송">
				</div>
			</td>
		</tr>
	</table>
</div>