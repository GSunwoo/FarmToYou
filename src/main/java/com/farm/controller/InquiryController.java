package com.farm.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.farm.config.CustomUserDetails;
import com.farm.dto.CommentsDTO;
import com.farm.dto.InquiryDTO;
import com.farm.dto.PageDTO;
import com.farm.service.ICommentsService;
import com.farm.service.IInquiryService;
import com.farm.service.IProductService;

import jakarta.servlet.http.HttpServletRequest;
import utils.PagingUtil;

@Controller
public class InquiryController {

	@Autowired
	IInquiryService inqDao;

	@Autowired
	ICommentsService comDao;
	
	// 문의 생성
	@GetMapping("/buyer/inquiryForm.do")
	public String inquiry1(@RequestParam("prod_id") Long prod_id, @RequestParam("prod_name") String prod_name,
			Model model, @AuthenticationPrincipal CustomUserDetails userDetails) {

		Long member_id = userDetails.getMemberDTO().getMember_id();
		String user_id = userDetails.getUsername();
		model.addAttribute("member_id", member_id);
		model.addAttribute("user_id", user_id);
		model.addAttribute("prod_name", prod_name);
		model.addAttribute("prod_id", prod_id);

		return "buyer/inquiryForm";
	}

	@PostMapping("/buyer/inquiryForm.do")
	public String inquiry2(InquiryDTO inquiryDTO, @AuthenticationPrincipal CustomUserDetails userDetails) {
		Long member_id = userDetails.getMemberDTO().getMember_id();
		inquiryDTO.setMember_id(member_id);
		inquiryDTO.setUser_id(userDetails.getUsername());

		int result = inqDao.insertInq(inquiryDTO);
		if (result == 0) {
			System.out.println("입력에 실패했습니다.");
		}

		return "redirect:/inquiryList.do";
	}

	// 문의목록
	@GetMapping("/inq/inquiryList.do")
	public String inquiry3(Model model, PageDTO pageDTO, HttpServletRequest req,
			@AuthenticationPrincipal CustomUserDetails userDetails) {

		Long member_id = userDetails.getMemberDTO().getMember_id();
		
		String type = userDetails.getMemberDTO().getUser_type().substring(5).toLowerCase();
		
		pageDTO.setMember_id(member_id);			

		int totalCount;
		if(type.equals("buyer")) {
			totalCount = inqDao.getTotalCount1(pageDTO);			
		}
		else {
			totalCount = inqDao.getTotalCount2(member_id);
		}
		int pageSize = 10;
		int blockPage = 5;
		int pageNum = (req.getParameter("pageNum") == null || req.getParameter("pageNum").equals("")) ? 1
				: Integer.parseInt(req.getParameter("pageNum"));
		int start = (pageNum - 1) * pageSize + 1;
		int end = pageNum * pageSize;
		pageDTO.setStart(start);
		pageDTO.setEnd(end);

		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("totalCount", totalCount);
		maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);

		ArrayList<InquiryDTO> list;
		
		if(type.equals("buyer")) {
			list = inqDao.selectInq1(pageDTO);			
		}
		else {
			list = inqDao.selectInq2(member_id);
		}
		model.addAttribute("inquiries", list);

		String pagingImg = PagingUtil.pagingImg(totalCount, pageSize, blockPage, pageNum,
				req.getContextPath() + "/inq/inquiryList.do?");
		model.addAttribute("pagingImg", pagingImg);

		return type+"/inquiryList";
	}

// 상세보기
	@GetMapping("/inq/inquiryDetail.do")
	public String inquiryDetail(@RequestParam("inquiry_id") Long inquiry_id, Model model,
			@AuthenticationPrincipal CustomUserDetails userDetails) {
		Long member_id = userDetails.getMemberDTO().getMember_id();

		String type = userDetails.getMemberDTO().getUser_type().substring(5).toLowerCase();
		
		InquiryDTO param = new InquiryDTO();
		param.setInquiry_id(inquiry_id);
		param.setMember_id(member_id); // 본인 글만 보게 하려면 유지

		InquiryDTO dto = inqDao.inquiryDetail(param); // 이미 Service/Mapper에 있음

		
		ArrayList<CommentsDTO> coms = comDao.selectComments(inquiry_id);
		
		model.addAttribute("coms", coms);
		model.addAttribute("login_id", member_id);
		// 상세 JSP에서 ${inquiry.*} 로 쓰셨으니 키 이름을 inquiry로 맞춤
		model.addAttribute("inquiry", dto);
		return type+"/inquiryDetail"; // 상세 JSP 파일명에 맞게
	}

	// 수정
	@GetMapping("/buyer/inquiryUpdate.do")
	public String updateInquiry(@RequestParam("inquiry_id") Long inquiry_id, Model model,
			@AuthenticationPrincipal CustomUserDetails userDetails) {
		Long member_id = userDetails.getMemberDTO().getMember_id();

		InquiryDTO param = new InquiryDTO();
		param.setInquiry_id(inquiry_id);
		param.setMember_id(member_id);

		InquiryDTO dto = inqDao.inquiryDetail(param);

		if (dto == null) {
			return "redirect:/inq/inquiryList.do";
		}

		model.addAttribute("inquiryDTO", dto);
		return "buyer/inquiryUpdate";
	}


	// 수정2 : 사용자가 입력한 내용을 전송하여 update 처리
	@PostMapping("/buyer/inquiryUpdate.do")
	public String updateInquiry(InquiryDTO inquiryDTO, @AuthenticationPrincipal CustomUserDetails userDetails) {
		Long member_id = userDetails.getMemberDTO().getMember_id();
		inquiryDTO.setMember_id(member_id);
		int result = inqDao.updateInquiry(inquiryDTO);
		System.out.println("글수정결과:" + result);
		// return값 확인필요
		return "redirect:/inq/inquiryList.do";
	}

	@PostMapping("/buyer/inquiry/delete.do")
	public String deleteInquiry(@RequestParam("inquiry_id") Long inquiry_id,
			@AuthenticationPrincipal CustomUserDetails userDetails) {
		Long member_id = userDetails.getMemberDTO().getMember_id();

		int result = inqDao.deleteInquiry(inquiry_id, member_id);
		return "redirect:/buyer/inquiryList.do";
	}

}
