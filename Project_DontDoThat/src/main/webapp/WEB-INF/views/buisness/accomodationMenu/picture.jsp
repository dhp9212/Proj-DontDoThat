<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_buisness_top.jsp"%>
<style>
	input[type=file]{
		display:none;
	}
	.box{
		padding: 0 0 0 20;
	}
	.my_button {
	    display: inline-block;
	    width: 200px;
	    text-align: center;
	    padding: 10px;
	    background-color: #006BCC;
	    color: #fff;
	    text-decoration: none;
	    border-radius: 5px;
	}
	.border{
		background-color: #ebebeb;
		margin: 10;
	}
</style>
<script type="text/javascript">
	var image_path = "${pageContext.request.contextPath}/resources/img/"
	$(document).ready(function() {
		$(document).on('change', $('input[type=file]'), function(e){
			var className = e.target.className
			var files = e.target.files
			var filesArr = Array.prototype.slice.call(files)
			var oneCheck = false
			var fileCheck = false
			filesArr.forEach(function(f){
				if(!f.type.match('image.*')&&!fileCheck){
					alert('이미지파일만 가능합니다.')
					var select = e.target
					fileCheck = true
				}else if(!fileCheck){
					var reader = new FileReader()
					reader.onload = function(e){
						var length = 10
						if(className.charAt(0)=='a') length = 20
						var html = "<img width='180' class='" + className + "' name='" + f.name + "' height='150' style='margin:15px' src='" + e.target.result + "' onclick='javascript:deleteImage(this)'>"
						if($('#' + className + ' img').length<length){
							$('#' + className).append(html)
						}
						else if(!oneCheck){
							alert(length + '개 까지 이미지를 등록 할 수 있습니다.')
							oneCheck = true
						}
					}
					reader.readAsDataURL(f)
				}
			})
		})
		var inputs = $('input[type="hidden"]')
		for(var i=0; i<inputs.length; ++i){
			var room_images = inputs[i].value.split(',')
			var id = inputs[i].name.substring(0, inputs[i].name.length-10)
			for(var j in room_images){
				if(i==0){
					var html = "<img width='180' class='accomodation_div' name='" + room_images[j] + "' height='150' style='margin:15px' src='" + image_path + room_images[j] + "' onclick='javascript:deleteImage(this)'>"
					$('#accomodation_div').append(html)
				}else{
					if(room_images[j]=='') continue
					var html = "<img width='180' class='" + id + "room_div' name='" + room_images[j] + "' height='150' style='margin:15px' src='" + image_path + room_images[j] + "' onclick='javascript:deleteImage(this)'>"
					$('#' + id + 'room_div').append(html)
				}
			}
		}
	})
	function image_total(){
		var room_list = $('input[type="hidden"]')
		for(var i=0; i<room_list.length; ++i){
			var images = ''
			var name = room_list[i].name
			var room_img = $('img[class="' + name.substring(0, name.length-5) + 'div"]')
			for(var j=0; j<room_img.length; ++j){
				if(images=='') images = room_img[j].name
				else images += ',' + room_img[j].name
			}
			room_list[i].value = images
		}
		return true
	}
	function fileUploadAction(select) {
		var str, str2
		if(select.value=="숙소 이미지 추가"){
			str = "accomodation_div"
			str2 = "accomodation_"
		}else{
			str = select.name + "room_div"
			str2 = select.name + "room_"
		}
		if($(select).next().val()!='') $(select).after('<input multiple type="file" name="' + str2 + 'files" class="' + str + '">')
	    $(select).next().trigger('click');
	}
	function deleteImage(select){
		select.remove()
	}
</script>
<div class="container">
<form name="f" action="updateImage.do" method="post" enctype="multipart/form-data" onsubmit="return image_total()" accept-charset="UTF-8">
	<div class="row border">
		<div class="col-sm-12"><font size="5">사진 등록<br><br></font></div>
	</div>
	<div class="row border">
		<div class="col-sm-12">
			<div class="row">
				<div class="col-sm-12"><input class="my_button" type="button" onclick="fileUploadAction(this)" value="숙소 이미지 추가"></div>
			</div>
			<div id="accomodation_div" class="row box">
				<div class="col-sm-12"><input type="hidden" name="accomodation_image" value="${accomodation_dto.image}"></div>
			</div>
		</div>
		
	</div>
	
<c:forEach var="roomDTO" items="${room_list}">
	<div class="row border">
		<div class="col-sm-12">
			<div class="row">
				<div class="col-sm-12"><input name="${roomDTO.key}" class="my_button" type="button" onclick="fileUploadAction(this)" value="${roomDTO.value.roomname} 이미지 추가"></div>
			</div>
			<div id="${roomDTO.key}room_div" class="row box">
				<div class="col-sm-12"><input type="hidden" name="${roomDTO.key}room_image" value="${roomDTO.value.room_image}"></div>
			</div>
		</div>
	</div>
</c:forEach>
	<div class="row" style="margin: 10;">
		<div class="col-sm-12"><input type="submit" value="등록하기"></div>
	</div>
</form>
</div>
<%@ include file="../_buisness_bottom.jsp"%>