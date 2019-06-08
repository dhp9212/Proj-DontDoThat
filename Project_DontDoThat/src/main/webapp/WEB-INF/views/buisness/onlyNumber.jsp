<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		$('input[type=text]').on('keydown', function(e){
			if((e.keyCode<48||e.keyCode>105||(e.keyCode>57&&e.keyCode<96))&&(e.keyCode!=8&&e.keyCode!=116)){
				$(this).trigger('blur')
			}
		})