<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_buisness_top.jsp"%>
<style>
	 .my_button {
	          display: inline-block;
	          width: 190px;
	          text-align: center;
	          padding: 8px;
	          background-color: #0898FF;
	          color: #fff;
	          text-decoration: none;
	          border-radius: 5px;
	      }
</style>
<font size=4><b>재무 개요</b></font>
<table width="100%" style="border:1px solid #BDBDBD">
	<caption><font size="5">월간 매출 리포트</font></caption>
	<tr>
		<td>이 기능을 사용하기 위한 정보가 아직 부족합니다. 다음에 다시 시도해주십시오.</td>
	</tr>
</table>
<table width="100%" style="border:1px solid #BDBDBD; padding:5px;">
	<caption><font size="5">월간 매출 리포트</font></caption>
	<tr>
		<td><img src="<%=request.getContextPath()%>/resources/img/financial_icon1.png"></td>
		<td>현재 결제 방법:<br>
		<font size="4"><b>계좌이체</b></font></td>
	</tr>
	<tr>
		<td><img src="<%=request.getContextPath()%>/resources/img/financial_icon2.png"></td>
		<td>본 사이트 계좌정보:<br><br>

			농협은행(은행코드: 011)<br> 
			코세아 인재개발원 4층<br>
			서울특별시 송파구 올림픽로35길 104 장미 C상가<br><br>
			
			NongHyup Bank (Local Bank Code: 011)<br> 
			Kosea<br>
			104, Olympic-ro 35-gil<br>
			Songpa-gu, Seoul, KOREA<br>
			3524211993423<br>
			ACCOUNT HOLDER: Jeong myeonggyu</td>
	</tr>
	<tr>
		<td><img src="<%=request.getContextPath()%>/resources/img/financial_icon3.png"></td>
		<td>청구서 및 기타 재무 관련 문의는 재무팀으로 연락해주세요.<br><br>
			<div class=my_button>메시지 보내기</div></td>
	</tr>
</table>
<%@ include file="../_buisness_bottom.jsp"%>