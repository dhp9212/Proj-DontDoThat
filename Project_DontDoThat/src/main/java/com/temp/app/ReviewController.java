package com.temp.app;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.temp.app.model.AccountDTO;
import com.temp.app.model.GradeDTO;
import com.temp.app.model.ReservationDTO;
import com.temp.app.model.ReviewDTO;
import com.temp.app.model.ReviewGradeDTO;
import com.temp.app.service.AccomodationMapper;
import com.temp.app.service.ReviewMapper;

@Controller
public class ReviewController {
	@Autowired
	private ReviewMapper reviewMapper;
	@Autowired
	private AccomodationMapper accomodationMapper;
	
	@RequestMapping(value="/reviewMain.do")
	public String reviewMain(HttpServletRequest req) throws Exception{
		HttpSession session = req.getSession();
	    AccountDTO dto = (AccountDTO)session.getAttribute("userSession");
	    int num = dto.getNum();   
        List<ReservationDTO> listReservation = accomodationMapper.listReservation(num);
        System.out.println(listReservation.size());
        req.setAttribute("listReservation", listReservation);
        
		return "review/main";
	}
	@RequestMapping(value="/reviewList.do")
	public String reviewList(HttpServletRequest req) throws Exception{
		int accommodation = Integer.parseInt(req.getParameter("accommodation"));
		List<ReviewGradeDTO> reviewlist = reviewMapper.listReview(accommodation);
		int reviewcount = reviewMapper.countReview(accommodation);
		GradeDTO reviewaverage = reviewMapper.averageReview(accommodation);
		req.setAttribute("reviewlist", reviewlist);
		req.setAttribute("reviewcount", reviewcount);
		req.setAttribute("reviewaverage", reviewaverage);
		return "review/list";
	}
	@RequestMapping(value="/reviewWrite.do")
	public String reviewWrite(HttpServletRequest req) throws Exception{
		return "review/write";
	}
	@RequestMapping(value="/reviewWritePro.do")
	public String reviewWritePro(HttpServletRequest req,
			@ModelAttribute ReviewDTO dto, @ModelAttribute GradeDTO dto1, BindingResult result) throws Exception {
		HttpSession session = req.getSession();
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		List<MultipartFile> mf = mr.getFiles("myimage");
		
		String image = "";
		String upPath = req.getSession().getServletContext().getRealPath("/resources/img");
		for(MultipartFile c : mf) {
			image += c.getOriginalFilename()+",";
			File file = new File(upPath, c.getOriginalFilename());
			c.transferTo(file);
		}
		image = image.substring(0, image.length() -1);
		dto.setImage(image);
		AccountDTO user = (AccountDTO)session.getAttribute("userSession");
		String writer = user.getNickName();
		if(writer == null) {
			dto.setWriter("익명");
		}else {
			dto.setWriter(writer);
		}
		dto.setIp(req.getRemoteAddr());
		String msg = null;
		try {
		int review = reviewMapper.insertReview(dto);
		dto1.setReview(review);
		int res = reviewMapper.insertGrade(dto1);
			if(res > 0) {
				accomodationMapper.updateReservation(Integer.parseInt(req.getParameter("reservation_num")));
				msg = "리뷰 작성 성공!";
			}else {
				msg = "리뷰 작성 실패!";
			}
		}catch(Exception e) {
			e.printStackTrace();
			msg = "DB서버 오류 발생!! 관리자에게 문의하세요";
			req.setAttribute("url", "start.app");
			return "message";
		}
		req.setAttribute("msg", msg);
		return "popupclose";
	}
}
