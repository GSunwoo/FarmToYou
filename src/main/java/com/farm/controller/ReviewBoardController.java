package com.farm.controller;




import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.farm.dto.PageDTO;
import com.farm.dto.ReviewBoardDTO;
import com.farm.service.ReviewBoardService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/api/reviews")
public class ReviewBoardController {

	//메인
	@RequestMapping("/")
	public String main() {
		return "main";
	}
	
	@Autowired
	ReviewBoardService dao;
	@Autowired
	private ReviewBoardService reviewBoardService;
	
	
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
		/* req를 통해서
		 폼(form)에서 입력한 값,
		 요청 주소, 쿠키, 헤더, IP주소 등을 가져올 수 있다.*/
		//pageNum을 파라미터 값으로 가져온다 . 이 값이 null이거나 
		//빈값이면 값을 1로 사용 
		
		/*
		string이 key고 object가 value인 Map자료구조를 만든다.*/
		Map<String, Object> maps = new HashMap<String, Object>();
		
		//maps.put("totalCount", totalCount);
		maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
		
		ArrayList<ReviewBoardDTO> lists = dao.listPage(reviewboardDTO);
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
		//조회수 증가
		dao.visitCountPlus(reviewboardDTO);
		//화면에 줄바꿈이 잘 보이도록해줌
		reviewboardDTO.setContent(reviewboardDTO.getContent()
					.replace("\r\n", "<br/>"));
		//화면에서 글 정보를 쓸 수 있게 넘겨주는 작업
		model.addAttribute("reviewboardDTO", reviewboardDTO);
		
		return "boardview";
	}
	
	
	//쓰기
	@GetMapping("/guest/review/write.do")
	public String write(Model model, HttpServletRequest req) {
		
		String member_id = req.getParameter("member_id");
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		int result = dao.write(member_id, title, content);
		System.out.println("글쓰기결과 : " + result);
		
		return "boardwrite";
	}
	
	
	
	//수정
	@GetMapping("/guest/review/edit.do")
	public String boardEditGet(Model model, ReviewBoardDTO reviewboardDTO) {
		//열람에서 사용했던 메서드를 그대로 사용
		reviewboardDTO = dao.view(reviewboardDTO);
		model.addAttribute("reviewboardDTO", reviewboardDTO);
		return "edit";
	}
	
	//수정2 : 사용자가 입력한 내용을 전송하여 update 처리
	@PostMapping("/guest/review/edit.do")
	public String boardEditPost(ReviewBoardDTO reviewboardDTO) {
		
		//수정 후 결과는 int형으로 반환됨
		int result = dao.edit(reviewboardDTO);
		System.out.println("글 수정 결과 : " + result);
		//수정이 완료되면 열람페이지로 이동. 일련번호가 파라미터로 전달됨
		return "redirect:view.do?reviw_id=" + reviewboardDTO.getReview_id();
	}
	
	
	
}
