<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_buisness_top.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		f.content.focus()
	})
</script>
<form name="f" action="updateContent.do" method="post">
<textarea name="content" style="bgcolor:red;width:90%;height:300;border:1;overflow:visible;text-overflow:ellipsis;">${accomodation_dto.content}</textarea>
<br><br>
<input type="submit" value="수정하기">
</form>
<%@ include file="../_buisness_bottom.jsp"%>