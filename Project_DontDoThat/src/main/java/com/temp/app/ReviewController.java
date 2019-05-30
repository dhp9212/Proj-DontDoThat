package com.temp.app;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.temp.app.model.GradeDTO;
import com.temp.app.model.ReviewDTO;
import com.temp.app.model.ReviewGradeDTO;
import com.temp.app.service.ReviewMapper;

@Controller
public class ReviewController {
	@Autowired
	private ReviewMapper reviewMapper;
	
	@RequestMapping(value="/reviewMain.do")
	public String reviewMain() throws Exception{
		return "review/main";
	}
	@RequestMapping(value="/reviewList.do")
	public String reviewList(HttpServletRequest req) throws Exception{
		String accommodation = req.getParameter("accommodation");
		List<ReviewGradeDTO> reviewlist = reviewMapper.listReview(accommodation);
		int reviewcount = reviewMapper.countReview(accommodation);
		GradeDTO reviewaverage = reviewMapper.averageReview(accommodation);
		req.setAttribute("reviewlist", reviewlist);
		req.setAttribute("reviewcount", reviewcount);
		req.setAttribute("reviewaverage", reviewaverage);
		return "review/list";
	}
	@RequestMapping(value="/reviewWrite.do")
	public String reviewWrite() throws Exception{
		return "review/write";
	}
	@RequestMapping(value="/reviewWritePro.do")
	public String reviewWritePro(HttpServletRequest req,
			@ModelAttribute ReviewDTO dto, @ModelAttribute GradeDTO dto1, BindingResult result) throws Exception {
		dto.setWriter("테스트");
		dto.setIp(req.getRemoteAddr());
//		System.out.println(dto.getWriter());
//		System.out.println(dto.getSubject());
//		System.out.println(dto.getContent_p());
//		System.out.println(dto.getContent_m());
//		System.out.println(dto.getIp());
//		System.out.println(dto.getAccommodation());
//		System.out.println(dto.getLodge_date());
		String msg = null, url = null;
		try {
		int review = reviewMapper.insertReview(dto);
		dto1.setReview(review);
		int res = reviewMapper.insertGrade(dto1);
			if(res > 0) {
				msg = "리뷰 작성 성공!";
				url = "reviewMain.do";
			}else {
				msg = "리뷰 작성 실패!";
				url = "reviewMain.do";
			}
		}catch(Exception e) {
			e.printStackTrace();
			msg = "DB서버 오류 발생!! 관리자에게 문의하세요";
			url = "start.app";
		}
		req.setAttribute("msg", msg);
		req.setAttribute("url", url);
		return "message";
	}
}
