package com.farm.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
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
import com.farm.dto.MemberDTO;
import com.farm.dto.PageDTO;
import com.farm.dto.ParameterDTO;
import com.farm.dto.ProductDTO;
import com.farm.dto.ReviewBoardDTO;
import com.farm.service.IAdminConfirmService;
import com.farm.service.IMemberService;
import com.farm.service.IProductService;
import com.farm.service.ReviewBoardService;

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

	// 리뷰 DAO
	@Autowired
	ReviewBoardService reviewDAO;

	// 멤버 DAO
	@Autowired
	IMemberService memDAO;
	
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
		int pageNum = (req.getParameter("pageNum") == null || req.getParameter("pageNum").equals("")) ? 1
				: Integer.parseInt(req.getParameter("pageNum"));
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
		return "redirect:admin/productView?prod_id=" + prod_id;
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
	public String adminMember(PageDTO pageDTO, HttpServletRequest req, Model model) {
		// 페이징처리
		int pageSize = 20;
		int pageNum = req.getParameter("pageNum") == null ? 1 : Integer.parseInt(req.getParameter("pageNum"));

		int start = (pageNum - 1) * pageSize + 1;
		int end = pageNum * pageSize;
		pageDTO.setStart(start);
		pageDTO.setEnd(end);
		
		List<MemberDTO> memberList = memDAO.getAllMember(pageDTO);
		
		String userType = req.getParameter("user_type");
		if (userType!=null&&!userType.equals("ALL")) userType = "ROLE_"+userType;
		
		Iterator<MemberDTO> it = memberList.iterator();
		while (it.hasNext()) {
			if (userType==null||userType.equals("ALL")) break;
		    MemberDTO member = it.next();
		    System.err.println("userType:" + userType);
		    System.err.println("user_type:" + member.getUser_type());
		    if (!member.getUser_type().equals(userType)) {
		        it.remove(); // 안전하게 삭제 가능
		    }
		}
		
		model.addAttribute("memberList", memberList);
		return "admin/member";
	}

	// 리뷰 목록
	@GetMapping("/admin/review/list.do")
	public String adminReview(PageDTO pageDTO, HttpServletRequest req, Model model) {
		// 페이징처리
		int pageSize = 20;
		int pageNum = req.getParameter("pageNum") == null ? 1 : Integer.parseInt(req.getParameter("pageNum"));

		int start = (pageNum - 1) * pageSize + 1;
		int end = pageNum * pageSize;
		pageDTO.setStart(start);
		pageDTO.setEnd(end);
		// 리뷰 받아오기
		ArrayList<ReviewBoardDTO> reviews = reviewDAO.listPage(pageDTO);
		for (int i = 0; i < reviews.size(); i++) {
			ReviewBoardDTO review = reviews.get(i);
			review.setReview_like(reviewDAO.countLike(review.getReview_id()));
		}
		// 모델객체로 리뷰리스트 전달
		model.addAttribute("reviewList", reviews);
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
