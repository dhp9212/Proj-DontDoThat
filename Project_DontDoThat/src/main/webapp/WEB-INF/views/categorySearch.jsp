<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="top.jsp" %>


<div style="position: fixed; width:100%; min-height: 80%; z-index:-2; opacity: 0.4;" >
<img src="${pageContext.request.contextPath}/resources/img/categoryAccomodation/${categoryDto.image}" style="position: fixed; width:100%; min-height: 100%;">
</div>
<div style="position: fixed; width:100%; min-height: 100%; background:black; opacity: 0.4;" >
</div>



<div align="center" style="position: fixed; width:100%; min-height: 100%; top:50%;">
	<form name="search_form" method="post" action="accomodation_list.do">
					<h2><font color="#FFFFFF">${categoryDto.name}</font></h2>
				<input autocomplete="off" id="input_place" name="input_place" class="input_place" type="text" placeholder="어디로 향하시나요?" style="width:60%; height:50px;">
			    <input autocomplete="off" name="start_date" type="text" placeholder="체크인" aria-label="First name" class="start-date" style="width:12%; height:50px;" size="0" readonly>
			    <input autocomplete="off" name="end_date" type="text" placeholder="체크아웃" aria-label="Last name" class="end-date" style="width:12%; height:50px;" size="0" readonly>
				<input type="button" value="검색" style="width:10%; height:50px;" onclick="javascript:isSubmit()">
				<input type="hidden" name="categoryName" value="${categoryDto.name}">
	</form>
</div>

			<!-- Scripts -->
			<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/jquery.auto-complete.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/jquery.scrollex.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/jquery.scrolly.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/browser.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/breakpoints.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/jquery.dropotron.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/datepicker/datepicker.js"></script>
			<script>
			$(function() {
			    var $startDate = $('.start-date');
			    var $endDate = $('.end-date');
				
			    $startDate.datepicker({
			      autoHide: true,
			      startDate : new Date(this.date)
			    });
			    $endDate.datepicker({
			      autoHide: true,
			      startDate: $startDate.datepicker('getDate'),
			    });

			    $startDate.on('change', function () {
			  	  
			      $endDate.datepicker('setStartDate', $startDate.datepicker('getDate'));
			    });
			  
			});
			$(function(){
				// Dropdowns.
					$('#nav > ul').dropotron({
						mode: 'fade',
						noOpenerFade: true,
						speed: 300
					});
			});
			
			$(function(){
				$('#input_place').autoComplete({
	                minChars: 1,
	                source: function(term, suggest){
	                	var str = new Array();
	                	<c:forEach var="country" items="${countryList}">
	    				str += '${country.name}' + '/'
	                	</c:forEach>     	
	                    term = term.toLowerCase();
	                    /* var choices = ['썅', 'ActionScript', 'AppleScript', 'Asp', 'Assembly', 'BASIC', 'Batch', 'C', 'C++', 'CSS', 'Clojure', 'COBOL', 'ColdFusion', 'Erlang', 'Fortran', 'Groovy', 'Haskell', 'HTML', 'Java', 'JavaScript', 'Lisp', 'Perl', 'PHP', 'PowerShell', 'Python', 'Ruby', 'Scala', 'Scheme', 'SQL', 'TeX', 'XML']; */
	                    var choices = str.split("/");
	                    var suggestions = [];
	                    
	                    for (i=0;i<choices.length;i++)
	                        if (~choices[i].toLowerCase().indexOf(term)) suggestions.push(choices[i]);
	                    suggest(suggestions);
	                }
	            });
			});
			
			function isSubmit(){
				var place = $('#input_place')
				if(place.val() != ''){
					$('form[name="search_form"]').submit()
				}
				else{
					alert("여행지명을 입력해주세요")
				}
			}
			</script>

			
</body>
</html>