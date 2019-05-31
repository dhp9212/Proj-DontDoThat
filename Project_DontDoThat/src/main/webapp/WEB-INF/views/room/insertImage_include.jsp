<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/basic_style.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('input[name=files]').change(function(){
			var reader = new FileReader();
			var target_name = $(this).attr('id')
		    reader.onload = function (e) {
		        // get loaded data and render thumbnail.
		        $('img[name=' + target_name + ']').attr('src', e.target.result)
		    }
			if(target_name=='20image') $('#20image').removeAttr('class')
			else $('img[name=' + target_name + ']').next().removeAttr('class')
			
		    // read the image file as a data URL.
		    reader.readAsDataURL(this.files[0]);
		})
		$('img[name=0image]').removeAttr('class')
	})
	function fileUploadAction(select) {
	    console.log("fileUploadAction");
	    $("#" + select.name).trigger('click');
	}
</script>
<c:forEach begin="0" end="19" varStatus="num">
	<input id="${num.index}image" type="file" name="files" class="hide">
</c:forEach>
<c:forEach begin="0" end="19" varStatus="num">
	<img name="${num.index}image" width="90" height="80" style="padding:5px;" onclick="javascript:fileUploadAction(this)" class="hide">
</c:forEach>
	<div id=20image class="hide">
		<font size="5">이미지는 20개까지 등록 할 수 있습니다.</font>
	</div>
