<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../top.jsp" %>
	<div class="bodyconstraint">
		<div id="subheader-wrapper">
			<nav>
				<ol>
					<li>a</li>
					<li>b</li>
					<li>c</li>
				</ol>
			</nav>
		</div>
		<div id="bodyconstraint-inner">
		test text
		
		</div>
	
	<%-- <c:choose>
		<c:when test="${empty listAccomodation}">
		<table border="0" width="100%">
	  		<tr>
				<td align="left">
					<h1>�� ���� ��, Ȥ�� �α� ���� ������ ���� 0��</h1>
				</td>
				<td align="right">
					<a href="">������ ����</a>
				</td>
			</tr>
		</table>
		<table border="1" width="100%">
	  		<tr>
				<td align="center">
					<h2>���ϴ� �˻������ ��� ���</h2><br>
					<h3>���� �ɼ��� ����Ͽ� ���ϴ� ���Ҹ� ã�ƺ����� :</h3>
				</td>
			</tr>
			<tr>
				<td align="left">
					���� �˻�â ���<br>
					<a href="">�˻� ���� ����</a><br>
					<a href="">�ٸ� ��¥�� �˻�</a>
				</td>
			</tr>
		</table>
		</c:when>
		<c:otherwise>
		<table border="0" width="100%">
			<tr>
				<td align="left">
					<h1>�˻��� ����</h1>
				</td>
				<td align="right">
					<a href="">������ ����</a>
				</td>
			</tr>
		</table>
		<table border="1" width="100%">
			<tr>
				<th width="20%">���� ��õ�ϴ� ����</th>
				<th width="15%">���(���� ��)</th>
				<th width="10%">����</th>
				<th width="15%">���� + ��� ��</th>
				<th width="20%">���� �߽����κ����� �Ÿ�</th>
				<th width="20%">������ �ıⰡ ���� ��</th>
			</tr>
		</table>
			<c:forEach var="dto" items="${listAccomodation}">
		<table border="0" width="100%">
			<tr>
				<td width="25%" rowspan="4">
					<img src="image/${dto.image}" width="200" height="200" border="0">
				</td>
				<td width="50%">
					<a href="search_accomodation_content.do?num=${dto.num}">
						<h3>[${dto.category_accomodation}]${dto.accomodation_name}</h3>
					</a>
				</td>
				<td width="25%" align="right">�̿� �ı� ����</td>
			</tr>
			<tr>
				<td width="50%">
					<a href="">${dto.city} - �������� ǥ��</a>
				</td>
				<td width="25%" align="right" rowspan="2">
					<input type="button" value="��� ǥ��" onClick="location.href=''">
				</td>
			</tr>
			<tr>
				<td width="50%">${dto.content}</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="button" value="���� ���� �ɼ� ����" onClick="location.href='search_accomodation_content.do?num=${dto.num}'">
				</td>
			</tr>
		</table>
			</c:forEach>
		</c:otherwise>
	</c:choose> --%>
	</div>
	</div>
</body>
</html>