<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/basic_style.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(document).on('change', $('input[name=files]'), function(e){
			var files = e.target.files
			var filesArr = Array.prototype.slice.call(files)
			var index = 0
			filesArr.forEach(function(f){
				if(!f.type.match('image.*')) alert("리턴 확인")
				var reader = new FileReader()
				reader.onload = function(e){
					var html = "<img width='150' height='130' name='" + f.name + "' style='margin:15px' src='" + e.target.result + "' onclick='javascript:deleteImage(this)'>"
					$('#accomodation_div').append(html)
					index++
				}
				reader.readAsDataURL(f)
			})
		})
	})
	function image_total(){
		//accomodation_image 설정
		var images = ''
		var accomodation_img = $('img')
		for(i=0; i<accomodation_img.length; ++i){
			if(images=='') images = accomodation_img[i].name
			else images += ',' + accomodation_img[i].name
		}
		if(images=='') {
			alert('이미지를 추가해주세요.')
			return false
		}
		$('input[name=image]').attr('value', images)
		return true
	}
	function fileUploadAction(select) {
		$(select).after('<input multiple type="file" name="files" class="hide">')
	    $(select).next().trigger('click');
	}
	function deleteImage(select){
		select.remove()
	}
</script>
<font size="5">사진 등록<br><br></font>
<input class="my_button" type="button" onclick="fileUploadAction(this)" value="숙소 이미지 추가">
<p>
	<div id="accomodation_div" class="box2">
		<input type="hidden" name="image">
	</div>
