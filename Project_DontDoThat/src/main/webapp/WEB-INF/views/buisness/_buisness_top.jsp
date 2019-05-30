<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/basic_style.css">
<html>
<head>
</head>
<script src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
<script>
	$(document).ready(function() {
		$('.table').on('click', function(){
			for(var i=1; i<4; ++i){
				$('#'+i).hide()
			}
			switch($(this).text()){
			case '�׷� Ȩ' : $('#1').show(); break;
			case '����' : $('#2').show(); break;
			case '�̿� �ı�' : $('#3').show(); break;
			}
		})
		$('.menu').on('mouseenter', function(){
			$('#calenderMenu').attr('class', 'hide')
			$('#accomodationMenu').attr('class', 'hide')
			$('#messageMenu').attr('class', 'hide')
			$('#payMenu').attr('class', 'hide')
			$('#menu').show()
			switch($(this).text()){
			case '��� �� Ķ����' : visible('calenderMenu'); break;
			case '����' : visible('accomodationMenu'); break;
			case '�޼���' : visible('messageMenu'); break;
			case '�繫' : visible('payMenu'); break;
			}
		})
	})
	function visible(id){
		$('#blank').attr('class', id);
		if($('#'+id).attr('class')=='hide') $('#'+id).attr('class', 'show')
		else $('#'+id).attr('class', 'hide')
		$('#'+id).on('mouseleave', function(){
			$('#'+id).attr('class', 'hide')
			$('#menu').hide()
		})
	}
</script>
<body>
	<div>
		<table>
			<tr>
				<td width="75%"><a href="index.do">�ε�����</a></td>
				<td><input name="search" type="text" size="10"></td>
				<td><input type="button" class="search"></td>
				<td>��ī��Ʈ</td>
				<td>����</td>
			</tr>		
		</table>
	</div>
	<div>
		<table class="blue">
			<tr>
				<td class="table">�׷� Ȩ</td>
				<td class="table">����</td>
				<td class="table">�̿� �ı�</td>
				<td class="menu">��� �� Ķ����</td>
				<td class="menu">����</td>
				<td class="menu">�޼���</td>
				<td class="menu">�繫</td>
			</tr>
		</table>
		<table>
			<tr id="menu" class="hide">
				<td id="blank"></td>
				<td id="calenderMenu" class="menuHide">
					<table>
						<tr>
							<td><a href="calender.do">Ķ����</a></td>
							<td><a href="open_close.do">���� ����/�ݱ�</a></td>
						</tr>
						<tr>
							<td><a href="qty_control.do">�Ǹ� ���� ���� �� ����</a></td>
							<td><a href="payment.do">�����</a></td>
						</tr>
						<tr>
							<td><a href="pay_control.do">���� ��� �����ϱ�</a></td>
							<td><a href="pay_policy.do">ȯ�� �Ұ� ��� �߰�</a></td>
						</tr>
					</table>
				</td>
				<td id="accomodationMenu" class="menuHide">
					<table>
						<tr>
							<td><a href="homepage.do">���� ������ ����</a></td>
							<td><a href="accomodation_facility.do">�ü� �� ����</a></td>
							<td><a href="nearby.do">���� ��ó���� ������ �ֳ���?</a></td>
						</tr>
						<tr>
							<td><a href="general_info.do">�Ϲ� ����</a></td>
							<td><a href="room_content.do">���� �� ����</a></td>
							<td><a href="accomodation_content.do">�� ���� ���� ����</a></td>
						</tr>
						<tr>
							<td><a href="tax.do">VAT/����/���</a></td>
							<td><a href="room_facility.do">���� ���� �ü�</a></td>
							<td><a href="message_setting.do">�޼��� ����</a></td>
						</tr>
						<tr>
							<td><a href="picture.do">����</a></td>
							<td><a href="onTheWay.do">${dto.name}���� ã�ƿ��� ��</a></td>
						</tr>
						<tr>
							<td><a href="policy.do">��å</a></td>
							<td><a href="profile.do">������</a></td>
						</tr>
					</table>
				</td>
				<td id="messageMenu" class="menuHide">
					<table>
						<tr>
							<td><a href="custom_message.do">�� �޼���</a></td>
						</tr>
						<tr>
							<td><a href="admin_message.do">dontDoThat �޼���</a></td>
						</tr>
					</table>
				</td>
				<td id="payMenu" class="menuHide">
					<table>
						<tr>
							<td><a href="bill.do">û����</a></td>
						</tr>
						<tr>
							<td><a href="reservation_specification.do">���� ����</a></td>
						</tr>
						<tr>
							<td><a href="financial_overview.do">�繫 ����</a></td>
						</tr>
						<tr>
							<td><a href="account_info.do">���� ���� ����</a></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
	
