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
<font size="5"><b>은행 계좌 정보</b></font><br>
현재 은행 계좌정보를 이곳에서 확인하고 수정하실 수 있습니다.<br><br>
<table width="600px" style="border:1px solid #BDBDBD; padding:20px">
	<tr>
		<td align="center" width="120px"><img src="<%=request.getContextPath()%>/resources/img/dc.svg" width="70px"></td>
		<td>본 사이트에서 환불액, 고객 예약 대금 등을 송금해야 할 수 있습니다. 은행 계좌 정보를 추가하시기 바랍니다.<br>
		<p class="my_button">은행 계좌 정보 추가하기</p>
		</td>
	</tr>
</table>
<%@ include file="../_buisness_bottom.jsp"%>