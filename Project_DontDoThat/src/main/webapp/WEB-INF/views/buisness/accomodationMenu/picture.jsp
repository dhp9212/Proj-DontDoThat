<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_buisness_top.jsp"%>

<style>
	input[type=file]{
		display:none;
	}
</style>
<script type="text/javascript">

	var image_path = "${pageContext.request.contextPath}/resources/img/"
	$(document).ready(function() {
		$(document).on('change', $('input[name=files]'), function(e){
			var className = e.target.className
			var files = e.target.files
			var filesArr = Array.prototype.slice.call(files)
			var index = 0
			filesArr.forEach(function(f){
				if(!f.type.match('image.*')) alert("리턴 확인")
				var reader = new FileReader()
				reader.onload = function(e){
					var html = "<img width='180' class='" + className + "' name='" + f.name + "' height='150' style='margin:15px' src='" + e.target.result + "' onclick='javascript:deleteImage(this)'>"
					$('#' + className).append(html)
					index++
				}
				reader.readAsDataURL(f)
			})
		})
		var saved_image = "${accomodation_dto.image}".split(',')
		for(var i=0; i<saved_image.length; ++i){
			var html = "<img width='180' name='" + saved_image[i] + "' height='150' style='margin:15px' src='" + image_path + saved_image[i] + "' onclick='javascript:deleteImage(this)'>"
			$('#accomodation_div').append(html)
		}
	})
	function image_total(){
		//accomodation_image 설정
		var images = ''
		var accomodation_img = $('img[class=accomodation_div]')
		for(i=0; i<accomodation_img.length; ++i){
			if(images=='') images = accomodation_img[i].name
			else images += ',' + accomodation_img[i].name
		}
		$('input[name=accomodation_image]').attr('value', images)
		
		//room_image 설정
		<c:forEach var="roomDTO" items="${room_list}">
			images = ''
			var room_img = $('img[class=${roomDTO.key}room_div]')
			for(i=0; i<room_img.length; ++i){
				if(images=='') images = room_img[i].name
				else images += ',' + room_img[i].name
			}
			$('input[name=${roomDTO.value.num}room_image]').attr('value', images)
		</c:forEach>
	}
	function fileUploadAction(select) {
		var str
		if(select.value=="숙소 이미지 추가") str = "accomodation_div"
		else str = select.name + "room_div"
		$(select).after('<input multiple type="file" name="files" class="' + str + '">')
	    $(select).next().trigger('click');
	}
	function deleteImage(select){
		select.remove()
	}
</script>
<font size="5">사진 등록<br><br></font>
<input class="my_button" type="button" onclick="fileUploadAction(this)" value="숙소 이미지 추가">
<p>
<form name="f" action="updateImage.do" method="post" enctype="multipart/form-data" onsubmit="return image_total()">
	<div id="accomodation_div" class="box">
		<input type="hidden" name="accomodation_image">
	</div>
<c:forEach var="roomDTO" items="${room_list}">
	<p>
	${roomDTO.key}번 <input name="${roomDTO.key}" class="my_button" type="button" onclick="fileUploadAction(this)" value="${roomDTO.value.roomname} 이미지 추가">
	<div id="${roomDTO.key}room_div" class="box">
		<input type="hidden" name="${roomDTO.key}room_image">
	</div>
</c:forEach>
	<div style="margin:20px">
		<br><br><input type="submit" value="등록하기">
	</div>
</form>
<%@ include file="../_buisness_bottom.jsp"%>