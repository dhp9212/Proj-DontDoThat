package com.temp.app;

import java.io.File;
import java.io.IOException;
import java.rmi.ServerException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.temp.app.model.AccountDTO;
import com.temp.app.model.Card;
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
	@Autowired
	private JavaMailSender mailSender;
	
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
	
		req.getSession().setAttribute("email", email);
		
		// get Account Data
		AccountDTO dto = accountMapper.checkEmail(email);
		
		if(dto == null) {
			// not exist email = not a member
			String none = "없음";
			req.setAttribute("emailCheckNone", none);
			ret = "account/login";
		}else {
			// exist email = member
			req.setAttribute("email", email);
			req.getSession().setAttribute("dto", dto);
			ret = "account/password";
		}		
		return ret;
	}
	
	//임시 비밀번호 발송
		@RequestMapping(value = "/temporaryPassword.do")
		public ModelAndView temporaryPassword(HttpServletRequest req) {
			HttpSession session = req.getSession();
			AccountDTO dto = (AccountDTO)session.getAttribute("dto");
			ModelAndView mv = new ModelAndView();
				
		    String uuid = UUID.randomUUID().toString().replaceAll("-", ""); // -를 제거해 주었다. 
		    uuid = uuid.substring(0, 10); //uuid를 앞에서부터 10자리 잘라줌. 
			    
			String setfrom = "Gnikcah6@gmail.com";         
		    String tomail  = (String)session.getAttribute("email");     // 받는 사람 이메일
		    String title   = "임시 비밀번호";    // 제목
		    String content = uuid;   // 내용
		    System.out.println("임시 비밀번호 생성 = " + uuid);
		    dto.setPassword(uuid);
		    accountMapper.updateTemporaryPassword(dto);
		    
		    System.out.println("session 이메일 값 : " + tomail);
		    System.out.println("임시 비밀번호 업데이트 = " + dto.getPassword());
		    try {
		      MimeMessage message = mailSender.createMimeMessage();
		      MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		 
		      messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
		      messageHelper.setTo(tomail);     // 받는사람 이메일
		      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
		      messageHelper.setText(content);  // 메일 내용
		     
		      mailSender.send(message);
		    } catch(Exception e){
		      //System.err.println(e);
		    }
		    mv.setViewName("account/password");
		    return mv; 
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
			
			// if country exist
			if(dto.getCountry() != null && !dto.getCountry().equals("")) {
				dto.setCountryName(standardInformationMapper.getCountryByCode2(dto.getCountry()).getName());
			}
			
			session.setAttribute("userSession", dto);
			System.out.println("payment zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz : " + dto.getPayment());
			// if credit card exist
			if(dto.getPayment() != null) {
				if(!dto.getPayment().equals("")) {
					List<Card> cardList = new ArrayList<Card>();
					String[] cards = dto.getPayment().split("#");
					for(int i = 0; i < cards.length; i++) {
						String[] cardElement = cards[i].split(",");
						System.out.println("cardlength : " +cards.length);
						cardList.add(new Card(cardElement[0], cardElement[1], cardElement[2]));
					}
					dto.setCardList(cardList);
				}
			}
			
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
		ModelAndView mav = new ModelAndView("forward:/");
		return mav;
	}
	
	//비밀번호 설정 완료
	@RequestMapping(value = "/passwordSettingsOk.do", method = RequestMethod.POST)
	public ModelAndView passwordOk(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		String password = req.getParameter("setPassword");
		HttpSession session = req.getSession();
		AccountDTO dto = new AccountDTO();
		dto.setEmail((String)session.getAttribute("email"));
		dto.setPassword(password);
		dto.setName("");
		dto.setTel("");
		dto.setProfilePhoto("");
		dto.setNickName("");
		dto.setBirthday("");
		dto.setCountry("");
		dto.setAddress("");
		dto.setPayment(null);
		dto.setSmoke("");
		dto.setStarRating(0);
		dto.setDisabled("");
		dto.setPreferredFacility("");
		dto.setReservationTarget("");
		dto.setCurrency("");
		session.setAttribute("userSession", dto);
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
	
		return "account/mySettings";
	}
	
//	//상세정보 설정 페이지
//	@RequestMapping(value = "/accountUpdate.do")
//	public ModelAndView accountUpdateOk(HttpServletRequest req) throws IOException,ServerException {
//		ModelAndView mav = new ModelAndView();
//		HttpSession session = req.getSession();
//		AccountDTO dto = (AccountDTO)session.getAttribute("userSession");
//		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest)req;
//		
//		MultipartFile mf  = mhsr.getFile("profilePhoto");
//		String path = req.getSession().getServletContext().getRealPath("/resources/img/profileImage/");
//		//"D:\\maven\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Project_DontDoThat\\resources\\img\\profileImage";//req.getRealPath("/resources/img/profileImage");//"d:/image/";
//		if(mf != null) {
//			String organizedfilePath= "";
//			try {
//				if(mf.getSize() > 0) {
//					organizedfilePath = mf.getOriginalFilename();
//					File realUpload = new File(path, organizedfilePath);
//					if(!realUpload.exists()) {
//						realUpload.mkdirs();
//					}
//					mf.transferTo(realUpload);
//					
//					dto.setProfilePhoto(organizedfilePath);
//					accountMapper.updateProfilePhoto(dto);
//					req.setAttribute("profilePhoto", dto.getProfilePhoto());
//					System.out.println("프로필 이미지 명 : " + dto.getProfilePhoto());
//					System.out.println("파일 null값 체크" + mhsr);
//				}
//			}catch(Exception e) {
//				e.printStackTrace();
//			}
//		}else {
//			req.setAttribute("profilePhoto", dto.getProfilePhoto());
//		}
//		
//		String nickName = req.getParameter("nickName");//닉네임
//		String birthday = req.getParameter("birthday");//생일
//		String country = req.getParameter("country");//국가/지역
//		
//		String name = req.getParameter("name");//이름
//		String tel = req.getParameter("tel");//전화번호
//		String email = req.getParameter("email");//이메일
//		String address = req.getParameter("address");//주소
//		
//		String selectPayment = req.getParameter("payment");//카드 종류
//		String nameOfCreditCard = req.getParameter("nameOfCreditCard");//카드 번호
//		String expirationDate = req.getParameter("expirationDate");//만료 일자
//
//		
//		String payment = selectPayment + " " + nameOfCreditCard + " " + expirationDate;//결제수단
//		String smoke = req.getParameter("smoke");//흡연 여부
//		String starRating = req.getParameter("starRating");//숙소 성급
//		String disabled = req.getParameter("disabled");//장애인 편의 시설 여부
//		String preferredFacility = req.getParameter("preferredFacility");//선호하는 시설
//		String reservationTarget = req.getParameter("reservationTarget");//예약 대상
//		
//		String currency = req.getParameter("currency");//통화(원, 달러, 엔)등등
//		String password = req.getParameter("confirmPassword");//비밀번호
//		
//		
//		session.getAttribute("currencyList");
//		
//		if(nickName != null) {// || !nickName.trim().equals("")
//			System.out.println("nickName = " + nickName);
//			dto = (AccountDTO)session.getAttribute("userSession");
//			dto.setNickName(req.getParameter("nickName"));
//			accountMapper.updateNickName(dto);
//			req.setAttribute("nickName", dto.getNickName());
//			System.out.println("birthday = " + birthday);
//			dto.setBirthday(req.getParameter("birthday"));
//			accountMapper.updateBirthday(dto);
//			System.out.println("dto.getBirthday : " + dto.getBirthday());
//			req.setAttribute("birthday", dto.getBirthday());
//		}else if(country != null){
//			System.out.println("country = " + country);
//			dto.setCountry(req.getParameter("country"));
//			//accountMapper.updateCountry(dto);			
//			req.setAttribute("country", dto.getCountry());
//		}else if(name != null) {
//			System.out.println("name = " + name);
//			dto.setName(req.getParameter("name"));
//			accountMapper.updateName(dto);
//			req.setAttribute("name", dto.getName());
//			System.out.println("tel = " + tel);
//			dto.setTel(req.getParameter("tel"));
//			accountMapper.updateTel(dto);
//			req.setAttribute("tel", dto.getTel());
//			System.out.println("address = " + address);
//			dto.setAddress(req.getParameter("address"));
//			accountMapper.updateAddress(dto);
//			req.setAttribute("address", dto.getAddress());
//		}else if(payment != null || !payment.trim().equals("")) {
//			System.out.println("payment = " + payment);
//			
//			dto.setPayment(payment);
//			accountMapper.updatePayment(dto);
//			
//			// 0 : kind of card
//			// 1 : # of card
//			// 2 : expire date
////			String[] pay = payment.split(" ");
////			req.setAttribute("selectCard", pay[0]);
////			req.setAttribute("nameOfCreditCard", pay[1]);
////			req.setAttribute("expirationDate", pay[2]);
//			req.setAttribute("payment", dto.getPayment());
//		}else if(smoke != null || !smoke.trim().equals("")) {
//			System.out.println("smoke = " + smoke);
//			dto.setSmoke(req.getParameter("smoke"));
//			//accountMapper.updateSmoke(dto);
//			req.setAttribute("smoke", dto.getSmoke());
//		}else if(starRating != null || !starRating.trim().equals("")) {
//			System.out.println("starRating = " + starRating);
//			dto.setStarRating(Integer.parseInt(req.getParameter("starRating")));
//			//accountMapper.updateStarRating(dto);
//			req.setAttribute("starRating", dto.getStarRating());
//		}else if(disabled != null || !disabled.trim().equals("")) {
//			System.out.println("disabled = " + disabled);
//			dto.setDisabled(req.getParameter("disabled"));
//			//accountMapper.updateDisabled(dto);
//			req.setAttribute("disabled", dto.getDisabled());
//		}else if(preferredFacility != null || !preferredFacility.trim().equals("")) {
//			System.out.println("preferredFacility = " + preferredFacility);
//			dto.setPreferredFacility(req.getParameter("preferredFacility"));
//			//accountMapper.updatePreferredFacility(dto);
//			req.setAttribute("preferredFacility", dto.getPreferredFacility());
//		}else if(reservationTarget  != null || !reservationTarget .trim().equals("")) {
//			System.out.println("reservationTarget  = " + reservationTarget );
//			dto.setReservationTarget (req.getParameter("reservationTarget "));
//			//accountMapper.updateReservationTarget(dto);
//			req.setAttribute("reservationTarget", dto.getReservationTarget());
//		}else if(currency != null || !currency.trim().equals("")) {
//			System.out.println("currency = " + currency);
//			dto.setCurrency(req.getParameter("currency"));
//			//accountMapper.updateCurrency(dto);
//			req.setAttribute("currency", dto.getCurrency());
//		}else if(password != null || !password.trim().equals("")) {
//			System.out.println("password = " + password);
//			dto.setPassword(req.getParameter("confirmPassword"));
//			accountMapper.updatePassword(dto);
//			req.setAttribute("password", dto.getPassword());
//		}
//		
////		if(password == null || password.trim().equals("")) {
////			System.out.println("password = " + password);
////		}else {
////			System.out.println("password = " + password);
////			dto.setPassword(req.getParameter("confirmPassword"));
////			accountMapper.updatePassword(dto);
////			req.setAttribute("password", dto.getPassword());
////		}
//		
//		mav.setViewName("forward:/mySettings.do");
//		return mav;
//	}
	
	
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
	
	
	
	@RequestMapping(value = "/accountUpdateImage.do")
	public ModelAndView accountUpdateImage(HttpServletRequest req) throws IOException,ServerException {
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession();
		AccountDTO dto = (AccountDTO)session.getAttribute("userSession");
		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest)req;
		
		MultipartFile mf  = mhsr.getFile("profilePhoto");
		String path = req.getSession().getServletContext().getRealPath("/resources/img/profileImage/");
		//"D:\\maven\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Project_DontDoThat\\resources\\img\\profileImage";//req.getRealPath("/resources/img/profileImage");//"d:/image/";
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
		
		mav.setViewName("forward:/mySettings.do");
		return mav;
	}
	
	@RequestMapping(value = "/accountUpdateNames.do")
	public ModelAndView accountUpdateNames(HttpServletRequest req) throws Exception{
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession();
		AccountDTO dto = (AccountDTO)session.getAttribute("userSession");
		
		String nickName = req.getParameter("nickName");//닉네임
		String birthday = req.getParameter("birthday");//생일
		
		// if nickName form is not null, update DB
		if(nickName != null) {
			dto.setNickName(nickName);
			accountMapper.updateNickName(dto);
		}
		// if birthday form is not null, update DB
		if(birthday != null) {
			dto.setBirthday(birthday);
			accountMapper.updateBirthday(dto);
		}
		
		session.setAttribute("userSession", dto);
		mav.setViewName("forward:/mySettings.do");
		return mav;
	}
	
	@RequestMapping(value = "/accountUpdateCountry.do")
	public ModelAndView accountUpdateCountry(HttpServletRequest req) throws Exception{
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession();
		AccountDTO dto = (AccountDTO)session.getAttribute("userSession");
		
		String countryCode2 = req.getParameter("country");
		
		dto.setCountry(countryCode2);
		accountMapper.updateCountry(dto);
		dto.setCountryName(standardInformationMapper.getCountryByCode2(countryCode2).getName());
		
		session.setAttribute("userSession", dto);
		mav.setViewName("forward:/mySettings.do");
		return mav;
	}
	
	@RequestMapping(value = "/accountUpdatePrivate.do")
	public ModelAndView accountUpdatePrivate(HttpServletRequest req) throws Exception{
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession();
		AccountDTO dto = (AccountDTO)session.getAttribute("userSession");
		
		String name = req.getParameter("name");
		String tel = req.getParameter("tel");
		String address = req.getParameter("address");
		
		
		if(name != null) {
			dto.setName(name);
			accountMapper.updateName(dto);
		}
		
		if(tel != null) {
			dto.setTel(tel);
			accountMapper.updateTel(dto);
		}
		
		if(address != null) {
			dto.setAddress(address);
			accountMapper.updateAddress(dto);
		}
		
		session.setAttribute("userSession", dto);
		mav.setViewName("forward:/mySettings.do");
		return mav;
	}
	
	
	@RequestMapping(value = "/accountUpdateCard.do")
	public ModelAndView accountUpdateCard(HttpServletRequest req) throws Exception{
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession();
		AccountDTO dto = (AccountDTO)session.getAttribute("userSession");
		
		String kindOfCreditCard = req.getParameter("kindOfCreditCard");
		String numOfCreditCard = req.getParameter("numOfCreditCard");
		String expirationDate = req.getParameter("expirationDate");
		
		System.out.println("here");
		
		String payment = dto.getPayment();
		
		// if payment already exist add tokenizer /
		if(payment != null) {
			if(!payment.equals("")) {
				payment += "#";
			}
		}
		else {
			payment = "";
		}
		payment += kindOfCreditCard + ",";
		payment += numOfCreditCard + ",";
		payment += expirationDate;
		
		dto.setPayment(payment);
		accountMapper.updatePayment(dto);
		
		List<Card> cardList;
		if(dto.getCardList() == null) {
			cardList = new ArrayList<Card>();
		}
		else {
			cardList = dto.getCardList();
		}
		cardList.add(new Card(kindOfCreditCard, numOfCreditCard, expirationDate));
		dto.setCardList(cardList);
		
		session.setAttribute("userSession", dto);
		mav.setViewName("forward:/mySettings.do");
		return mav;
	}
	
	@RequestMapping(value = "accountUpdatePassword.do")
	public ModelAndView accountUpdatePassword(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession();
		AccountDTO dto = (AccountDTO)session.getAttribute("userSession");
		
		String password = req.getParameter("confirmPassword");//비밀번호
		if(password != null || !password.trim().equals("")) {
			System.out.println("password = " + password);
			dto.setPassword(req.getParameter("confirmPassword"));
			accountMapper.updatePassword(dto);
			req.setAttribute("password", dto.getPassword());
		}
		
		mav.setViewName("forward:/mySettings.do");
		
		return mav;
	}
}
