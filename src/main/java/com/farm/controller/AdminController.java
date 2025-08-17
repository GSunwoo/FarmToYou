package com.farm.controller;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.farm.dto.FarmDTO;
import com.farm.dto.ParameterDTO;
import com.farm.dto.ProductDTO;
import com.farm.service.IAdminConfirmService;
import com.farm.service.IProductService;

import jakarta.servlet.http.HttpServletRequest;
import oracle.jdbc.proxy.annotation.Post;


@Controller
public class AdminController {

	// 상품 DAO
	@Autowired
	IProductService prodDAO;
	
	// 승인 DAO
	@Autowired
	IAdminConfirmService confirmDAO;
	
	
	// 페이지 설정
	@Value("${board.pageSize}")
	private int pageSize;
	@Value("${board.blockPage}")
	private int blockPage;
	
	// 관리자 메인 페이지
	@GetMapping("/admin/mypage.do")
	public String adminMypage() {
		return "admin/mypage";
	}
	
	// 전체 상품 목록
	@GetMapping("/admin/product/list.do")
	public String adminProduct(Model model, ParameterDTO parameterDTO, HttpServletRequest req) {
		
		// 페이징처리
		int pageNum = (req.getParameter("pageNum") == null
				|| req.getParameter("pageNum").equals(""))
				? 1 : Integer.parseInt(req.getParameter("pageNum"));
		parameterDTO.setStart((pageNum - 1) * pageSize + 1);
	    parameterDTO.setEnd(pageNum * pageSize);
	    
	    // 페이징처리된 상품리스트 가져오기
		ArrayList<ProductDTO> products = prodDAO.selectProduct(parameterDTO);
		// 상품리스트 전달
		model.addAttribute("products", products);
		
		// 요청중인 상품리스트 가져오기
		List<ProductDTO> requestProducts = confirmDAO.selectRequestProducts();
		// 전달
		model.addAttribute("requestProducts", requestProducts);
		
		// 페이징 관련 변수 Map으로 전달
		int totalCount = prodDAO.getTotalCount(parameterDTO);
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("totalCount", totalCount);
		paramMap.put("pageSize", pageSize);
		paramMap.put("pageNum", pageNum);
		model.addAttribute("paramMap", paramMap);
		

		return "admin/product";
	}
	
	@GetMapping("/admin/product/view.do")
	public String adminProdView(@RequestParam("prod_id") Long prod_id, Model model) {
		
		// 파라미터로 받은 prod_id를 통해 ProductDTO 불러오기
		ProductDTO product = prodDAO.selectProductView(prod_id);
		// 가져온 ProductDTO 전달
		model.addAttribute("product", product);
		
		return "admin/productView";
	}
	
	@PostMapping("/admin/product/confirm.do")
	public String adminProdConfirm(@RequestParam("prod_id") Long prod_id) {
		confirmDAO.confirmProduct(prod_id);
		return "redirect:admin/productView?prod_id="+prod_id;
	}
	
	@GetMapping("/admin/product/delete.do")
	public String adminDelete(@RequestParam("prod_id") Long prod_id) {
		// 파라미터로 받은 prod_id를 통해 삭제
		prodDAO.productDelete(prod_id);
		// 목록 페이지로 이동
		return "redirect:/admin/product/list.do";
	}
	
	
	// 농장 목록
	@GetMapping("/admin/farm/request/list.do")
	public String adminFarm(Model model, ParameterDTO parameterDTO, HttpServletRequest req) {
		// 등록요청 중인 농장 가져오기
		List<FarmDTO> farms = confirmDAO.selectRequestFarms();
		// model 객체를 통해 전달
		model.addAttribute("farms", farms);
		
		return "admin/farm";
	}
	
	// 회원 목록
	@GetMapping("/admin/member/list.do")
	public String adminMember() {
		return "admin/member";
	}
	
	// 리뷰 목록
	@GetMapping("/admin/review/list.do")
	public String adminReview() {
		return "admin/review";
	}
	
	// 문의 목록
	@GetMapping("/admin/inquiry/list.do")
	public String adminiInquiry() {
		return "admin/inquiry";
	}
	
	// 1:1문의 페이지
	// 여기는 추후에 react로 바꿀 예정
	@GetMapping("/admin/onetoone/list.do")
	public String adminOneToOne() {
		return "admin/onetoone";
	}
}
