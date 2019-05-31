<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_buisness_top.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		$('input[name=files]').change(function(){
			var reader = new FileReader();
			var target_name = $(this).attr('id')
		    reader.onload = function (e) {
		        // get loaded data and render thumbnail.
		        $('img[name=' + target_name + ']').attr('src', e.target.result)
		        target_name = Number(target_name)
		    }
			$('img[name=' + target_name + ']').next().removeAttr('class')
		    // read the image file as a data URL.
		    reader.readAsDataURL(this.files[0]);
		})
		
		var images = "${accomodation_dto.image}"
		var image_split = images.split(',')
		for(var i=0; i<image_split.length; ++i){
			if(image_split[i]!='') {
				$('img[name=' + i + ']').attr('src', '${pageContext.request.contextPath}/resources/img/' + image_split[i])
				$('img[name=' + i + ']').removeAttr('class')
				$('img[name=' + i + ']').next().removeAttr('class')
			}
		}
	})
	function image_total(){
		var files = $('input[name=files]')
		var image_split = "${accomodation_dto.image}".split(',')
		var images = ''
		for(var i=0; i<files.length; ++i){
			if(files[i].value=='') files[i].remove()
			else{
				if(image_split[i]!=$('#' + i).val().substring(12)) image_split[i] = $('#' + i).val().substring(12)
			}
		}
		for(var i=0; i<image_split.length; ++i){
			if(images=='') images = image_split[i]
			else images += ',' + image_split[i]
		}
		$('input[name=image]').attr('value', images)
	}
	function fileUploadAction(select) {
	    console.log("fileUploadAction");
	    $("#" + select.name).trigger('click');
	}

</script>
<font size="5">사진 등록</font><br><br>
<form name="f" action="updateImage.do" method="post" enctype="multipart/form-data" onsubmit="return image_total()">
<input type="hidden" name="image">
<c:forEach begin="0" end="19" varStatus="num">
	<input id="${num.count-1}" type="file" name="files" class="hide">
</c:forEach>
<c:forEach begin="0" end="19" varStatus="num">
	<c:if test="${num.count-1%5==0}"><br></c:if>
	<img name="${num.count-1}" width="150" height="120" style="padding:20px;" onclick="javascript:fileUploadAction(this)" class="hide">
</c:forEach>
	<font size="5" id=20 class="hide">이미지는 20개까지 등록 할 수 있습니다.</font>
	<div id="back">
		<input type="submit" value="등록하기">
	</div>
</form>

<%@ include file="../_buisness_bottom.jsp"%>