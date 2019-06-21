<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_buisness_top.jsp"%>
<style>
 .mybutton {
           display: inline-block;
           width: 190px;
           text-align: center;
           line-height: 20px;
           padding: 8px;
           background-color: #0898FF;
           color: #fff;
           text-decoration: none;
           border-radius: 5px;
       }
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
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		 $('select[name=subject]').val('ff');
		 $('select[name=subject_sub]').val('');
		 $('select[name=subject]').change(function(){
	 	   var ch = $("select[name=subject] option:selected").val();
	 	   var s = '';
	     	   if(ch == '요금 & 객실 재고 현황')  s = "scs0";
	     	   else if (ch == '예약 관련(취소, 변경, 기타 질문 등)') s = "scs1";
	          else if (ch == '재무 관련(결제 및 청구서)') s = "scs2";   
	          else if (ch == '숙소 상세 정보') s = "scs3"; 
	      $('select[name=subject_sub]').val('');
	 	  $('.vf').hide();
	 	  $('#'+s).show();
	    });
	});
	function sendMessage(){
		if(f3.subject.value=="ff"){
			alert("주제를 선택해주세요!");
			return false;
		}
		if(f3.content.value==""){
			alert("내용을 입력해주세요!");
			return false;
		}
		document.f3.submit();
	}
	function writem(no, accomodation, email, content){
		c3.no.value = no;
		c3.accomodation.value = accomodation;
		c3.email.value = email;
		$('.user_M').text(content);
	}
	function writemPro(){
		if(c3.content.value == ""){
			alert("내용을 작성해주십시오.");
			return false;
		}
		document.c3.submit();
	}
</script>
<br>
<div class="row">
	<div class="col-lg-8">
	<table style="background-color:white">
			<tr>
				<td align="center">예약번호</td>
				<td align="center">숙소이름</td>
				<td align="center">이름</td>
				<td align="center">전화번호</td>
				<td align="center">이메일</td>
				<td align="center">내용</td>
				<td align="center">작성일자</td>
				<td align="center">답변여부</td>
			</tr>
		<c:if test="${not empty listCMessage}">
			<c:forEach var="dcc" items="${listCMessage}">
				<tr style="border-top:1px solid #BDBDBD;">
					<td align="center">${dcc.reservation}</td>
					<td align="center">${dcc.accomodation_name}</td>
					<td align="center">${dcc.name}</td>
					<td align="center">${dcc.tel}</td>
					<td align="center">${dcc.email}</td>
					<td width="200px" height="30px" style="overflow:hidden; text-overflow:ellipsis;
					 		display:inline-block;"><button type="button" onclick="javascript:writem('${dcc.no}','${dcc.accomodation_name}',
								 '${dcc.email}','${dcc.content}')"
					 		class="btn btn-sm" data-toggle="modal" data-target="#myContent">
							 ${dcc.content}</button></td>
					<td align="center">${dcc.send_date}</td>
					<td align="center">
						<c:choose>
							<c:when test="${dcc.check_reply == 1}">
								<div class="mybutton23">답변 완료</div>
							</c:when>
							<c:otherwise>
								<button type="button" onclick="javascript:writem('${dcc.no}','${dcc.accomodation_name}',
								 '${dcc.email}','${dcc.content}')"
								class="btn mybutton23 btn-sm" data-toggle="modal" data-target="#myModal">답변 하기</button>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty listCMessage}">
			<tr>
				<td colspan="8" align="center">메시지가 없습니다.</td>
			</tr>
		</c:if>
	</table>
		<form name="v9">
			<input type="hidden" name="reservation_num">
		</form>
	</div>
	<div class="col-lg-4">
	<table style="border-spacing:10px; line-height:30px; border:1px solid #BDBDBD;">
		<tr>
			<td align="center" style="border-bottom:1px solid #BDBDBD;"><b>원하는 해답을 찾지 못하셨나요?</b><br>
				메시지를 보내주시면 최대한 빨리 답변해드리겠습니다.<br>
				<button type="button" 
					 class="btn mybutton btn-sm" data-toggle="modal"
					 data-target="#myAdmin">
							새 메시지 작성하기
				</button>
			</td>
		</tr>
		<tr>
			<td align="center"><b>다른질문이 있으신가요?</b><br>
				지원팀으로 연락해주세요<br>
				<a href="#">+82 1042119934</a>
			</td>
		</tr>
	</table>
	</div>
</div>
<form name="f3" action="write_admin_message.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="mbId" value="admin">
<div id="myAdmin" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
      	 새로운 메시지
         <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        <div>
        	주제<br>
			<select name="subject">
				<option value="ff" disabled>선택</option>
				<c:forEach var="sc_list" items="${sc_cate}">
					<option value="${sc_list}">${sc_list}</option>
				</c:forEach>		
			</select>
        </div>
		<c:forEach var="scs" items="${sc}" varStatus="num">
			<div id="scs${num.index}" class="vf" style="display:none;">
				하위 주제<br>
				<select name="subject_sub">
					<option value='' disabled>선택</option>
					<c:forEach var="fff" items="${scs.value}">
						<option value="${fff}">${fff}</option>
					</c:forEach>	
				</select>
			</div>
		</c:forEach>
		<br>
		<textarea name="content" cols="60" rows="6"
							placeholder="여기에 메시지를 작성해주십시오"></textarea>
		<table style="border-collapse:collapse;">
			<tr>
				<td>첨부파일:<br>
				<input type="file" name="image"></td>
			</tr>
		</table>
      </div>
      <div class="modal-footer">
    	  <a href="javascript:sendMessage()" class="mybutton23">전송</a>
      </div>
    </div>

  </div>
</div>
</form>
<div id="myContent" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
      	 받은 메시지
         <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        <div class="user_M"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>
    </div>

  </div>
</div>
<form name="c3" action="write_user_message.do"method="post">
	<input type="hidden" name="no">
	<input type="hidden" name="accomodation">
	<input type="hidden" name="email">
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
     	 메시지 작성
         <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
       	<textarea name="content" cols="60" rows="7" placeholder="여기에 메시지를 작성해주십시오.&#13;&#10;작성한 내용은 상대방 메일로 자동전송됩니다."></textarea>
      </div>
      <div class="modal-footer">
      	<a href="javascript:writemPro()" class="mybutton23">전송</a>
      </div>
    </div>
  </div>
</div>
</form>
<%@ include file="../_buisness_bottom.jsp"%>