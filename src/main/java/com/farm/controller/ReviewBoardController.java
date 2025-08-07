package com.farm.controller;




import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.farm.dto.PageDTO;
import com.farm.dto.ReviewBoardDTO;
import com.farm.service.ReviewBoardService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ReviewBoardController {

	//메인
	@RequestMapping("/")
	public String main() {
		return "main";
	}
	
	@Autowired
	ReviewBoardService dao;
	
	
	//목록
	@GetMapping("/lsit.do")
	//HttpServletRequest : 사용자가 웹 페이지에서 서버에게 요청한 내용을 다 들고 있는 객체
	public String list(Model model, HttpServletRequest req,
			ReviewBoardDTO reviewboardDTO, PageDTO pageDTO) {
		
		int totalCount = dao.getTotalCount(reviewboardDTO);
		
		int pageSize = 20; //페이지 당 출력할 게시물 갯수
		int blockPage = 5; // 한 블록당 출력할 게시물이 몇개가 있는지
		
		/* req를 통해서
		 폼(form)에서 입력한 값,
		 요청 주소, 쿠키, 헤더, IP주소 등을 가져올 수 있다.*/
		//pageNum을 파라미터 값으로 가져온다 . 이 값이 null이거나 
		//빈값이면 값을 1로 사용 
		int pageNum = (req.getParameter("pageNum") == null
				|| req.getParameter("pageNum").equals(""))
				? 1 : Integer.parseInt(req.getParameter("pageNum"));

		int start = (pageNum-1) * pageSize + 1;
		int end = pageNum * pageSize;
		
		//계산의 결과는 DTO에 저장
		pageDTO.setStart(start);
		pageDTO.setEnd(end);
		
		/*
		string이 key고 object가 value인 Map자료구조를 만든다.*/
		Map<String, Object> maps = new HashMap<String, Object>();
		
		maps.put("totalCount", totalCount);
		maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
		
		return "boardlist";
	}
	
	//열람
	@GetMapping("/view.do")
	//DTO를 사용해서 model이라는 공간에 넘겨줌
	public String view(Model model, ReviewBoardDTO reviewboardDTO) {
		
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
	@GetMapping("/write.do")
	public String write(Model model, HttpServletRequest req) {
		
		String member_id = req.getParameter("member_id");
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		return "boardwrite";
	}
	
	
	//수정
	@GetMapping("/edit.do")
	public String edit() {
		return "boardedit";
	}
	
	
	
}
