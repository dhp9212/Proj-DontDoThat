<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_buisness_top.jsp"%>
<font size="5">사진 등록</font><br><br>
${accomodation_dto.image}
<img src="${pageContext.request.contextPath}/resources/image/${accomodation_dto.image}">
<%@ include file="../_buisness_bottom.jsp"%>