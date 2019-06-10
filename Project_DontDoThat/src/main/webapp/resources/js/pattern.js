$(document).on('keydown', '.onlyNumber', function(e){
	if((e.keyCode<48||e.keyCode>105||(e.keyCode>57&&e.keyCode<96))&&(e.keyCode!=8&&e.keyCode!=116&&e.keyCode!=46)){
		$(this).trigger('blur')
	}
})
$(document).on('change', '.price', function(e){
	var rgx1 = /\D/g;  // /[^0-9]/g 와 같은 표현
	var rgx2 = /(\d+)(\d{3})/; 
	
	function getNumber(obj){
	     var num01;
	     var num02;
	     num01 = obj.value;
	     num02 = num01.replace(rgx1,"");
	     num01 = setComma(num02);
	     obj.value =  num01;
	}
	function setComma(inNum){
	     var outNum;
	     outNum = inNum; 
	     while (rgx2.test(outNum)) {
	          outNum = outNum.replace(rgx2, '$1' + ',' + '$2');
	      }
	     return outNum;
	}
})