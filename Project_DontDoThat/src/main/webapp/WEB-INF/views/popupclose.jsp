<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<script type="text/javascript">
	alert("${msg}")
	opener.parent.location='${url}'
	window.close();
</script></html>