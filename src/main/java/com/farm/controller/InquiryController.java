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

import com.farm.config.login.CustomUserDetails;
import com.farm.dto.InquiryDTO;
import com.farm.dto.PageDTO;
import com.farm.dto.ParameterDTO;
import com.farm.service.IInquiryService;

import jakarta.servlet.http.HttpServletRequest;
import utils.PagingUtil;

@Controller
public class InquiryController {

   @Autowired
   IInquiryService inqDao;

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
   public String inquiry2(InquiryDTO inquiryDTO) {
      
      int result = inqDao.insertInq(inquiryDTO);
      if (result == 0) {
         System.out.println("입력에 실패했습니다.");
      }
      
      return "inquiryForm";
   }
   
   // 문의목록
   @GetMapping("/buyer/inquiryList.do")
   public String inquiry3(@RequestParam("member_id") Long member_id, Model model, PageDTO pageDTO,
         HttpServletRequest req) {
      
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
      
      ArrayList<InquiryDTO> list = inqDao.selectInq(member_id);
      model.addAttribute("list", list);
      
      String pagingImg = 
            PagingUtil.pagingImg(totalCount, pageSize, blockPage, pageNum,
                  req.getContextPath()+"/list.do?");
      model.addAttribute("pagingImg", pagingImg);
      
      return "buyer/inquiryList";
   }

   // 수정
   @GetMapping("/buyer/inquiryUpdate.do")
   public String updateInquiry(Model model, @RequestParam("title") String title, @RequestParam("content") String content) {
      model.addAttribute("title", title);
      model.addAttribute("content", content);
      return "buyer/inquiryList";
   }

   // 수정2 : 사용자가 입력한 내용을 전송하여 update 처리
   @PostMapping("/buyer/inquiryUpdate.do")
   public String updateInquiry(@RequestParam("title") String title, @RequestParam("content") String content) {
      int result = inqDao.updateInquiry("title", "content");
      System.out.println("글수정결과:"+ result);
      //return값 확인필요
      return "redirect:/buyer/inquiryList.do?inquiry_id=";
   }

   @PostMapping("/buyer/inquiry/delete.do")
   public String deleteInquiry(@RequestParam("inquiry_id") Long inquiry_id) {
      int result = inqDao.deleteInquiry(inquiry_id);
      return "redirect:inquiryList.do";
   }
   

}