<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_buisness_top.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		$('input[name=files]').change(function(){
			var reader = new FileReader();
		    reader.onload = function (e) {
		        // get loaded data and render thumbnail.
		        if($('img[name=image]').length%5==0)  $('#back').before('<br><br>')
		        $('#back').before('<img name="' + $('img[name=image]').length + '" width="150" height="120" style="padding:20px;" src="' + e.target.result + '">')
		    }
		    // read the image file as a data URL.
		    reader.readAsDataURL(this.files[0]);
		    for(var i=0; i<20; ++i){
		    	if(i==$(this).attr('id')){
		    		$(this).attr('class', 'hide')
		    		$('#'+(i+1)).removeAttr('class')
		    		return
		    	}
		    }
		})
		var images = "${accomodation_dto.image}"
		var image_split = images.split(',')
		for(var i=0; i<image_split.length; ++i){
			if(image_split[i]!='') $('#back').before('<img name="image" width="150" height="120" style="padding:20px;" onclick="javascript:fileUploadAction(this)" src="${pageContext.request.contextPath}/resources/img/' + image_split[i] + '">')
		}
	})
	function image_total(){
		var files = $('input[name=files]')
		for(var i=0; i<files.length; ++i){
			if(files[i].value=='') files[i].remove()
		}
	}
	function fileUploadAction(select) {
		alert(select.name)
	    console.log("fileUploadAction");
	    $("img[name=" + $(this).attr('name') + "]").trigger('click');  
	}

</script>
<font size="5">사진 등록</font><br><br>
<div id="now_image">
	<img src="${pageContext.request.contextPath}/resources/img/${accomodation_dto.image}">
</div>
<form name="f" action="updateImage.do" method="post" enctype="multipart/form-data" onsubmit="return image_total()">
	<input id="0" type="file" name="files">
<c:forEach begin="1" end="19" varStatus="num">
	<input id="${num.count}" type="file" name="files" class="hide">
</c:forEach>
	<font size="5" id=20 class="hide">이미지는 20개까지 등록 할 수 있습니다.</font>
	<div id="back">
		<input type="submit" value="등록하기">
	</div>
</form>

<%@ include file="../_buisness_bottom.jsp"%>