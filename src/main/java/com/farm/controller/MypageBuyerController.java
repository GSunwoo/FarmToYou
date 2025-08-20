package com.farm.controller;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.farm.config.CustomUserDetails;
import com.farm.dto.AddressDTO;
import com.farm.dto.MemberDTO;
import com.farm.dto.ProductDTO;
import com.farm.dto.ReviewBoardDTO;
import com.farm.service.IMemberService;
import com.farm.service.IMypageService;

@Controller
public class MypageBuyerController {
	
	@Autowired
	IMypageService mypageDAO;
	@Autowired
	IMemberService memDAO;
	
	@GetMapping("/mypage.do")
	public String mypageMapper(@AuthenticationPrincipal CustomUserDetails userDetails) {
		MemberDTO member = userDetails.getMemberDTO();
		if(member.getUser_type().equals("ROLE_BUYER")) {
			return "redirect:/buyer/mypage.do";
		}
		else if(member.getUser_type().equals("ROLE_ADMIN")) {
			return "redirect:/admin/mypage.do";
		}
		else {
			return "redirect:/seller/mypage.do";
		}
	}
	
	@GetMapping("/buyer/mypage.do")
	public String buyerMypage(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
		if(userDetails!=null) {
			MemberDTO member = userDetails.getMemberDTO();
			Long member_id = member.getMember_id();
			int orderCnt = mypageDAO.getOrderCnt(member_id);
			int reviewCnt = mypageDAO.getReviewCnt(member_id);
			int inquiryCnt = mypageDAO.getInquiryCnt(member_id);
			model.addAttribute("member", member);
			model.addAttribute("orderCnt", orderCnt);
			model.addAttribute("reviewCnt", reviewCnt);
			model.addAttribute("inquiryCnt_buyer", inquiryCnt);
		}
		return "buyer/mypage";
	}
	
	
	@GetMapping("/buyer/address/list.do")
	public String buyerAddress(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
		
		MemberDTO member = userDetails.getMemberDTO();
		Long member_id = member.getMember_id();
		AddressDTO address = memDAO.selectAddress(member_id);
		
		model.addAttribute("AddressDTO", address);
		model.addAttribute("member", member);
		
		return "buyer/delivery-destination";
	}
	
	@PostMapping("/buyer/address/write.do")
	public ResponseEntity<AddressDTO> addAddress(@RequestBody AddressDTO addressDTO,
				@AuthenticationPrincipal CustomUserDetails userDetails){
		MemberDTO member = userDetails.getMemberDTO();
		Long member_id = member.getMember_id();
		
		addressDTO.setMember_id(member_id);
		int result = memDAO.insertAddress(addressDTO);
		
		return ResponseEntity.ok(addressDTO);
	}
	
	@PostMapping("/buyer/address/update.do")
	public ResponseEntity<Long> updateAddress(@RequestBody Long addr_id,
			@AuthenticationPrincipal CustomUserDetails userDetails){
		MemberDTO member = userDetails.getMemberDTO();
		Long member_id = member.getMember_id();
		
		// 멤버의 모든 address 전체 main 0으로 변경
		int resultZero = memDAO.updateMainToZero(member_id);
		// 메인 지정
		int resultMain = memDAO.updateMain(addr_id);
		
		return ResponseEntity.ok(addr_id);
	}
	
	@GetMapping("/buyer/myPageList")
	public String myPageList() {
		return "buyer/myPageList";
	}
	
	@GetMapping("/buyer/member-info")
    public String member_info1() {
        return "buyer/member-info";
    }
	
	@GetMapping("/buyer/reviewManagement")
    public String reviewManagement1() {
        return "buyer/reviewManagement";
    }
	
}
