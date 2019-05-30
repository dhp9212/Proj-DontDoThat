package com.temp.app;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.temp.app.model.AccountDTO;
import com.temp.app.service.AccomodationMapper;
import com.temp.app.service.AccountMapper;

@Controller
public class AccountController {

	@Autowired
	private AccountMapper accountMapper;
	@Autowired
	private AccomodationMapper accomodationMapper; 
	
	@RequestMapping(value = "/signUp.do")
	public String signUpForm() {//회원 가입 폼
		
		return "account/signUp";
	}
	
	//회원 체크
	@RequestMapping(value = "/checkAccount.do", method = RequestMethod.POST)
	public String checkAccountOk(HttpServletRequest req) {
		//String num = req.getParameter("num");
		String email = req.getParameter("email");//입력된 email값을 가져온다.
		HttpSession session = req.getSession();
		session.setAttribute("email", email);
		
		AccountDTO dto = accountMapper.checkEmail(email);
		if(dto == null) {
			System.out.println("AccountController의 checkAccount.do에서 dto 값이 null 입니다. " + dto);
			req.setAttribute("email", email);
			return "account/passwordSettings";//회원이 아니라면 password.jsp 페이지로 이동
		}else {
			System.out.println("AccountController의 checkAccount.do에서 email 값 : " + dto.getEmail());
			req.setAttribute("email", email);
			//return "account/login";
			return "redirect:signUp.do";
			//return "account/signUp";//회원이면 signUp.jsp 페이지를 계속
		}
	}
	
	//로그인 폼 이동
	@RequestMapping(value = "/login.do")
	public String login(HttpServletRequest req) {
		String email = req.getParameter("email");
		HttpSession session = req.getSession();
		session.setAttribute("email", email);
		if(email != null) {
			AccountDTO dto = accountMapper.checkEmail(email);
			req.setAttribute("email", dto.getEmail());
			req.setAttribute("email", email);
			
		}
		return "account/login";
	}
	
	//비밀번호 입력 폼
	@RequestMapping(value = "/password.do")
	public String password(HttpServletRequest req) {
		String ret = "";
		String email = req.getParameter("email");
		AccountDTO dto = accountMapper.checkEmail(email);
		
		if(dto == null) { 
			String none = "없음";
			req.setAttribute("emailCheckNone", none);
			ret = "account/login";
		}else {
			System.out.println("is there:" + dto.getEmail());
			req.setAttribute("email", email);
			req.getSession().setAttribute("dto", dto);
			ret = "account/password";
		}		
		return ret;
	}
	
	//로그인 Ok(비밀번호 입력 폼)
	@RequestMapping(value = "/loginOk.do")
	public ModelAndView loginOk(HttpServletRequest req) throws Exception {
		HttpSession session = req.getSession();
		ModelAndView mv = new ModelAndView();
		
		System.out.println("로그인OK");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		AccountDTO dto = (AccountDTO)session.getAttribute("dto");
				
		if(dto.getPassword().equals(password)) {
			session.setAttribute("userSession", dto);
			//자기 이름에 맞는 숙소 리스트 세션등록
			session.setAttribute("accomodation_dto", accomodationMapper.getAccomodation("내이름"));
			mv.setViewName("forward:/");
		}else {
			//dto = accountMapper.checkEmail(email);
			String wrongPassword = "비밀번호 틀림";
			
			req.setAttribute("email", dto.getEmail());
			//req.getSession().setAttribute("email", email);
			req.setAttribute("wrongPassword", wrongPassword);
			mv.setViewName("account/password");
		}
		return mv;
	}
	
	//로그아웃
	@RequestMapping(value="logoutOk.do")
	public ModelAndView logout(HttpServletRequest req) throws Exception{
		req.getSession().removeAttribute("email");
		
		ModelAndView mav = new ModelAndView("account/login");
		
		return mav;
	}
	
	//비밀번호 설정 완료
	@RequestMapping(value = "/passwordSettingsOk.do", method = RequestMethod.POST)
	public ModelAndView passwordOk(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		AccountDTO dto = new AccountDTO();
		String password = req.getParameter("setPassword");
		HttpSession session = req.getSession();
		//session.setAttribute("password", password);
		//SessionInfo info = (SessionInfo)session.getAttribute("num");
		//dto.setNum(Integer.parseInt((String)session.getAttribute("num")));
		dto.setEmail((String)session.getAttribute("email"));
		dto.setPassword(password);
		dto.setName("");
		dto.setTel(0);
		dto.setProfilePhoto("");
		dto.setNickName("");
		dto.setBirthday("");
		dto.setCountry("");
		dto.setAddress("");
		dto.setPayment("");
		dto.setSmoke("");
		dto.setStarRating(0);
		dto.setDisabled("");
		dto.setPreferredFacility("");
		dto.setReservationTarget("");
		dto.setCurrency("");
		
		//AccountDTO dto = accountMapper.isaAccount(email);
		int res = accountMapper.insertAccount(dto);
		mav.addObject(res);
		mav.setViewName("account/mySettings");
		
		return mav;
	}
	
	//상세 정보 설정 페이지로 이동
		@RequestMapping(value = "/mySettings.do")
		public String mySettings() {
			
			
			
			return "account/mySettings";
		}
	
//	@RequestMapping(value = "/accountInformation.do")
//	public String boardList(HttpServletRequest req) {
//		List<AccountDTO> list = AccountMapper.AccountList();
//		req.setAttribute("accountList", list);
//		return "account/moreInformation";
//	}
	
	//상세 정보 - 프로필 사진이나 닉네임 등 입력, 변경 가능한 페이지
	@RequestMapping(value = "/accountUpdateOk.do", method = RequestMethod.POST)
	public ModelAndView accountUpdateOk(HttpServletRequest req,
			@ModelAttribute AccountDTO dto, BindingResult result) {
		if(result.hasErrors()) {
			dto.setNum(0);
		}
		HttpSession session = req.getSession();
		MultipartRequest mr = (MultipartRequest)req;
		String upPath = req.getSession().getServletContext().getRealPath("image");
		//int num = dto.getNum();
		//dto = accountMapper.getAccount(dto.getNum());
		req.setAttribute("getAccount", dto);
		req.setAttribute("upPath", upPath);
		int len = 10*1024*1024;
		
		//mr = new MultipartRequest(req, upPath, len, "UTF-8");
		
		
		dto.setEmail("");
		dto.setPassword("");
		dto.setName(req.getParameter("name"));
		dto.setTel(Integer.parseInt(req.getParameter("tel")));
		dto.setProfilePhoto(req.getParameter("profilePhoto"));
		dto.setNickName(req.getParameter("nickName"));
		dto.setBirthday(req.getParameter("birthday"));
		dto.setCountry(req.getParameter("country"));
		dto.setAddress(req.getParameter("address"));
		dto.setPayment(req.getParameter("payment"));
		dto.setSmoke(req.getParameter("smoke"));
		dto.setStarRating(Integer.parseInt(req.getParameter("starRating")));
		dto.setDisabled(req.getParameter("disabled"));
		dto.setPreferredFacility(req.getParameter("preferredFacility"));
		dto.setReservationTarget(req.getParameter("reservationTarget"));
		dto.setCurrency(req.getParameter("currency"));
		
		int res = accountMapper.updateAccount(dto);
		
		return new ModelAndView("redirect:account/mySettings");
	}
	
	
	
	
	
	//이용 약관
	@RequestMapping(value = "/terms.do")
	public String terms() {
		return "account/terms";
	}
	
	//개인정보 보호정책
	@RequestMapping(value = "/privacy.do")
	public String privacy() {
		return "account/privacy";
	}
	
	//테스트 페이지
	@RequestMapping(value = "/testPage.do")
	public String testPage() {
		return "test/testPage";
	}
}
