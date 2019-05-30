<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
		.jb-wrap {
			width: 75%;
			margin: 0px auto;
			position: relative;
		}
		.jb-wrap img {
			width: 100%;
			vertical-align: middle;
		}
		.jb-text {
			position: absolute;
			top: 0px;
			width: 100%;
			height: 100%;
		}
		.jb-text-table {
			display: table;
			width: 100%;
			height: 100%;
		}
		.jb-text-table-row {
			display: table-row;
		}
		.jb-text-table-cell {
			display: table-cell;
			vertical-align: middle;
		}
		.jb-text p {
			text-align: center;
			text-valign: middle;
			font-size: 55px;
		}
		
		.jb-wrap1 {
			width: 12%;
			margin: 0px auto;
			position: relative;
		}
		.jb-wrap1 img {
			vertical-align: middle;
		}
		.jb-text1 {
			position: absolute;
			top: 0px;
			text-valign: middle;
		}
		.jb-text1-table {
			display: table;
		}
		.jb-text1-table-row {
			display: table-row;
		}
		.jb-text1-table-cell {
			display: table-cell;
			vertical-align: middle;
		}
		.imgb{
   			position: relative;
    		background-image: url('<%=request.getContextPath()%>/resources/img/review_score_badge1.png');
    		background-repeat: no-repeat;
    		height: 30px;
    		width: 30px;
		}
		.content{
    	 position: absolute;
   		 top:50%;
   		 left:50%;
    	 transform: translate(-50%, -50%);                                                                   
   		 color: white;
   	 	 text-align: center;
   	 	 text-valign: middle;
   	 	}
   	 	
   	 	.tags{
		/* margin:0; */
		padding: 0 0 1rem 0;
	 	/* position:absolute; */ 
	 	/* right:24px; */
		bottom:-12px; 
		list-style:none;
		}
		
		.tags li{
		float: left;
        height: 24px;
        line-height: 24px;
        position: relative;
        font-size: 11px;
        margin: 2px 5px 2px 12px;
        padding: 0 10px 0 12px;
        background: #0078d7;
        color: #fff;
        text-decoration: none;
		}
		
		.tags li:before {
		 content: "";
		 float: left;
		 position: absolute;
		 top: 0;
		 left: -12px;
		 width: 0;
		 height: 0;
		 border-color: transparent #0078d7 transparent transparent;
		 border-style: solid;
		 border-width: 12px 12px 12px 0;
		}	
		
		
	/* 	.dff :before {
		content: "";
		 float: left;
		 position: absolute; 
		 top: 0;
		 left: -12px;
		 width: 0;
		 height: 0;
		 border-color: transparent #FFFFFF transparent transparent;
		 border-style: solid;
		 border-width: 12px 12px 12px 0;
		}
		
		.dfc :before {
		content: "";
		 float: left;
		 position: absolute; 
		 top: 0;
		 left: -12px;
		 width: 0;
		 height: 0;
		 border-color: transparent #E9EFF7 transparent transparent;
		 border-style: solid;
		 border-width: 12px 12px 12px 0;
		} */
}
	
</style>
<%-- <span class="container">
	<img src="<%=request.getContextPath()%>/resources/img/review_score_badge1.png" alt="" width="12%">
	<span class="centered"><font color="white">${grade}</font></span>
</span> --%>
<fmt:formatNumber var="avg" value="${(reviewaverage.clean+
				reviewaverage.comfortable+reviewaverage.location+reviewaverage.facilities+
				reviewaverage.kind+reviewaverage.value+reviewaverage.wifi)/7}"
				pattern=".0"/>	
<fmt:formatNumber var="clean" value="${reviewaverage.clean}" pattern=".0"/>
<fmt:formatNumber var="comfortable" value="${reviewaverage.comfortable}" pattern=".0"/>
<fmt:formatNumber var="location" value="${reviewaverage.location}" pattern=".0"/>
<fmt:formatNumber var="facilities" value="${reviewaverage.facilities}" pattern=".0"/>
<fmt:formatNumber var="kind" value="${reviewaverage.kind}" pattern=".0"/>
<fmt:formatNumber var="value" value="${reviewaverage.value}" pattern=".0"/>
<fmt:formatNumber var="wifi" value="${reviewaverage.wifi}" pattern=".0"/>				
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.1.min.js"></script>
<div style="float:left">
	<table width="200">
		<tr>
			<td align="center"><font size="4"><b>이용 후기 평점</b></font></td>
		</tr>
		<tr>
			<td align="center">호텔 후기 ${reviewcount}개 기준</td>
		</tr>
		<tr>
			<td height="100">
				<div class="jb-wrap">
			<div class="jb-image">
			<img src="<%=request.getContextPath()%>/resources/img/review_score_badge.png" alt="">
			</div>
				<div class="jb-text">
					<div class="jb-text-table">
						<div class="jb-text-table-row">
							<div class="jb-text-table-cell">
								<p><font color="white">${avg}</font></p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</td>
		</tr>
		<tr>
			<td align="center"><font size="4"><b>점수 분석</b></font><br></td>
		</tr>
		<tr>
			<td>
				<table width="200">
					<tr>
						<td>청결도</td>
						<td align="right"><font size="5"><b>${clean}&nbsp;&nbsp;</b></font></td>
					</tr>
					<tr>
						<td colspan="2"><progress value="${clean}" max="10"></progress></td>
					</tr>
					<tr>
						<td>편안함</td>
						<td align="right"><font size="5"><b>${comfortable}&nbsp;&nbsp;</b></font></td>
					</tr>
					<tr>
						<td colspan="2"><progress value="${comfortable}" max="10"></progress></td>
					</tr>
					<tr>
						<td>위치</td>
						<td align="right"><font size="5"><b>${location}&nbsp;&nbsp;</b></font></td>
					</tr>
					<tr>
						<td colspan="2"><progress value="${location}" max="10"></progress></td>
					</tr>
					<tr>
						<td>시설</td>
						<td align="right"><font size="5"><b>${facilities}&nbsp;&nbsp;</b></font></td>
					</tr>
					<tr>
						<td colspan="2"><progress value="${facilities}" max="10"></progress></td>
					</tr>
					<tr>
						<td>직원 친절도</td>
						<td align="right"><font size="5"><b>${kind}&nbsp;&nbsp;</b></font></td>
					</tr>
					<tr>
						<td colspan="2"><progress value="${kind}" max="10"></progress></td>
					</tr>
					<tr>
						<td>가성비</td>
						<td align="right"><font size="5"><b>${value}&nbsp;&nbsp;</b></font></td>
					</tr>
					<tr>
						<td colspan="2"><progress value="${value}" max="10"></progress></td>
					</tr>
					<tr>
						<td>무료 Wi-Fi</td>
						<td align="right"><font size="5"><b>${wifi}&nbsp;&nbsp;</b></font></td>
					</tr>
					<tr>
						<td colspan="2"><progress value="${wifi}" max="10"></progress></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>
<span class="dfc" style="float:center">
<table width="600" style="border-collapse:collapse; background-color:#E9EFF7;">
	<tr>
		<td align="center">
			<table width="96%" style="border:1px solid #D8D8D8; background-color:#FFFFFF;">
				<tr>
					<td align="center"><img src="<%=request.getContextPath()%>/resources/img/policy_icon.png"></td>
					<td><font size=6 color="#383838">100% 검증된 이용후기</font><br>
					실제 이용객 • 실제 숙박 • 실제 의견<br>
					더보기
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr><td>
<c:forEach var="dto" items="${reviewlist}">
	<br>
	<table>
		<tr><td colspan="2" align="right"><font size="2" color="#585858">후기 작성일: ${dto.write_date}</font>
		</td></tr>
		<fmt:formatNumber var="grade" value="${(dto.clean+dto.comfortable+dto.location+
			dto.facilities+dto.kind+dto.value+dto.wifi)/7}" pattern=".0"/>	
		<tr>
			<td rowspan="5" valign="top" width="100">${dto.writer}</td>
			<td>
			<div class="dff">
				<table style="border:1px solid #BDBDBD; background-color:#FFFFFF;" >
					<tr>
						<td height="10" width="10">
							<div class="imgb">
						        <div class="content">${grade}</div>
				  		    </div>
			  			</td>
						<td align="left"><font size="3" color="#424242">&nbsp;"${dto.subject}"</font></td>
					</tr>
					<tr style="background-color:#E9F0FA;">
						<td style="border:1px dotted #BDBDBD;" colspan="2">
							<ul class="tags">
			  					<li>휴가여행</li>
			  					<li>친구끼리 여행</li>
			  					<li>더블룸-흡연실</li>
			 		 			<li>3박 숙박</li>
			 				</ul>
			 			 </td>
					</tr>
					<tr>
						<td colspan="2">&nbsp;&nbsp;<img src='<%=request.getContextPath()%>/resources/img/minus.png' width="15px" height="15px">
						${dto.content_m}</td>
					</tr>
					<tr>
						<td colspan="2">&nbsp;&nbsp;<img src='<%=request.getContextPath()%>/resources/img/plus.png' width="15px" height="15px">
						${dto.content_p}</td>
					</tr>
					<tr>
						<td colspan="2" height="40px"><font size="2" color="#6E6E6E">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${dto.lodge_date}에 숙박함</font></td>
					</tr>
				</table>
				</div>
			</td>
		</tr>
	</table>
</c:forEach>
	</td></tr>
</table>
</span>