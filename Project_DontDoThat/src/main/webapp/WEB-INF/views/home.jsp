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
				<input autocomplete="off" id="input_place" name="input_place" class="input_place" type="text" placeholder="어디로 향하시나요?" style="width:60%; height:50px;">
			    <input autocomplete="off" name="start_date" type="text" placeholder="체크인" aria-label="First name" class="start-date" style="width:12%; height:50px;" size="0" readonly>
			    <input autocomplete="off" name="end_date" type="text" placeholder="체크아웃" aria-label="Last name" class="end-date" style="width:12%; height:50px;" size="0" readonly>
				<!-- <input autocomplete="off" name="people" id="people_form" type="text" placeholder="성인:2명 · 아동:1명 · 객실:1개" style="width:20%; height:50px;" size="0" >
				<input type="hidden" name="adult">
				<input type="hidden" name="child">
				<input type="hidden" name="room"> -->
				<input type="button" value="검색" style="width:10%; height:50px;" onclick="javascript:isSubmit()">
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
									<a href="accomodation_category_search.do?key=${dto.key}" class="image" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/categoryAccomodation/${dto.image}" alt="" style="display: inline-block;"/>
										
									</a>
									<div class="caption">
										<h3>${dto.name}</h3>
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
								<c:forEach var="i" begin="0" end="3" step="1" >
									<article>
										<a href="javascript:onSearchBanner('${cityListShuffled[i].city}')" class="image" style="text-align: center;">
											<img src="${pageContext.request.contextPath}/resources/img/city/${cityListShuffled[i].city_image}" alt="" style="display: inline-block;"/>
										</a>
										<div class="caption">
											<!-- <h3><a href="#">내 집</a></h3> -->
											<p>${cityListShuffled[i].city }</p>
										</div>
									</article>
								</c:forEach>
						</div>
	</section>
	<div id="location-wrapper" >
			<section class="wrapper location_layer1 align-center">
						<!-- Gallery -->
							<!--  layer1 -->
							<div class="gallery location_layer1 medium lightbox onscroll-fade-in">
								<article>
									<a href="javascript:onSearchBanner('${cityListShuffled[4].city}')" class="image1" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/city/${cityListShuffled[4].city_image}" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption caption1">
										<h3>&nbsp;&nbsp;<a href="#1">${cityListShuffled[4].city}</a></h3>
									</div>
								</article>
								<span></span>
								<article>
									<a href="javascript:onSearchBanner('${cityListShuffled[5].city}')" class="image2" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/city/${cityListShuffled[5].city_image}" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption caption2">
										<h3>&nbsp;&nbsp;<a href="#2">${cityListShuffled[5].city}</a></h3>
									</div>
								</article>
							</div>
							
							<!-- layer2 -->
							<div class="gallery location_layer2 medium lightbox onscroll-fade-in">
								<article>
									<a href="javascript:onSearchBanner('${cityListShuffled[6].city}')" class="image3" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/city/${cityListShuffled[6].city_image}" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption caption3">
										<h3>&nbsp;&nbsp;<a href="#3">${cityListShuffled[6].city}</a></h3>
									</div>
								</article>
								<article>
									<a href="javascript:onSearchBanner('${cityListShuffled[7].city}')" class="image4" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/city/${cityListShuffled[7].city_image}" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption caption4">
										<h3>&nbsp;&nbsp;<a href="#4">${cityListShuffled[7].city}</a></h3>
									</div>
								</article>
								<article>
									<a href="javascript:onSearchBanner('${cityListShuffled[8].city}')" class="image5" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/city/${cityListShuffled[8].city_image}" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption caption5">
										<h3>&nbsp;&nbsp;<a href="#5">${cityListShuffled[8].city}</a></h3>
									</div>
								</article>
							</div>
							
							<!-- layer3 -->
							<div class="gallery location_layer3 medium lightbox onscroll-fade-in">
								<article>
									<a href="javascript:onSearchBanner('${cityListShuffled[9].city}')" class="image6" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/city/${cityListShuffled[9].city_image}" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption caption6">
										<h3>&nbsp;&nbsp;<a href="#6">${cityListShuffled[9].city}</a></h3>
										<!-- <h6>&nbsp;&nbsp;&nbsp;<a href="#9">영국</a></h6> -->
									</div>
								</article>
								<article>
									<a href="javascript:onSearchBanner('${cityListShuffled[10].city}')" class="image7" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/city/${cityListShuffled[10].city_image}" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption caption7">
										<h3>&nbsp;&nbsp;<a href="#7">${cityListShuffled[10].city}</a></h3>
										<!-- <h6>&nbsp;&nbsp;&nbsp;<a href="#9">영국</a></h6> -->
									</div>
								</article>
								<article>
									<a href="javascript:onSearchBanner('${cityListShuffled[11].city}')" class="image8" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/city/${cityListShuffled[11].city_image}" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption caption8">
										<h3>&nbsp;&nbsp;<a href="#8">${cityListShuffled[11].city}</a></h3>
										<!-- <h6>&nbsp;&nbsp;&nbsp;<a href="#9">러시아</a></h6> -->
									</div>
								</article>
								<article>
									<a href="javascript:onSearchBanner('${cityListShuffled[12].city}')" class="image9" style="text-align: center;">
										<img src="${pageContext.request.contextPath}/resources/img/city/${cityListShuffled[12].city_image}" alt="" style="display: inline-block;"/>
									</a>
									<div class="caption caption9">
										<h3>&nbsp;&nbsp;<a href="#9">${cityListShuffled[12].city}</a></h3>
										<!-- <h6>&nbsp;&nbsp;&nbsp;<a href="#9">중국</a></h6> -->
									</div>
								</article>
							</div>
			</section>
	</div>
	<form name="banner_form" method="post" action="accomodation_list.do">
		<input type="hidden" id="banner_input_place" name="input_place" value="">
		<input type="hidden"  name="start_date" value="">
		<input type="hidden"  name="end_date" value="">
	</form>
	
	<%@ include file="bottom.jsp" %>
	

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
			
			var $startDate = $('.start-date');
		    var $endDate = $('.end-date');
			
		    $startDate.focus(function(){
				$startDate.val('')
				$endDate.val('')
			})
			$endDate.focus(function(){
				$endDate.val('')
			})
			
			$(function() {
			    
			    
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
	                	<c:forEach var="countryElement" items="${countryList}">
	    				str += '${countryElement.name}' + '/'
	                	</c:forEach>
	    				<c:forEach var="cityElement" items="${cityList}">
	    				str += '${cityElement.city}' + '/'
	                	</c:forEach>  
	                    term = term.toLowerCase();
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
			
			function onSearchBanner(condition){
				$('#banner_input_place').attr('value', condition)
				
				$('form[name="banner_form"]').submit()
			}
			</script>

			
</body>
</html>



