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
import org.springframework.web.bind.annotation.RequestParam;

import com.farm.config.CustomUserDetails;
import com.farm.dto.InquiryDTO;
import com.farm.dto.PageDTO;
import com.farm.service.IInquiryService;

import jakarta.servlet.http.HttpServletRequest;
import utils.PagingUtil;

@Controller
public class InquiryController {

   @Autowired
   IInquiryService inqDao;
   
   //문의 생성
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
      
      return "redirect:/buyer/inquiryList.do";
   }
   
   // 문의목록
   @GetMapping("/buyer/inquiryList.do")
   public String inquiry3(Model model, PageDTO pageDTO,
         HttpServletRequest req, @AuthenticationPrincipal CustomUserDetails userDetails) {
	   
	  Long member_id = userDetails.getMemberDTO().getMember_id();
	   
	  pageDTO.setMember_id(member_id);
	   
      int totalCount = inqDao.getTotalCount(pageDTO);
      int pageSize = 10;
      int blockPage = 5;
      int pageNum = (req.getParameter("pageNum")==null
            || req.getParameter("pageNum").equals(""))
            ? 1 : Integer.parseInt(req.getParameter("pageNum"));
      int start = (pageNum-1) * pageSize + 1;
      int end = pageNum * pageSize;
      pageDTO.setStart(start);
      pageDTO.setEnd(end);
      

      
      Map<String, Object> maps = new HashMap<String, Object>();
      maps.put("totalCount", totalCount);
      maps.put("pageSize", pageSize);
      maps.put("pageNum", pageNum);
      model.addAttribute("maps", maps);
      
      ArrayList<InquiryDTO> list = inqDao.selectInq(pageDTO);
      model.addAttribute("inquiries", list);
      
      String pagingImg = 
            PagingUtil.pagingImg(totalCount, pageSize, blockPage, pageNum,
                  req.getContextPath()+"/buyer/inquiryList.do?");
      model.addAttribute("pagingImg", pagingImg);
      
      return "/buyer/inquiryList";
   }

   // 수정
   @GetMapping("/buyer/inquiryUpdate.do")
   public String updateInquiry(@RequestParam("inquiry_id") Long inquiry_id,
		   Model model, @AuthenticationPrincipal CustomUserDetails userDetails) {
	  Long member_id = userDetails.getMemberDTO().getMember_id();
	  
	  InquiryDTO param = new InquiryDTO();
	  param.setInquiry_id(inquiry_id);
	  param.setMember_id(member_id);
	  
	  InquiryDTO dto = inqDao.inquiryDetail(param);
	  
	  if (dto == null) {
		  return "redirect:/buyer/inquiryList.do";
	  }
	  
	  model.addAttribute("inquiryDTO", dto);
      return "buyer/inquiryUpdate";
   }

   // 수정2 : 사용자가 입력한 내용을 전송하여 update 처리
   @PostMapping("/buyer/inquiryUpdate.do")
   public String updateInquiry(InquiryDTO inquiryDTO, 
		   @AuthenticationPrincipal CustomUserDetails userDetails) {
	  Long member_id = userDetails.getMemberDTO().getMember_id();
	  inquiryDTO.setMember_id(member_id);
	   
      int result = inqDao.updateInquiry(inquiryDTO);
      System.out.println("글수정결과:"+ result);
      //return값 확인필요
      return "redirect:/buyer/inquiryList.do";
   }

   @PostMapping("/buyer/inquiry/delete.do")
   public String deleteInquiry(@RequestParam("inquiry_id") Long inquiry_id,
		   @AuthenticationPrincipal CustomUserDetails userDetails) {
	   Long member_id = userDetails.getMemberDTO().getMember_id();
	   
      int result = inqDao.deleteInquiry(inquiry_id, member_id);
      return "redirect:/buyer/inquiryList.do";
   }
   

}

