<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="_buisness_top.jsp"%>
<!DOCTYPE html>
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
	<div>
		<table id="2" style="height:70%;" class="hide">
			<tr>
				<td>예약</td>
			</tr>		
		</table>
	</div>
	<div>
		<table id="3" style="height:70%;" class="hide">
			<tr>
				<td>이용후기</td>
			</tr>		
		</table>
	</div>
<%@ include file="_buisness_bottom.jsp"%>