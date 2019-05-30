<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, com.temp.app.model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="top.jsp"%>
Q&A 
<div align="center">
	전체카테고리등록
	<table align="center" border="1">
		<form name="fh" action="inputMainCate_Ok.admin" method="post">
		<tr>
			<th>메인카테고리</th>
			<td><input type="text" name="hcate" size="20" maxlength="20" value="추가할 메인카테고리명을 적어주세요">
			&nbsp;<input type="submit" value="추가"></td>
		</tr>
		</form>
		<tr>
		<form name="fm" action="inputMainCate_Ok.admin" method="post">
			<td>
			<select name="hcate">
			<c:forEach var="cate" items="${hcatelist}">
				<option value="${cate}">${cate}</option>
			</c:forEach>
			</select>
			</td>
				<td><input type="text" name="mcate" size="20" maxlength="20">
				&nbsp;<input type="submit" value="추가"></td>	
		</tr>
		</form>
	</table>
<script type="text/javascript">
 	function deletecate(){
 		if(confirm("삭제하시겠습니까?")){
 			return true;
 		}
 		return false;
 	}
 	function deletebcate(no){
 		var c = no;
 		document.getElementById("fccate").value = c;
 		document.cc.submit();
 	}
 	function catelist(hcate, mcaten){
 		var h = hcate;
 		var m = mcaten;
 		document.getElementById("fhcate").value = h;
 		document.getElementById("fmcaten").value = m;
 		document.ll.submit();
 	}
</script>
<form name= "cc" action= "deleteAnswer.admin" method="post">
<input type="hidden" name="hcate" value="${hcate}">
<input type ="hidden" name="mcate" value="${mcate}">
<input type="hidden" id="fccate" name="no">
</form>
<form name="ll" action="listAnswer.admin" method="post">
<input type="hidden" id="fhcate" name="hcate">
<input type="hidden" id="fmcaten" name="mcate">
</form>
<div style="width:50%;float:left;">
<table border="1" width="90%">
<% List<String> hcatelist = (List)request.getAttribute("hcatelist"); 
		for(String hcate : hcatelist){%>
			<tr align="center">
				<th colspan="2">	
					<form method="post" action="deleteCate.admin" onsubmit="return deletecate()">		
					<input type="hidden" name="hcate" value="<%=hcate%>">		
					<%=hcate%>&nbsp;<input type="submit" value="삭제">
					</form>
				</th>
			</tr>	
			<tr>		
<% 
			List<QA_SubCateDTO> mcatelist = (List)request.getAttribute(hcate); 
				int cnt = 0;
				for(QA_SubCateDTO mdto : mcatelist){
			cnt++;
		%>
				<td>
					<form method="post" action="deleteCate.admin" onsubmit="return deletecate()">
					<input type="hidden" name="no" value="<%=mdto.getNo()%>">
					&nbsp;<a href="javascript:catelist('<%=mdto.getMaincate()%>', '<%=mdto.getNo()%>')"><%=mdto.getSubcate()%></a>
					&nbsp;<input type="submit" value="삭제">
					</form>
				</td>
<%		if(cnt%2 == 0){		%>
				</tr><tr>		
<%			}
			}
		}
%>
		</tr>
	</table>
</div>
<div style="width:50%;float:right;">
<table border="1" width="90%">
	<tr>
		<th>게시판 카테고리 목록</th>
	</tr>
	<tr>
	<c:if test="${hcate == null}">
		<td>카테고리를 선택하세요</td>
	</c:if>
	</tr>
	<tr>
		<form name="addcate" action="inputAnswer.admin" method="post">
		<input type="hidden" name="hcate" value="${hcate}">
		<input type="hidden" name="mcate" value="${mcate}">
		<td><input type="text" name="answer" maxlength="17" size="17">&nbsp;<input type="submit" value="추가"></td>
		</form>
	</tr>
		<c:if test="${empty bcate}">
			<tr>
				<td>등록된 카테고리가 없습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="bdto" items="${bcate}">
			<tr>
				<td>${bdto.answer}&nbsp;<a href="javascript:deletebcate('${bdto.no}')"><font size="1">삭제</font></a></td>
			</tr>
		</c:forEach>
</table>
</div>
</div>

<%@ include file="bottom.jsp"%>