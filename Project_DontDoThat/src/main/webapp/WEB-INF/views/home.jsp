<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="top.jsp" %>
	<!-- Search menu -->
	<div id="search-wrapper" class="divided" >
		<div class="inner">
			<h3>Search</h3>
		</div>
		<form name="search_form" method="post" action="accomodation_list.do">
			<div>
				<input autocomplete="off" id="input_place" name="input_place" class="input_place" type="text" placeholder="어디로 향하시나요?" style="width:35%; height:50px;" >
			    <input autocomplete="off" name="start_date" type="text" placeholder="체크인" aria-label="First name" class="start-date" style="width:12%; height:50px;" size="0">
			    <input autocomplete="off" name="end_date" type="text" placeholder="체크아웃" aria-label="Last name" class="end-date" style="width:12%; height:50px;" size="0">
				<input autocomplete="off" name="people" id="people_form" type="text" placeholder="성인:2명 · 아동:1명 · 객실:1개" style="width:20%; height:50px;" size="0" >
				<input type="button" value="검색" style="width:10%; height:50px;" onclick="javascript:search_form.submit()">
			</div>
		</form>
	</div>
	
	<!-- Linear menu -->
	<div id="linear-wrapper" class="divided">
			<section class="wrapper style1 align-center">
						<div class="inner">
							<h2>개성 넘치는 홈이 570만 개나 준비되어 있을까요?</h2>
						</div>

						<!-- Gallery -->
							<div class="gallery style2 medium lightbox onscroll-fade-in">
								<c:forEach var="dto" items="${categoryAccomodationList}">
								<article>
									<a href="#" class="image" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/${dto.image}" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption">
										<h3><a href="#">${dto.name}</a></h3>
									</div>
								</article>
								</c:forEach>
							</div>
			</section>
	</div>
	</div>
	

	<section class="wrapper style1 align-center special">
						<div class="inner">
							<h2>내 집 같은 편안함, 홈 & 아파트에서 누려볼 수 있을까요?</h2>
						</div>

						<!-- Gallery -->
							
								<div class="gallery style1">
								<article>
									<a href="#" class="image" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/01-1.jpg" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption">
										<h3><a href="#">내 집</a></h3>
										<p>프라하</p>

									</div>
								</article>
								<article>
									<a href="#" class="image" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/01-2.jpg" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption">
										<h3><a href="#">우리집</a></h3>
										<p>로마</p>

									</div>
								</article>
								<article>
									<a href="#" class="image" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/01-3.jpg" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption">
										<h3><a href="#">개 집</a></h3>
										<p>부다페스트</p>

									</div>
								</article>
								<article>
									<a href="#" class="image" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/01-4.jpg" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption">
										<h3><a href="#">느그 집</a></h3>
										<p>암스테르담</p>

									</div>
								</article>
							</div>

					</section>
					
					
	<div id="location-wrapper" >
			<section class="wrapper location_layer1 align-center">
						<!-- Gallery -->
							<!--  layer1 -->
							<div class="gallery location_layer1 medium lightbox onscroll-fade-in">
								<article>
									<a href="#1" class="image1" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/city/kyoto.jpg" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption caption1">
										<h3>&nbsp;&nbsp;<a href="#1">교토</a></h3>
									</div>
								</article>
								<span></span>
								<article>
									<a href="#2" class="image2" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/city/los_angeles.jpg" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption caption2">
										<h3>&nbsp;&nbsp;<a href="#2"> 로스앤젤레스</a></h3>
									</div>
								</article>
							</div>
							
							<!-- layer2 -->
							<div class="gallery location_layer2 medium lightbox onscroll-fade-in">
								<article>
									<a href="#3" class="image3" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/city/tokyo.jpg" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption caption3">
										<h3>&nbsp;&nbsp;<a href="#3">도쿄</a></h3>
									</div>
								</article>
								<article>
									<a href="#4" class="image4" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/city/new_york.jpg" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption caption4">
										<h3>&nbsp;&nbsp;<a href="#4">뉴욕</a></h3>
									</div>
								</article>
								<article>
									<a href="#5" class="image5" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/city/oosaka.jpg" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption caption5">
										<h3>&nbsp;&nbsp;<a href="#5">오사카</a></h3>
									</div>
								</article>
							</div>
							
							<!-- layer3 -->
							<div class="gallery location_layer3 medium lightbox onscroll-fade-in">
								<article>
									<a href="#6" class="image6" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/city/bahama.jpg" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption caption6">
										<h3>&nbsp;&nbsp;<a href="#6">바하마</a></h3>
										<h6>&nbsp;&nbsp;&nbsp;<a href="#9">바하마</a></h6>
									</div>
								</article>
								<article>
									<a href="#7" class="image7" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/city/london.jpg" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption caption7">
										<h3>&nbsp;&nbsp;<a href="#7">런던</a></h3>
										<h6>&nbsp;&nbsp;&nbsp;<a href="#9">영국</a></h6>
									</div>
								</article>
								<article>
									<a href="#8" class="image8" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/city/saintpetersbrug.jpg" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption caption8">
										<h3>&nbsp;&nbsp;<a href="#8">상트페테르부르크</a></h3>
										<h6>&nbsp;&nbsp;&nbsp;<a href="#9">러시아</a></h6>
									</div>
								</article>
								<article>
									<a href="#9 " class="image9" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/city/sanghai.jpg" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption caption9">
										<h3>&nbsp;&nbsp;<a href="#9">상하이</a></h3>
										<h6>&nbsp;&nbsp;&nbsp;<a href="#9">중국</a></h6>
									</div>
								</article>
							</div>
			</section>
	</div>
	
	<!-- Footer -->
	<div class="footer-wrapper">
					<footer class="wrapper style1 align-center">
						All Right Reserved. 
					</footer>
	</div>

			<!-- Scripts -->
			<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/jquery.auto-complete.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/jquery.scrollex.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/jquery.scrolly.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/browser.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/breakpoints.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/script.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/jquery.dropotron.min.js"></script>
		  	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
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
			</script>

			
</body>
</html>



