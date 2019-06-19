<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<style> 
  .starR1{
    background: url('<%=request.getContextPath()%>/resources/img/star1.png') no-repeat -50px 0;
    background-size: auto 100%;
    width: 15px;
    height: 30px;
    float:left;
    text-indent: -9999px;
    cursor: pointer;
 }   
   .starR2{
    background: url('<%=request.getContextPath()%>/resources/img/star2.png') no-repeat right 0;
    background-size: auto 100%;
    width: 15px;
    height: 30px;
    float:left;
    text-indent: -9999px;
    cursor: pointer;
 }  

   .starR1.on{
  	background-position:0 0;
  }
  
   .starR2.on{
  	background-position:-14 0;
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
	<script>
		function writeReview(){
			if(f.subject.value==""){
				alert("제목을 입력해주세요!");
				return false;
			}
			if(f.content_p.value=="" || f.content_m.value==""){
				alert("내용을 입력해주세요!");
				return false;
			}
			if(f.myimage.value==""){
				alert("사진을 넣어주세요!")
				return false;
			}
			if(f.clean.value=="" || f.comfortable.value=="" || f.location.value=="" ||
					f.facilities.value=="" ||f.kind.value=="" ||f.value.value=="" ||
					f.wifi.value=="" ||f.clean.value==""){
				alert("평점이 정확하게 입력되지 않았습니다.");
				return false;
			}
			document.f.submit();
		}
	$(document).ready(function(){
		$('.starRev_1 span').click(function(){
			  $(this).parent().children('span').removeClass('on');
			  $(this).addClass('on').prevAll('span').addClass('on');
			  $('.star_1').text($(this).text());
			  var clean = $('.star_1').text();
			  $('input#clean').val(clean*2);
			  return false;
			}); 
		$('.starRev_2 span').click(function(){
			  $(this).parent().children('span').removeClass('on');
			  $(this).addClass('on').prevAll('span').addClass('on');
			  $('.star_2').text($(this).text());
			  var comfortable = $('.star_2').text();
			  $('input#comfortable').val(comfortable*2);
			  return false;
			}); 
		$('.starRev_3 span').click(function(){
			  $(this).parent().children('span').removeClass('on');
			  $(this).addClass('on').prevAll('span').addClass('on');
			  $('.star_3').text($(this).text());
			  var location = $('.star_3').text();
			  $('input#location').val(location*2);
			  return false;
			}); 
		$('.starRev_4 span').click(function(){
			  $(this).parent().children('span').removeClass('on');
			  $(this).addClass('on').prevAll('span').addClass('on');
			  $('.star_4').text($(this).text());
			  var facilities = $('.star_4').text();
			  $('input#facilities').val(facilities*2);
			  return false;
			}); 
		$('.starRev_5 span').click(function(){
			  $(this).parent().children('span').removeClass('on');
			  $(this).addClass('on').prevAll('span').addClass('on');
			  $('.star_5').text($(this).text());
			  var kind = $('.star_5').text();
			  $('input#kind').val(kind*2);
			  return false;
			}); 
		$('.starRev_6 span').click(function(){
			  $(this).parent().children('span').removeClass('on');
			  $(this).addClass('on').prevAll('span').addClass('on');
			  $('.star_6').text($(this).text());
			  var value = $('.star_6').text();
			  $('input#value').val(value*2);
			  return false;
			}); 
		$('.starRev_7 span').click(function(){
			  $(this).parent().children('span').removeClass('on');
			  $(this).addClass('on').prevAll('span').addClass('on');
			  $('.star_7').text($(this).text());
			  var wifi = $('.star_7').text();
			  $('input#wifi').val(wifi*2);
			  return false;
			}); 
	});
	</script>
<div align="center">
	<form name="f" action="reviewWritePro.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="reservation_num" value="${param.reservation_num}">
		<input type="hidden" name="accommodation" value="${param.accomodation_num}">
		<input type="hidden" name="lodge_date" value="${param.lodge_date}">
		<table style="border:1px solid #BDBDBD;" width="500">
			<tr bgcolor="#003580">
				<td colspan="2" align="center"><font color="white">이용후기 작성</font></td>
			</tr>
			<tr>
				<th bgcolor="#003580" width="20%"><font color="white">제목</font></th>
				<td><input type="text" name="subject" size="50" class="box"></td>
			</tr>
			<tr>
				<th bgcolor="#003580" width="20%"><font color="white">내용+</font></th>
				<td><textarea name="content_p" rows="8" cols="50" class="box"></textarea></td>
			</tr>
			<tr>
				<th bgcolor="#003580" width="20%"><font color="white">내용-</font></th>
				<td><textarea name="content_m" rows="8" cols="50" class="box"></textarea></td>
			</tr>
			<tr>
				<th bgcolor="#003580" width="20%"><font color="white">사진 첨부</font></th>
				<td><input type="file" name="myimage" multiple></td>
			</tr>
		</table>
<% String sort[] = new String[]{"청결도", "편안함", "위치", "시설", "직원 친절도", "가성비", "무료 Wi-Fi"};
	pageContext.setAttribute("sort", sort);%>
		<input type="hidden" id="clean" name="clean">
		<input type="hidden" id="comfortable" name="comfortable">
		<input type="hidden" id="location" name="location">
		<input type="hidden" id="facilities" name="facilities">
		<input type="hidden" id="kind" name="kind">
		<input type="hidden" id="value" name="value">
		<input type="hidden" id="wifi" name="wifi">		
<table border="1" width="500">
	<c:forEach var="item" varStatus="num" items="${sort}">		
		<tr>
		<td>${item}</td>
		<td>
			<div class="starRev_${num.count}">
				  <span class=starR1 id="starR1">0.5</span>
				  <span class=starR2 id="starR2">1</span>
				  <span class=starR1 id="starR1">1.5</span>
				  <span class=starR2 id="starR2">2</span>
				  <span class=starR1 id="starR1">2.5</span>
				  <span class=starR2 id="starR2">3</span>
				  <span class=starR1 id="starR1">3.5</span>
				  <span class=starR2 id="starR2">4</span>
				  <span class=starR1 id="starR1">4.5</span>
				  <span class=starR2 id="starR2">5</span>
			</div>
		</td>
		<td width="50">
			<b class="star_${num.count}">0</b>점
		</td></tr>
	</c:forEach>	
</table>
	<br>
	<div class="col-lg-12" align="right">
		<a href="javascript:writeReview();" class="mybutton23">전송</a>
	</div>
</form>
</div>