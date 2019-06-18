<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	function check(accomodation_num){
		vb.accomodation_num.value = accomodation_num;
		document.vb.submit();
	}
</script>
<table id="1" style="height:70%;">
	<c:forEach var="dto" items="${accomodation_list}">
		<tr>
			<td><a href="javascript:check('${dto.value.num}');">${dto.value.accomodation_name}</a></td>
			<td><font size="3">${dto.value.country}</font> ${dto.value.city} ${dto.value.address}</td>
		</tr>
	</c:forEach>
</table>
<form name="vb" method="post">
	<input type="hidden" name="accomodation_num">
</form>