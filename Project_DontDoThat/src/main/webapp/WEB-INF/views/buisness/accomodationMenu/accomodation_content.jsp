<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_buisness_top.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		$('#length').text('남은글자 : ' + ('1300'-$('.content').val().length))
		f.content.focus()
		$('.content').on('keyup', function(e){
			if($(this).val().length>1300) return
			$('#length').text('남은글자 : ' + ('1300'-$(this).val().length))
			if('1300'-$(this).val().length=='0'){
				$('#length').text('더 이상은 적을 수 없습니다.')
				return
			}
		})
	})
</script>
<style>
	.pay{
		margin: 20;
	}
	.content{
		width:80%;
		height:200;
		overflow:visible;
		text-overflow:ellipsis;
		padding: 10;
	}
</style>
<form name="f" action="updateContent.do" method="post">
<div class="container">
	<div class="row pay">
		<div class="col-sm-12"><font size="5">숙소에 대한 정보를 적어주세요. 이 숙소의 장점은 무엇입니까?</font></div>
	</div>
	<div class="row pay">
		<div class="col-sm-12">
			<div class="row">
				<div class="col-sm-12"><font size="3">저희는 그저 소개글을 원합니다. 자세한 정보는 <a href="accomodation_facility.do">시설</a>, <a href="policy.do">정책</a>은 해당 링크에서 설정할 수 있습니다.</font></div>
			</div>
			<div class="row">
				<div class="col-sm-12"><font size="3">아직도 내용이 부족하다면 회사정보나 주변의 방문할 만한 곳을 소개하는건 어떨까요?</font></div>
			</div>
		</div>
	</div>
	<div class="row pay">
		<div class="col-sm-12">
			<textarea name="content" class="content" maxlength="1300">${accomodation_dto.content}</textarea>
		</div>
	</div>
	<div class="row" align="right">
		<div id="length" class="col-sm-9"></div>
	</div>
	<div class="row pay">
		<div class="col-sm-12">
			<input type="submit" value="수정하기">
		</div>
	</div>
</div>
</form>
<%@ include file="../_buisness_bottom.jsp"%>