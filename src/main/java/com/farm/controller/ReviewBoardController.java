package com.farm.controller;




import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.farm.config.login.CustomUserDetails;
import com.farm.dto.MemberDTO;
import com.farm.dto.PageDTO;
import com.farm.dto.ReviewBoardDTO;
import com.farm.service.ReviewBoardService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ReviewBoardController {

	
	@Autowired
	ReviewBoardService dao;
	
	//목록
	@GetMapping("/guest/review/list.do")
	//HttpServletRequest : 사용자가 웹 페이지에서 서버에게 요청한 내용을 다 들고 있는 객체
	public String list(Model model, HttpServletRequest req,
			ReviewBoardDTO reviewboardDTO, PageDTO pageDTO) {
		
		
		//무한스크롤로 전체 목록보기 
		 int pageSize = 20;
	        int pageNum = req.getParameter("pageNum") == null
	            ? 1
	            : Integer.parseInt(req.getParameter("pageNum"));

	        int start = (pageNum - 1) * pageSize + 1;
	        int end   = pageNum * pageSize;
	        pageDTO.setStart(start);
	        pageDTO.setEnd(end);
		
		/*
		string이 key고 object가 value인 Map자료구조를 만든다.*/
		Map<String, Object> maps = new HashMap<String, Object>();
		
		//maps.put("totalCount", totalCount);
		maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
		
		ArrayList<ReviewBoardDTO> lists = dao.listPage(pageDTO);
		model.addAttribute("lists", lists);
		
		//페이지 네비게이션 바를 HTM
		//String pagingImg = com.edu.springboot.utils.PagingUtil.pagingImg(
				//totalCount, pageSize, blockPage, pageNum, 
				//req.getContextPath()+"/list.do?");
		//model.addAttribute("pagingImg", pagingImg);
		
		return "test/list";
	}
	
	@GetMapping("/guest/review/view.do")
	//DTO를 사용해서 model이라는 공간에 넘겨줌
	public String view(HttpServletRequest req ,Model model, ReviewBoardDTO reviewboardDTO) {
		
		String id = req.getParameter("review_id");
		ReviewBoardDTO dto = dao.selectView(reviewboardDTO.getReview_id());
		model.addAttribute("review", dto);
		
		//사용자가 선택한 글의 상세 정보를 가져오기 
		reviewboardDTO = dao.view(reviewboardDTO);
		//화면에 줄바꿈이 잘 보이도록해줌
		reviewboardDTO.setContent(reviewboardDTO.getContent()
					.replace("\r\n", "<br/>"));
		//화면에서 글 정보를 쓸 수 있게 넘겨주는 작업
		model.addAttribute("reviewboardDTO", reviewboardDTO);
		
		return "boardview";
	}
	
	@GetMapping("/buyer/review/write.do")
	   public String reviewWrite(Model model) {
	      return "test/write";
	   }
	
	//쓰기
	@PostMapping("/buyer/review/write.do")
	public String write(ReviewBoardDTO reviewboardDTO, Model model, @AuthenticationPrincipal CustomUserDetails userDetails) {
		
		//memberDTO을 가져옴
		MemberDTO member = userDetails.getMemberDTO();
		// 로그인 된 아이디를 가져옴
		reviewboardDTO.setMember_id(member.getMember_id());
		reviewboardDTO.setProd_id((long) 1);
		int result = dao.write(reviewboardDTO);
		System.out.println("글쓰기결과 : " + result);
		
		return "redirect:/guest/review/list.do";
	}

	//수정
	@GetMapping("/buyer/review/edit.do")
	public String boardEditGet(Model model, ReviewBoardDTO reviewboardDTO) {
		//열람에서 사용했던 메서드를 그대로 사용
		reviewboardDTO = dao.view(reviewboardDTO);
		model.addAttribute("reviewboardDTO", reviewboardDTO);
		return "edit";
	}
	
	//수정2 : 사용자가 입력한 내용을 전송하여 update 처리
	@PostMapping("/buyer/review/edit.do")
	public String boardEditPost(ReviewBoardDTO reviewboardDTO) {
		
		//수정 후 결과는 int형으로 반환됨
		int result = dao.edit(reviewboardDTO);
		System.out.println("글 수정 결과 : " + result);
		//수정이 완료되면 열람페이지로 이동. 일련번호가 파라미터로 전달됨
		return "redirect:view.do?reviw_id=" + reviewboardDTO.getReview_id();
	}
	
	
	
}
