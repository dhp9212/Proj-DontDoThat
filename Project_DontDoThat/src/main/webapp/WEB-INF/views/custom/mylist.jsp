<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>
<style>
	 .my_button {
            display: inline-block;
            width: 150px;
            text-align: center;
            padding: 3px;
            background-color: #006BCC;
            color: #fff;
            text-decoration: none;
            border-radius: 3px;
        }
        
      .my_button1 {
            display: inline-block;
            width: 100px;
            text-align: center;
            padding: 3px;
            background-color: white;
            color: #0078D4;
            text-decoration: none;
            border: 1px solid #0078D4;
            border-radius: 3px;
            margin: 10px;
        }
        
        .my_button2 {
     	    background: url('<%=request.getContextPath()%>/resources/img/scroll_icon.png');
            display: inline-block;
            width: 130px;
            text-align: center;
            padding: 3px;
            background-color: white;
            color: #0078D4;
            text-decoration: none;
            border: 1px solid #0078D4;
            border-radius: 3px;
        }
        
       div #light{
		display: none;
		top: 25%;
		position: absolute;
		z-index: 1002;
		left: 25%;
		width: 20%;
		height: 10%;
		border: 1px solid #A8A8A8;
		background-color: white;
		overflow: auto;
		
	}	
	   th, td{
	   padding:0px;
	   }
</style>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
	function makeList(){
		 var userInput = prompt("리스트 이름");
		    alert("입력"+userInput);
	}
 	function popup(){
 		var obj = document.getElementById('light');
 		if(obj.style.display == '' || obj.style.display == 'none'){
 			var location = $(".my_button2").offset();
 			obj.style.display='block';
 			document.getElementById('fade').style.display='block';
 			obj.style.left = location.left-50+"px";
 			obj.style.top = location.top+50+"px";
 		}else{
 			obj.style.display='none';
 		}
	} 
</script>
<div>
	<table style="border-collapse:collapse;">
		<tr>
			<td bgcolor="white" height="60px" style="vertical-align:middle">
			<font size="4">마이리스트</font></td>
			<td bgcolor="white"><a href="javascript:popup()" class="my_button2">다음 행선지</a>		
				<div id="light">asdfssss</div>
				<div id="fade" class="fade"></div></td>
			<td bgcolor="white"><a href="#" class="my_button">리스트 공유하기</a></td>
			<td bgcolor="white"><a href="javascript:makeList()" class="my_button">새 리스트 만들기</a></td>
			<td bgcolor="white"></td>
		</tr>
	</table>
</div>
<div align="center">
	<table border="1" width="400px" height="300px">
		<tr>
			<td align="center">
			<img src="<%=request.getContextPath()%>/resources/img/heart_icon.png" width="60px"><br>
			<font size="5px" style="font-weight:bold">간단한 3단계로 고객님의 시작을 도와드립니다:</font><br>
			1. 투숙할 숙소 검색<br>
			2. 마음에 드는 숙소를 찾은 후, 검색창 상단의 '위시리스트에 추가' 버튼 클릭<br>
			3. 나중에 다시 볼 수 있도록 위시리스트에 호텔 저장<br>
			<a href="#" class="my_button1">검색하기</a>
			</td>
		</tr>
	</table>
</div>