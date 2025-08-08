package com.farm.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.farm.dto.MemberDTO;
import com.farm.dto.ParameterDTO;
import com.farm.dto.ProductDTO;
import com.farm.service.IProductService;

import jakarta.servlet.http.HttpServletRequest;
import utils.PagingUtil;



@Controller
public class ProductController {
	
	@Value("${board.pageSize}")
	private int pageSize;
	
	@Value("${board.blockPage}")
	private int blockPage;
	
	
	@Autowired
	IProductService proDao;
	
	@GetMapping("/seller/write.do")
	public String sellerWrite() {
		
		return "seller/write";
	}
	@PostMapping("/seller/write.do")
	public String sellerWrite2(MemberDTO memberDTO) {
		
		return "redirect:/myPageMain";
	}
	
	@GetMapping("/guest/productList.do")
	public String productList(HttpServletRequest req,
			ProductDTO productDTO, Model model,
			ParameterDTO parameterDTO) {
		
		
		
		int pageNum = (req.getParameter("pageNum") == null
				|| req.getParameter("pageNum").equals(""))
				? 1 : Integer.parseInt(req.getParameter("pageNum"));
		
		parameterDTO.setStart((pageNum - 1) * pageSize + 1);
	    parameterDTO.setEnd(pageNum * pageSize);
		
	    
	    if(parameterDTO.getSearchWord() != null && 
	    		!parameterDTO.getSearchWord().trim().equals("")) {
	    	parameterDTO.setSearchWords(Arrays.asList(parameterDTO.getSearchWord().trim().split(" ")));
	    }
		
		
		int totalCount = proDao.getTotalCount(parameterDTO);
		System.out.println("totalcount" + totalCount);
		ArrayList<ProductDTO> lists = proDao.selectProduct(parameterDTO);
		 Map<String, Object> paramMap = new HashMap<>();
		 	paramMap.put("totalCount", totalCount);
		    paramMap.put("pageSize", pageSize);
		    paramMap.put("pageNum", pageNum);
		    
		model.addAttribute("paramMap", paramMap);
		
		
		model.addAttribute("lists", lists);
		if(lists.isEmpty()) {			
			System.out.println("리스트 빔?");
		}
		
		String pagingImg = PagingUtil.pagingImg(
				totalCount, pageSize, blockPage, pageNum, 
				req.getContextPath()+"/list.do?");
		
		return "Productpage";
	}
	
	@GetMapping("/guest/Detailpage.do")
	public String productView(ProductDTO productDTO, Model model) {
		
		productDTO = proDao.selectProductView(productDTO);
		productDTO.setProd_content(productDTO.getProd_content()
				.replace("\r\n", "<br/>"));
		model.addAttribute("productDTO", productDTO);
		
		return "Detailpage";
	}
	
	
	
}
