package com.farm.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.farm.config.CustomUserDetails;
import com.farm.dto.CommentDTO;
import com.farm.dto.InquiryDTO;
import com.farm.service.ICommentService;
import com.farm.service.IInquiryService;
import com.farm.service.IProductService;


@RestController
public class CommentController {
	
	@Autowired
	ICommentService comDao;
	@Autowired
	IProductService proDao;
	@Autowired
	IInquiryService inqDao;
	
	@PostMapping("seller/insertComment")
	@ResponseBody
	public int insertComment(CommentDTO commentDTO, 
			@AuthenticationPrincipal CustomUserDetails ud) {
		
		Long inquiry_id = commentDTO.getInquiry_id();
		Long prod_id = inqDao.selectProd_id(inquiry_id);
		
		Long login_user = ud.getMemberDTO().getMember_id();
		Long prod_mem_id = proDao.selectMember_id(prod_id);
		if (login_user == prod_mem_id) {
			commentDTO.setMember_id(login_user);
			int result = comDao.insertComment(commentDTO);
			if(result > 0) {
				return 200;			
			}
			return 500;	
		}
			return 403;
	}
	
	@GetMapping("seller/openUpdateForm")
	@ResponseBody
	public Map<String, String> openUpdateForm(
			@AuthenticationPrincipal CustomUserDetails ud,
			@RequestParam("com_id") Long com_id){
		Map<String, String> map = new HashMap<>();
		
		Long login_id = ud.getMemberDTO().getMember_id();
		CommentDTO commentDTO = comDao.getComment(com_id);
		Long writer_id = commentDTO.getMember_id();
		
		
		if(login_id == writer_id) {
			map.put("code", "200");
			map.put("content", commentDTO.getCom_content());
			map.put("com_id", com_id.toString());
			return map;			
		}
		else {			
			map.put("code", "403");
			return map; 
		}
		
	}
	
	@PostMapping("seller/updateComment")
	@ResponseBody
	public int updateComment(CommentDTO commentDTO) {
		int result = comDao.updateComment(commentDTO);
		if(result > 0) {
			return 200;			
		}
		return 500;	
	}
	
	@GetMapping("seller/deleteComment")
	@ResponseBody
	public int updateComment(@RequestParam("com_id") Long com_id) {
		int result = comDao.deleteComment(com_id);
		if(result > 0) {
			return 200;			
		}
		return 500;	
	}
}
