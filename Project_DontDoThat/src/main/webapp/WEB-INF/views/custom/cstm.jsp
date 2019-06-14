﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../top.jsp" %>
<style>
	body {
	  height: 100vh;
	  margin: 0;
	  background: linear-gradient(#547BB3 40%, #EBF1FA 30%);
	}
	#f th, td
	{
	  margin: 0px;
	  padding: 0px;
	  background-color: white;
	}
	#f {
	  border-spacing: 0px 10px;
	  border-collapse: separate;
	}
	.font1{
	  font-size:20px;
	}
	.font2{
	  color:#6E6E6E;
	}
	.table > tbody > tr > td {
     vertical-align: middle;
	}
	
	[class^=arr-]{
	  border:       solid #0077CC;
	  border-width: 0 .3em .3em 0;
	  display:      inline-block;
	  padding:      .20em;
	  width: 0.3em;
	  height: 0.3em;
	  margin-top: 20px;
	}
/* .arr-right {transform:rotate(-45deg);  -webkit-transform:rotate(-45deg);}
.arr-left  {transform:rotate(135deg);  -webkit-transform:rotate(135deg);} */
.arr-up    {transform:rotate(-135deg); -webkit-transform:rotate(-135deg);}
.arr-down  {transform:rotate(45deg);   -webkit-transform:rotate(45deg);}
	
</style>
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
        	   $(".vv").hide();
        	   $('.' +$(this).attr('id')).hide();
        	   if($('#a_arrow').attr('class') == 'arr-down'){
					$('#a_arrow').attr('class', 'arr-up');
				}else{
					$('#a_arrow').attr('class', 'arr-down');
				}
               $("#a").toggle('500');
               $(".answer").siblings('div').hide();
               $(".answer").removeAttr('style');
               $('#cstmcate').val('ff');
           });
           $("span.b").click(function() {
        	   if($('#b_arrow').attr('class') == 'arr-down'){
					$('#b_arrow').attr('class', 'arr-up');
				}else{
					$('#b_arrow').attr('class', 'arr-down');
				}
        	   $("#b").toggle('500');
           });
           $("span.c").click(function() {
        	   if($('#c_arrow').attr('class') == 'arr-down'){
					$('#c_arrow').attr('class', 'arr-up');
				}else{
					$('#c_arrow').attr('class', 'arr-down');
				}
        	   $("#c").toggle('500');
           });
           $("span.d").click(function() {
        	   if($('#d_arrow').attr('class') == 'arr-down'){
					$('#d_arrow').attr('class', 'arr-up');
				}else{
					$('#d_arrow').attr('class', 'arr-down');
				}
        	   $("#d").toggle('500');
           });
           $('select[name=cstmcate]').change(function(){
        	   var ch = $("#cstmcate option:selected").val();
        	   $(".vv").hide();
        	   $("#"+ch).show();
           })
           
           $('.answer').click(function(){
        	   var h = $(this).attr('id');
        	   if($("#"+h).attr('style') == null){
        		   $("#"+h).attr('style', 'font-weight:bold');
        	   }else{
        		   $("#"+h).removeAttr('style')
        	   }
        	   $('.' +$(this).attr('id')).toggle();
           })
       });
   </script>
<p><p>
<div class="region" align="center" style="display:none;">
<div class="container" style="width:70%">
	<c:if test="${mbId != null}">
		<b>안녕하세요, ${mbId} 님!</b><br><br>
	</c:if>
	<font color="white"size="50" style="height:30; font-weight:bold;">무엇이든 물어보세요!</font><br>
	<font color="white" style="line-height:200%">도움이 필요하세요? 아래에서 선택해주세요</font><br>
	<table id="f" width="600px">
		<tr style="border: 1px solid #BDBDBD;">
			<td valign="top" align="right" style="border-left:1px solid #BDBDBD; border-top:1px solid #BDBDBD;border-bottom:1px solid #BDBDBD;">
				<img src='<%=request.getContextPath()%>/resources/img/icon1.png' width="60px" style="vertical-align:middle"></td>
			<td valign="top" style="border-top:1px solid #BDBDBD;border-bottom:1px solid #BDBDBD;"><span class="a">
				<font class="font1">정보찾기</font><br>
				<font class="font2">어떤 문제를 겪고 있는지 알려주세요. 문제 해결을 위한 최적의 방법을 알려드릴게요.</font></span>
			<br>
			<div id="a">
       		  <table style="margin-top:20px; margin-bottom:20px">
       		  	<tr><td align="center" style="border:1px solid #BDBDBD; background-color:#CCE1FF" width="650" height="50">
       		  		<select id="cstmcate" name="cstmcate" style="width:600; height:30; font-size:13pt;">
       		  			<option value="ff" style="font-size:13pt">우선 이 목록에서 도움이 필요한 사항을 선택해주세요</option>
       		  			<c:forEach var="dto" items="${maincate}">
						<option value="${dto}" style="font-size:13pt">${dto}</option>
						</c:forEach>
       		  		</select>
       		  	</td></tr>
       		  </table>
        	</div>
     			<c:forEach var="list" items="${lhm}">
	        		<div id="${list.key}" class="vv" style="display:none;">
		        		<table style="border:1px solid #BDBDBD;" width="650">
			       			<tr>
			       				<td style="padding:10px;"><font size="5"><b>${list.key}</b></font><br>
			       				자주 묻는 질문과 답변 한눈에 보기
			       				</td>
			       			</tr>
				        		<c:forEach var="dto" items="${list.value}">
		        			<tr>
		        				<td style="padding:10px; border-top:1px solid #D8D8D8;"><span id="${dto.no}" class="answer">${dto.subcate}</span><br>
		        				<div class="${dto.no}"style="display:none;"><br>${dto.answer}</div>
		        				</td>
		        			</tr>
				        		</c:forEach>
	        			</table>
	        		</div>
	        	</c:forEach>
        	</td>
        	<td valign="top" style="border-right:1px solid #BDBDBD; border-top:1px solid #BDBDBD;border-bottom:1px solid #BDBDBD;"><span class="a"><i id="a_arrow"class="arr-down"></i></span></td>
		</tr>
		<tr>
			<td valign="top" align="right" style="border-left:1px solid #BDBDBD; border-top:1px solid #BDBDBD;border-bottom:1px solid #BDBDBD;">
				<img src='<%=request.getContextPath()%>/resources/img/icon2.png' width="60px" style="vertical-align:middle">
			</td>
			<td valign="top" style="border-top:1px solid #BDBDBD;border-bottom:1px solid #BDBDBD;"><font class="font1">예약 관리하기</font><br>
				<font class="font2">온라인으로 쉽게 날짜를 변경하고 객실을 추가하거나 예약을 취소하실 수 있습니다.</font>
				<div id="moreRegion">
				</div>
				</td>
			<td valign="top" style="border-right:1px solid #BDBDBD; border-top:1px solid #BDBDBD;border-bottom:1px solid #BDBDBD;"><span class="b"><i id="b_arrow"class="arr-down"></i></span></td>
		</tr>
		<tr>
			<td valign="top" align="right" style="border-left:1px solid #BDBDBD; border-top:1px solid #BDBDBD;border-bottom:1px solid #BDBDBD;">
				<img src='<%=request.getContextPath()%>/resources/img/icon3.png' width="60px" style="vertical-align:middle">
			</td>
			<td valign="top" style="border-top:1px solid #BDBDBD;border-bottom:1px solid #BDBDBD;"><font class="font1">숙소에 문의하기</font><br>
				<font class="font2">숙박 관련 문의사항은 일반적으로 숙소 측에서 가장 정확하게 안내해드릴 수 있습니다.</font>></td>
			<td valign="top" style="border-right:1px solid #BDBDBD; border-top:1px solid #BDBDBD;border-bottom:1px solid #BDBDBD;"><span class="c"><i id="c_arrow"class="arr-down"></i></span></td>
		</tr>
		<tr>
			<td valign="top" align="right" style="border-left:1px solid #BDBDBD; border-top:1px solid #BDBDBD;border-bottom:1px solid #BDBDBD;">
				<img src='<%=request.getContextPath()%>/resources/img/icon4.png' width="60px" style="vertical-align:middle">
			</td>
			<td valign="top" style="border-top:1px solid #BDBDBD;border-bottom:1px solid #BDBDBD;"><span class="d">	
				<font class="font1">문의하기</font><br>
				<font class="font2">문의하기</font></span>
				<div id="d">
					급하지 않은 사안일 경우 메시지로 문의하시면 편리합니다
					<table border="1">
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
			<td valign="top" style="border-right:1px solid #BDBDBD; border-top:1px solid #BDBDBD;border-bottom:1px solid #BDBDBD;"><span class="d"><i id="d_arrow"class="arr-down"></i></span></td>
		</tr>
	</table>
</div>
</div>