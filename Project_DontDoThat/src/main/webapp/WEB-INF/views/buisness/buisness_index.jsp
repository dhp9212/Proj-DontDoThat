<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="_buisness_top.jsp"%>
<div class="container-fluid" style="background-color:#fafafa">
	<div>
		<table id="1" style="height:70%;">
		<c:forEach var="dto" items="${accomodation_list}">
			<tr>
				<td><a href="general_info.do?accomodation_num=${dto.value.num}">${dto.value.accomodation_name}</a></td>
				<td><font size="3">${dto.value.country}</font> ${dto.value.city} ${dto.value.address}</td>
			</tr>
		</c:forEach>
		</table>
	</div>
</div>
<%@ include file="_buisness_bottom.jsp"%>