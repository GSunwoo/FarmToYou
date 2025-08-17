package com.farm.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.farm.config.login.CustomUserDetails;
import com.farm.dto.MemberDTO;
import com.farm.dto.ParameterDTO;
import com.farm.dto.ProductDTO;
import com.farm.dto.ProductImgDTO;
import com.farm.service.IProductImgService;
import com.farm.service.IProductService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import jakarta.transaction.Transactional;
import utils.PagingUtil;
import utils.UploadUtils;



@Controller
public class ProductController {
	
	@Value("${board.pageSize}")
	private int pageSize;
	
	@Value("${board.blockPage}")
	private int blockPage;
	
	@Value("${board.bestSize}")
	private int bestSize;
	
	@Autowired
	IProductService proDao;
	
	@Autowired
	IProductImgService imgDao;
	
	@GetMapping("/seller/write.do")
	public String sellerWrite() {
		return "seller/productWrite";
	}
	@PostMapping("/seller/write.do")
	public String sellerWrite2(
			@AuthenticationPrincipal CustomUserDetails userDetails,
			@RequestParam("main_idx") Long main_idx,
			@RequestParam("image") List<MultipartFile> files,
			ProductDTO productDTO) {
		productDTO.setMember_id(userDetails.getMemberDTO().getMember_id());
		int prodResult = proDao.productWrite(productDTO);
		Long prod_id = productDTO.getProd_id();
		Long last_idx = null;
		
		if(!files.isEmpty()) {			
			insertImg(prod_id, main_idx, files, last_idx);
		}
		
		

		return "redirect:/guest/Detailpage.do?prod_id="+prod_id;
	}
	

	public void insertImg(Long prod_id, Long main_idx,
			List<MultipartFile> files, Long last_idx) {
		
		try {
			
			String uploadDir = ResourceUtils.getFile(
					"classpath:static/uploads/prodimg/prod_id").toPath().toString();
			System.out.println("저장경로 : " + uploadDir);
			File dir = new File(uploadDir, String.valueOf(prod_id));

			if(!dir.exists()) {
				dir.mkdirs();
			}

			
			Long i = (last_idx != null) ? last_idx + 1 : 1L;
			for(MultipartFile file : files) {
				if (file.isEmpty()) {
					System.out.println("파일 빔?");
					continue;
				}
	
				String savedFileName =
						UploadUtils.getNewFileName(file.getOriginalFilename());
				File dest = new File(dir, savedFileName);
				file.transferTo(dest);
				
				 System.out.println("저장 성공: " + dest.getAbsolutePath());
				
				ProductImgDTO productImgDTO = new ProductImgDTO();
				
				productImgDTO.setFilename(savedFileName);
				productImgDTO.setIdx(i);
				productImgDTO.setProd_id(prod_id);
				
				
				if(i == main_idx) {
					productImgDTO.setMain_idx(1);
				}
				else {
					productImgDTO.setMain_idx(0);
				}
				
				int insertResult = imgDao.insertImg(productImgDTO);
				
				if(insertResult == 1) {
					System.out.printf("전체 파일 %d 중 %d번째 파일업로드 성공", files.size(), i);
				}
				else {
					System.err.printf("전체 파일 %d 중 %d번째 파일업로드 실패", files.size(), i);
				}
				i++;
			}
			
		}
		catch (Exception e) {
			System.out.println("이미지 업로드 실패 : ");
			e.printStackTrace();
		}
		
		

	}
	
	
	@GetMapping("/seller/mylist.do")
	public String mylist(@AuthenticationPrincipal CustomUserDetails userDetails,
			Model model) {
		
		Long member_id = userDetails.getMemberDTO().getMember_id();
		
		ArrayList<ProductDTO> mylist = proDao.selectMyprod(member_id);
		model.addAttribute("mylist", mylist);
		
		
		return "seller/myprodlist";
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
		//베스트상품 불러오기
		parameterDTO.setEnd(bestSize);
		ArrayList<ProductDTO> bests = proDao.selectBestProd(parameterDTO);
		model.addAttribute("bests", bests);
		//베스트상품 끝
		
		
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
	public String productView(ProductDTO productDTO, Model model,
			@RequestParam("prod_id") Long prod_id,
			ProductImgDTO productImgDTO) {
		
		productDTO = proDao.selectProductView(prod_id);
		productDTO.setProd_content(productDTO.getProd_content()
				.replace("\r\n", "<br/>"));
		
		model.addAttribute("productDTO", productDTO);
				
		
		// 이미지 불러오기 시작
		ArrayList<ProductImgDTO> imglist = imgDao.selectImg(prod_id);
		ProductImgDTO main = imgDao.selectMain(prod_id);
		model.addAttribute("main", main);
		model.addAttribute("imglist", imglist);
		
		
		
		return "Detailpage";
	}
	
	
	@GetMapping("/seller/update.do")
	public String productUpdate(
			@AuthenticationPrincipal CustomUserDetails userDetails,
			@RequestParam("prod_id") Long prod_id,
			ProductDTO productDTO, Model model) {
		Long login_id = userDetails.getMemberDTO().getMember_id();
		
		productDTO = proDao.selectProductView(prod_id);
		Long write_id = productDTO.getMember_id();
		

		
		
		try {
			
			if(login_id == write_id && login_id != null && write_id != null) {
				model.addAttribute("productDTO", productDTO);
				ArrayList<ProductImgDTO> imglist = imgDao.selectAllImg(prod_id);
				model.addAttribute("last_idx", imglist.size());
				model.addAttribute("imglist", imglist);
				return "seller/productUpdate";
			}
			
			
		}
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("로긴아이디 : " + ((login_id!=null) ? login_id : "null"));
			System.out.println("작성자아이디 : " + ((write_id!=null) ?login_id : "null"));
		}
			
			
		return "redirect:/";
	}
	
	@PostMapping("/seller/update.do")
	@ResponseBody
	public int productUpdate2(ProductDTO productDTO,
	        @RequestParam("main_idx") Long main_idx,
	        @RequestParam("image") List<MultipartFile> files,
	        @RequestParam("last_idx") Long last_idx) { 
		
		productDTO.setProd_content(productDTO.getProd_content()
				.replaceAll("\r\n", "<br/>"));
	    int prod_result = proDao.productUpdate(productDTO);
	    Long prod_id = productDTO.getProd_id();


	    
	    	
	    /*
	    이미지 변경 과정 :
	    	수정폼으로 이동 및 게시물 불러오기(완료)
	    	수정폼에서 게시물 및 이미지 추가 및 삭제
	    		-> 삭제 구현방법 삭제버튼에 인덱스를 넣고 버튼클릭시 인덱스가 전달되고
	    			인덱스에 해당하는 이미지 삭제 => prod_id와 idx를 조건으로 걸어야될듯
	    			만약 이미지가 추가 된다면? 삭제를 비동기로 바로 처리하게 하면될듯?
	    			또다른문제. 인덱스는 기존 이미지들의 인덱스 다음 숫자를 오게할 수 있을것인가? 
	    			가능한지 확인해봐야됨
	    	메인인덱스 수정구현 
	    		-> 방식은 모든main인덱스를 0으로 만들고
	    			프론트에서 받은 main_idx의 사진의 메인인덱스 활성화(1)
	    	
	     */
	    if(!files.isEmpty()) {
	    	insertImg(prod_id, main_idx, files, last_idx);	    	
	    }
	    
	    int UMI = updateMainImage(prod_id, main_idx);
	    if(UMI > 0) System.out.println("메인 이미지 업데이트 완료");

	    
	    
	    if (prod_result == 1) {
	        System.out.println("상품 수정에 성공했습니다.");
	        return 200;
	    } else {
	        System.out.println("상품 수정신청에 실패했습니다. : " + prod_result);
	        return 500;
	    }

	}
	
	public int updateMainImage(Long prod_id, Long main_idx) {
		
		int zero = imgDao.makeZero(prod_id);
		int result = 0;
		if(zero > 0) {
			result = imgDao.updateMainImg(prod_id, main_idx);
		}
		return result;
	}
	
	
	@PostMapping("/seller/delete.do")
	public String deleteProduct(@RequestParam("prod_id") Long prod_id){
		int prod_result = proDao.productDelete(prod_id);
		int img_result = imgDao.deleteAllImg(prod_id);
		if(prod_result == 1 && img_result == 1) {
			System.out.println("상품 삭제가 완료되었습니다 : " + prod_result);
		}
		else {
			System.out.println("상품 삭제에 실패하였습니다. : " + prod_result);
		}
		return "seller/myprodlist";
	}
	
	
	@PostMapping("/seller/deleteImg.do")
	@ResponseBody
	public String deleteImg(
	        @RequestParam("prod_id") Long prod_id,
	        @RequestParam("idx") Long idx) {
	    try {
	        int result = imgDao.deleteImg(prod_id, idx);
	        return (result > 0) ? "success" : "fail";
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "error";
	    }
	}
	
	
}
