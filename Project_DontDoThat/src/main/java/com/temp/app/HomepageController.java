package com.temp.app;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.temp.app.service.StandardInformationMapper;

@Controller
public class HomepageController {
	@Autowired
	StandardInformationMapper standardInformationMapper;
	@RequestMapping(value="hotelSuk.com")
	public String homepage1() {
		return "homepage/hotelSuk";
	}
	@RequestMapping(value="houseNue.com")
	public String homepage2() {
		return "homepage/houseNue";
	}
	@RequestMapping(value="insertInit.do")
	public String insertInit(HttpServletRequest req) {
		standardInformationMapper.sysout(req);
		return "forward:home.do";
	}
	@RequestMapping(value="insertInit2.do")
	public String insertInit2() {
		standardInformationMapper.roomSysout();
		return "forward:home.do";
	}
	@RequestMapping(value="insertInit3.do")
	public String insertInit3() {
		standardInformationMapper.reservationSysout();
		return "forward:home.do";
	}
}
