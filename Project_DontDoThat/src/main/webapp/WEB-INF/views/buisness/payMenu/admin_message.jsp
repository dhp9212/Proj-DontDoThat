<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../_buisness_top.jsp"%>
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
       .delete_button {
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
}
</style>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script type=text/javascript>
	function mypopup(subject, subject_sub, content, image){
		var url = "<%=request.getContextPath()%>/resources/img/";
		v3.mysubject.value = subject;
		if(subject_sub == ''){
			subject_sub = "없음";
		}
		v3.mysubject_sub.value = subject_sub;
		v3.mycontent.value = content;
		if(image != ''){
			$('.myimage').attr('src', url+no);
			$('.myimage').show();
			}
		}
	function mywrite5(no, id){
		cc.rno.value = no;
		cc.remail.value = id;
	}
	function sendMessage(){
		if(cc.myreply.value==""){
			alert("내용을 입력해주세요!");
			return false;
		}
		document.cc.submit();
	}
</script>
<font size="5"><b>메시지 인박스</b></font><br><br>
<div class="container">
	<table style="padding:10px; border-collapse:collapse;">
		<c:choose>
			<c:when test="${empty messagelist}">
				<tr>
					<td>메시지가 없습니다</td>
				</tr>
			</c:when>
			<c:when test="${not empty messagelist}">
				<tr>
					<td align="center">번호</td>
					<td align="center">주제</td>
					<td align="center">내용</td>
					<td align="center">작성자</td>
					<td align="center">첨부파일</td>
					<td align="center">작성일자</td>
					<td align="center">답변여부</td>
				</tr>
				<c:forEach var="message_dto" items="${messagelist}">
				<tr style="border-top:1px solid #BDBDBD">
					<td align="center">${message_dto.no}</td>
					<td>${message_dto.subject}
						<c:if test="${not empty message_dto.subject_sub}">
							<br>> ${message_dto.subject_sub}
						</c:if>
					</td>
					<td height="30px" style="overflow:hidden; text-overflow:ellipsis; display:inline-block;">
					 	<button type="button" class="btn btn-sm"
					 		onclick="javascript:mypopup('${message_dto.subject}',
					 			'${message_dto.subject_sub}',
					 			'${message_dto.content}', '${message_dto.image}')"
					 		data-toggle="modal" data-target="#myCont">
							 ${message_dto.content}</button></td>
					<td align="center">${message_dto.id}</td>
					<td align="center">${message_dto.image}</td>
					<td align="center">${message_dto.write_date}</td>
					<td align="center">
						<c:choose>
							<c:when test="${message_dto.reply == 1}">
								<div class="mybutton23">답변완료</div>
							</c:when>
							<c:otherwise>
								<button type="button" onclick="javascript:mywrite5('${message_dto.no}', '${message_dto.id}')" class="btn mybutton23 btn-sm"
								data-toggle="modal" data-target="#myConte">답변하기</button>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				</c:forEach>
			</c:when>
		</c:choose>
	</table>
</div>
<form name="v3">
	<div id="myCont" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header">
	      	 받은메시지
	         <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	      <div class="modal-body">
	          주제<br>
			<input type="text" name="mysubject" value="" style="width:450;" readOnly><br>
			하위주제<br>
			<input type="text" name="mysubject_sub" value="" style="width:450;" readOnly><br>
			<img style="display:none;" class="myimage" src=""><br>
			<textarea name="mycontent" cols="60" rows="6" readOnly></textarea>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
</form>
<form name="cc" action="reply_admin_message.do" method="post">
<div>
	<div id="myConte" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header">
	      	 새로운 메시지
	         <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	      <div class="modal-body">
			<textarea name="myreply" cols="60" rows="6" placeholder="여기에 메시지를 작성해주십시오.&#13;&#10;작성한 내용은 상대방 메일로 자동전송됩니다."></textarea>
	      </div>
	      <div class="modal-footer">
	         <a href="javascript:sendMessage()" class="mybutton23">전송</a>
	      </div>
	    </div>
	  </div>
	</div>
</div>
	<input type="hidden" name="rno">
	<input type="hidden" name="remail">
</form>
<%@ include file="../_buisness_bottom.jsp"%>