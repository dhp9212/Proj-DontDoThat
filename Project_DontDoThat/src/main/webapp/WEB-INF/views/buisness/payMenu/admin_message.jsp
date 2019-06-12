<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../_buisness_top.jsp"%>
<style>
	 .my_button {
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
      .send_button {
           display: inline-block;
           width: 130px;
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
       .black_overlay{
	       display: none;
		   position: absolute;
		   top: 0%;
		   left: 0%;
		   width: 100%;
		   height: 100%;
		   background-color: black;
		   z-index:1001;
		   -moz-opacity: 0.8;
		   opacity:.80;
		   filter: alpha(opacity=80);
	   } 
	  .white_content {
		   display: none;
		   position: absolute;
		   top: 25%;
		   left: 25%;
		   width: 45%;
	       padding: 16px;
		   border: 1px solid #BDBDBD;
		   background-color: white;
		   z-index:1002;
	   }	
}
</style>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script type=text/javascript>
	$(document).ready(function(){
		 $('.myimage').hide();
		 $('.myss').hide();
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
	function popup(){
		var obj = document.getElementById('light');
		obj.style.display='block';
		document.getElementById('fade').style.display='block';
		obj.style.top = "100px";
	}
	function close(){
		document.getElementById('light').style.display='none';
		document.getElementById('fade').style.display='none';
		$('select[name=subject]').val('ff');
		$('select[name=subject_sub]').val('');
		$('.vf').hide();
	}
	function mypopup(cc){
		$('.mysubject').val($('td:contains('+cc+')').siblings().eq(0).text());
		$('.mycontent').val($.trim($('td:contains('+cc+')').siblings().eq(2).text()));
		var aa = $('td:contains('+cc+')').siblings().eq(1).text();
		var df = "${pageContext.request.contextPath}/resources/img/";
		var ss = $.trim($('td:contains('+cc+')').siblings().eq(4).text());
		var sc = $.trim($('td:contains('+cc+')').siblings().eq(6).text());
		if(ss || sc){
			$('.myimage').attr('src', df+ss);
			$('.myimage').show();
		}
 		if(aa){
			$('.mysubject_sub').val(aa);
			$('.myss').show();
		} 
 		$('.mynumber').val(cc);
		var obj = document.getElementById('mylight');
		obj.style.display='block';
		document.getElementById('myfade').style.display='block';
		obj.style.top = "100px";
	}
	function myclose(){
		document.getElementById('mylight').style.display='none';
		document.getElementById('myfade').style.display='none';
		$('.myimage').hide();
		$('.myss').hide();	
	}
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
	function deleteMessage(){
		document.f4.submit();
	}
</script>
<font size="5"><b>메시지 인박스</b></font><br><br>
<div style="float:left">
	<table style="padding:10px; border:1px solid #BDBDBD;" width="800px">
				<tr>
					<td width="20%"></td>
					<td align="center">모든 메시지</td>
					<td align="center">별표 메시지</td>
					<td align="center">답변한 메시지</td>
					<td width="20%"></td>
				</tr>
	</table>
	<br>
	<table style="padding:10px; border-collapse:collapse;" width="800px">
		<c:choose>
			<c:when test="${empty messagelist}">
				<tr>
					<td>메시지가 없습니다</td>
				</tr>
			</c:when>
			<c:when test="${not empty messagelist}">
				<tr>
					<td width="5%" >번호</td>
					<td width="20%">주제</td>
					<td width="10%">하위 주제</td>
					<td width="25%">내용</td>
					<td width="10%">작성자</td>
					<td width="15%">첨부파일</td>
					<td width="15%">작성일자</td>
				</tr>
				<c:forEach var="message_dto" items="${messagelist}">
				<tr style="border-top:1px solid #BDBDBD">
					<td>${message_dto.no}</td>
					<td>${message_dto.subject}</td>
					<td>${message_dto.subject_sub}</td>
					<td height="30px" style="overflow:hidden; text-overflow:ellipsis;
					 			display:inline-block;"><a href="javascript:mypopup('${message_dto.no}')">
					 				${message_dto.content}</a></td>
					<td>${message_dto.id}</td>
					<td>${message_dto.image}</td>
					<td>${message_dto.write_date}</td>
				</tr>
				</c:forEach>
			</c:when>
		</c:choose>
	</table>
</div>
<div style="float:right">
	<table width="400px" style="border-spacing:10px; line-height:30px; border:1px solid #BDBDBD;">
		<tr>
			<td align="center" style="border-bottom:1px solid #BDBDBD;"><b>원하는 해답을 찾지 못하셨나요?</b><br>
				메시지를 보내주시면 최대한 빨리 답변해드리겠습니다.<br>
				<a href="javascript:popup();" style="color:white" class="my_button">새 메시지 작성하기</a><br>
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
<div id="light" class="white_content">
	<form name="f3" action="write_admin_message.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="id" value="테스트">
	<input type="hidden" name="mbId" value="admin">
		<table style="border-collapse:collapse;" width="100%">
			<tr>
				<td style="border-bottom:1px solid #BDBDBD; padding-bottom:15px;">새로운 메시지</td>
				<td style="border-bottom:1px solid #BDBDBD"
						align="right"><a href="javascript:close()">Close</a></td>
			</tr>
		</table>
		<table>
			<tr>
				<td style="padding-top:15px;">주제<br>
					<select name="subject" style="width:555px;">
						<option value="ff" disabled>선택</option>
						<c:forEach var="sc_list" items="${sc_cate}">
							<option value="${sc_list}">${sc_list}</option>
						</c:forEach>		
					</select>
				</td>
			</tr>
		</table>
		<c:forEach var="scs" items="${sc}" varStatus="num">
			<div id="scs${num.index}" class="vf" style="display:none;">
				<table>
					<tr>
						<td>하위 주제<br>
							<select name="subject_sub" style="width:555px;">
								<option value="" disabled>선택</option>
								<c:forEach var="fff" items="${scs.value}">
									<option value="${fff}">${fff}</option>
								</c:forEach>	
							</select>
						</td>
					</tr>
				</table>
			</div>
		</c:forEach>
		<table width="100%">
			<tr>
				<td><textarea name="content" cols="66" rows="6"
							placeholder="여기에 메시지를 작성해주십시오"></textarea></td>
			</tr>
			<tr>
				<td>첨부파일:<br>
				<input type="file" name="image"></td>
			</tr>
			<tr>
				<td height="70px" align="right" valign="bottom"><a style="color:white;"
							class="send_button" href="javascript:sendMessage();">메시지 전송</a></td>
			</tr>
		</table>
	</form>
</div>
<div id="fade" class="black_overlay"></div>
<div id="mylight" class="white_content">
	<table style="border-collapse:collapse;" width="100%">
		<tr>
			<td style="border-bottom:1px solid #BDBDBD; padding-bottom:15px;">새로운 메시지</td>
			<td style="border-bottom:1px solid #BDBDBD"
					align="right"><a href="javascript:myclose()">Close</a></td>
		</tr>
	</table>
	<table style="padding:0px; border-collapse:collapse;" width="100%">
		<tr>
			<td>
				<table style="padding:0px; border-collapse:collapse;">
					<tr>
						<td>주제<br>
							<input type="text" class="mysubject" value="" size="66" readOnly>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<div class="myss" style="display:none;">
					<table style="padding:0px; border-collapse:collapse;">
						<tr>
							<td>하위주제<br>
								<input type="text" class="mysubject_sub" value="" size="66" readOnly>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
		<tr><td>
			<table style="padding:0px; border-collapse:collapse;">
				<tr>
					<td><img style="display:none;" width="450" class="myimage" src="">
					</td>
				</tr>
				<tr><td>
					<textarea class="mycontent" cols="66" rows="6" readOnly>
						</textarea></td>
				</tr>
				<tr>
					<td height="70px" align="right" valign="bottom"><a style="color:white;"
						class="send_button" href="javascript:sendMessage();">답변하기</a>
						<a style="color:white;" class="delete_button" 
								href="javascript:deleteMessage();">삭제하기</a>
						<form name="f4" action="delete_message.do" method="post">
							<input type="hidden" class="mynumber" name="no" value="">
						</form>
					</td>
				</tr>
			</table>
		</td></tr>
	</table>
</div>
<div id="myfade" class="black_overlay"></div>
<%@ include file="../_buisness_bottom.jsp"%>