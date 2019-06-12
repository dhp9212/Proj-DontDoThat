package com.temp.app;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.rmi.ServerException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.temp.app.model.AccountDTO;
import com.temp.app.model.CountryDTO;
import com.temp.app.service.AccomodationMapper;
import com.temp.app.service.AccountMapper;
import com.temp.app.service.StandardInformationMapper;

@Controller
public class AccountController {

	@Autowired
	private AccountMapper accountMapper;
	@Autowired
	private AccomodationMapper accomodationMapper; 
	@Autowired
	private StandardInformationMapper standardInformationMapper;
	
	@RequestMapping(value = "/signUp.do")
	public String signUpForm() {//회원 가입 폼
		
		return "account/signUp";
	}
	
	//회원 체크
	@RequestMapping(value = "/checkAccount.do", method = RequestMethod.POST)
	public String checkAccountOk(HttpServletRequest req) {
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
			return "redirect:signUp.do";
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
		
		
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		AccountDTO dto = (AccountDTO)session.getAttribute("dto");
				
		if(dto.getPassword().equals(password)) {
			session.setAttribute("userSession", dto);
			//자기 이름에 맞는 숙소 리스트 세션등록
			session.setAttribute("accomodation_list", accomodationMapper.getAccomodation(dto.getNum()));
			mv.setViewName("forward:/");
		}else {
			String wrongPassword = "비밀번호 틀림";
			req.setAttribute("email", dto.getEmail());
			req.setAttribute("wrongPassword", wrongPassword);
			mv.setViewName("account/password");
		}
		return mv;
	}
	
	//로그아웃
	@RequestMapping(value="logoutOk.do")
	public ModelAndView logout(HttpServletRequest req) throws Exception{
		req.getSession().removeAttribute("email");
		req.getSession().removeAttribute("userSession");
		ModelAndView mav = new ModelAndView("account/login");
		return mav;
	}
	
	//비밀번호 설정 완료
	@RequestMapping(value = "/passwordSettingsOk.do", method = RequestMethod.POST)
	public ModelAndView passwordOk(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		String password = req.getParameter("setPassword");
		HttpSession session = req.getSession();
		AccountDTO dto = (AccountDTO)session.getAttribute("dto");
		session.setAttribute("userSession", dto);
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
		int res = accountMapper.insertAccount(dto);
		mav.addObject(res);
		mav.setViewName("account/mySettings");
		return mav;
	}
	
	//상세 정보 설정 페이지로 이동
	@RequestMapping(value = "/mySettings.do")
	public String mySettings(HttpServletRequest req) {
		HttpSession session = req.getSession();
		AccountDTO dto = (AccountDTO)session.getAttribute("userSession");
		req.setAttribute("profilePhoto", dto.getProfilePhoto());
		req.setAttribute("nickName", dto.getNickName());
		req.setAttribute("birthday", dto.getBirthday());
		
//		if(dto.getCountry() != null) {
//			CountryDTO cdto = standardInformationMapper.getCountryByCode2(dto.getCountry());
//			if(cdto == null) {
//				req.setAttribute("country", "국가 선택");
//			}else {
//				req.setAttribute("country", cdto.getName());
//			}
//		}
		//System.out.println("dto.getCountry 컨트롤러 국가 값 : " + dto.getCountry());
		
		return "account/mySettings";
	}
	
	//페이지 새로고침 없이 리로드 실험중... 상세정보 설정 페이지 (닉네임 값)
	@RequestMapping(value = "/accountUpdate.do")
	public ModelAndView accountUpdateOk(HttpServletRequest req) throws IOException,ServerException {
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession();
		AccountDTO dto = (AccountDTO)session.getAttribute("userSession");
		int num = dto.getNum();
		dto.setNum(num);
		int res = 0;
		
		
		//MultipartRequest mr = null;
		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest)req;
		if(mhsr == null) {
			System.out.println("파일 null값 체크" + mhsr);
		}else {
			MultipartFile mf  = mhsr.getFile("profilePhoto");
			String path = req.getSession().getServletContext().getRealPath("/resources/img/profileImage/");//"D:\\maven\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Project_DontDoThat\\resources\\img\\profileImage";//req.getRealPath("/resources/img/profileImage");//"d:/image/";
			if(mf != null) {
				String organizedfilePath= "";
				try {
					if(mf.getSize() > 0) {
						organizedfilePath = mf.getOriginalFilename();
						File realUpload = new File(path, organizedfilePath);
						if(!realUpload.exists()) {
							realUpload.mkdirs();
						}
						mf.transferTo(realUpload);
						
						dto.setProfilePhoto(organizedfilePath);
						accountMapper.updateProfilePhoto(dto);
						req.setAttribute("profilePhoto", dto.getProfilePhoto());
						System.out.println("프로필 이미지 명 : " + dto.getProfilePhoto());
						System.out.println("파일 null값 체크" + mhsr);
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
			}else {
				req.setAttribute("profilePhoto", dto.getProfilePhoto());
			}
		}
		
		String nickName = req.getParameter("nickName");//닉네임
		String birthday = req.getParameter("birthday");//생일
		String country = req.getParameter("country");//국가/지역
		
		String name = req.getParameter("name");//이름
		String tel = req.getParameter("tel");//전화번호
		
		String address = req.getParameter("address");//주소
		String payment = req.getParameter("payment");//결제수단
		String smoke = req.getParameter("smoke");//흡연 여부
		String starRating = req.getParameter("starRating");//숙소 성급
		String disabled = req.getParameter("disabled");//장애인 편의 시설 여부
		String preferredFacility = req.getParameter("preferredFacility");//선호하는 시설
		String reservationTarget = req.getParameter("reservationTarget");//예약 대상
		
		String currency = req.getParameter("currency");//통화(원, 달러, 엔)등등
		String password = req.getParameter("password");//비밀번호
		
		
		if(nickName == null || nickName.trim().equals("")) {
			System.out.println("nickName = " + nickName);
		}else {
			System.out.println("nickName = " + nickName);
			dto.setNickName(req.getParameter("nickName"));
			accountMapper.updateNickName(dto);
			req.setAttribute("nickName", dto.getNickName());
		}
		
		
		if(birthday == null || birthday.trim().equals("")) {
			System.out.println("birthday = " + birthday);
		}else {
			System.out.println("birthday = " + birthday);
			dto.setBirthday(req.getParameter("birthday"));
			accountMapper.updateBirthday(dto);
			System.out.println("dto.getBirthday : " + dto.getBirthday());
			req.setAttribute("birthday", dto.getBirthday());
		}
		
		if(country == null || country.trim().equals("")) {
			System.out.println("country = " + country);
		}else {
			System.out.println("country = " + country);
			dto.setCountry(req.getParameter("country"));
			accountMapper.updateCountry(dto);
//			CountryDTO cdto = standardInformationMapper.getCountryByCode2(dto.getCountry());
//			System.out.println("DB저장 완료? : " + country);
//			System.out.println("DB저장 완료? : " + dto.getCountry());
//			System.out.println("co : " + cdto.getName());
//			req.setAttribute("country", cdto.getName());
		}
		
		if(name == null || name.trim().equals("")) {
			System.out.println("name = " + name);
		}else {
			System.out.println("name = " + name);
			dto.setName(req.getParameter("name"));
			//accountMapper.updateName(dto);
			req.setAttribute("name", dto.getName());
		}
		
		if(tel == null || tel.trim().equals("")) {
			System.out.println("tel = " + tel);
		}else {
			System.out.println("tel = " + tel);
			dto.setTel(Integer.parseInt(req.getParameter("tel")));
			//accountMapper.updateName(dto);
			req.setAttribute("tel", dto.getTel());
		}
		
		if(address == null || address.trim().equals("")) {
			System.out.println("address = " + address);
		}else {
			System.out.println("address = " + address);
			dto.setAddress(req.getParameter("address"));
			//accountMapper.updateAddress(dto);
			req.setAttribute("address", dto.getAddress());
		}
		
		if(payment == null || payment.trim().equals("")) {
			System.out.println("payment = " + payment);
		}else {
			System.out.println("payment = " + payment);
			dto.setPayment(req.getParameter("payment"));
			//accountMapper.updatePayment(dto);
			req.setAttribute("payment", dto.getPayment());
		}
		
		if(smoke == null || smoke.trim().equals("")) {
			System.out.println("smoke = " + smoke);
		}else {
			System.out.println("smoke = " + smoke);
			dto.setSmoke(req.getParameter("smoke"));
			//accountMapper.updateSmoke(dto);
			req.setAttribute("smoke", dto.getSmoke());
		}
		
		if(starRating == null || starRating.trim().equals("")) {
			System.out.println("starRating = " + starRating);
		}else {
			System.out.println("starRating = " + starRating);
			dto.setStarRating(Integer.parseInt(req.getParameter("starRating")));
			//accountMapper.updateStarRating(dto);
			req.setAttribute("starRating", dto.getStarRating());
		}
		
		if(disabled == null || disabled.trim().equals("")) {
			System.out.println("disabled = " + disabled);
		}else {
			System.out.println("disabled = " + disabled);
			dto.setDisabled(req.getParameter("disabled"));
			//accountMapper.updateDisabled(dto);
			req.setAttribute("disabled", dto.getDisabled());
		}
		
		if(preferredFacility == null || preferredFacility.trim().equals("")) {
			System.out.println("preferredFacility = " + preferredFacility);
		}else {
			System.out.println("preferredFacility = " + preferredFacility);
			dto.setPreferredFacility(req.getParameter("preferredFacility"));
			//accountMapper.updatePreferredFacility(dto);
			req.setAttribute("preferredFacility", dto.getPreferredFacility());
		}
		
		if(reservationTarget  == null || reservationTarget .trim().equals("")) {
			System.out.println("reservationTarget  = " + reservationTarget );
		}else {
			System.out.println("reservationTarget  = " + reservationTarget );
			dto.setReservationTarget (req.getParameter("reservationTarget "));
			//accountMapper.updateReservationTarget(dto);
			req.setAttribute("reservationTarget", dto.getReservationTarget());
		}
		
		if(currency == null || currency.trim().equals("")) {
			System.out.println("currency = " + currency);
		}else {
			System.out.println("currency = " + currency);
			dto.setCurrency(req.getParameter("currency"));
			//accountMapper.updateCurrency(dto);
			req.setAttribute("currency", dto.getCurrency());
		}
		
		if(password == null || password.trim().equals("")) {
			System.out.println("password = " + password);
		}else {
			System.out.println("password = " + password);
			dto.setPassword(req.getParameter("password"));
			//accountMapper.updatePassword(dto);
			req.setAttribute("password", dto.getPassword());
		}
		mav.setViewName("account/mySettings");
		return mav;
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
