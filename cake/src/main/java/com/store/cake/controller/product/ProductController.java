package com.store.cake.controller.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.store.cake.dao.product.ProductDAO;
import com.store.cake.dto.product.ProductDTO;
import com.store.cake.dto.product.ProductSearchDTO;
import com.store.cake.util.FileUpload;
import com.store.cake.util.Paging;

@Controller
@RequestMapping("/product/")
public class ProductController {
	
	@Resource
	private ProductDAO dao;
	
	@RequestMapping("product.do")
	public String product(
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "sort", required = false, defaultValue = "P_ID DESC") String sort,
			@RequestParam(value = "result", required = false, defaultValue = "0") String result,
			Model model)
			throws Exception {

		// paging
		int totalCount = dao.getProductTotalCount();
		Paging paging = new Paging(pageIndex, totalCount, 5, 5);
		paging.pageHandling();

		// list setting
		HashMap map = new HashMap();
		map.put("startRow", paging.getStartRow());
		map.put("endRow", paging.getEndRow());
		map.put("sort", sort);
		
		// list
		List<ProductDTO> list = dao.getProductList(map);
		
		// model
		model.addAttribute("mode","list");
		model.addAttribute("paging", paging);
		model.addAttribute("sort", sort);
		model.addAttribute("list", list);
		model.addAttribute("result", result);
		
		return "product.product";

	}
	
	@RequestMapping("productSearch.do")
	public String productSearch(
				@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
				@RequestParam(value = "sort", required = false, defaultValue = "P_ID DESC") String sort,
				ProductSearchDTO search,
				Model model) throws Exception {
		
		Optional<ProductSearchDTO> opt = Optional.ofNullable(search);
		if (opt.isPresent()) {
			// paging
			int totalCount = dao.getSearchProductTotalCount(search);
			Paging paging = new Paging(pageIndex, totalCount, 5, 5);
			paging.pageHandling();
			
			// list setting
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			// list
			List<ProductDTO> list = dao.getProductSearchList(search);
			
			// model
			model.addAttribute("mode","search");
			model.addAttribute("paging", paging);
			model.addAttribute("sort", search.getSort());
			model.addAttribute("list", list);
			model.addAttribute("search", search);
			
		}else {
			System.out.println("null");
		}
		
		return "product.product";

	}
	
	@RequestMapping("productInsertForm.do")
	public String productInsertForm(
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "sort", required = false, defaultValue = "P_ID DESC") String sort,
			Model model)
			throws Exception {
		
		// model
		model.addAttribute("mode", "insert");
		model.addAttribute("pageIndex", pageIndex);
		model.addAttribute("sort", sort);

		return "product.productForm";

	}
	
	@RequestMapping("productInsert.do")
	public String productInsert(
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "sort", required = false, defaultValue = "P_ID DESC") String sort,
			@RequestParam MultipartFile file,
			ProductDTO dto,
			RedirectAttributes redirectAttributes,
			Model model) throws Exception {

		// name check
		HashMap map = new HashMap();
		map.put("p_name", dto.getP_name());
		String nameChk = dao.checkName(map);
		Optional<String> opt = Optional.ofNullable(nameChk);
		
		if (opt.isPresent()) {
			// send error
			model.addAttribute("mode", "insert");
			model.addAttribute("pageIndex", pageIndex);
			model.addAttribute("sort", sort);
			model.addAttribute("dto", dto);
			model.addAttribute("result", 0);
			
			return "product.productForm";

		} else {
			// file upload
			FileUpload fileUpload = new FileUpload();
			String fileName = fileUpload.uploadFile(file, "product");
			dto.setP_img(fileName);
			
			// insert
			dao.productInsert(dto);
			
			// model
			redirectAttributes.addAttribute("result", 1);

			return "redirect:product.do";
		}

	}

	@RequestMapping("productUpdateForm.do")
	public String productUpdateForm(
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "sort", required = false, defaultValue = "P_ID DESC") String sort,
			@RequestParam(value = "p_id") Integer p_id, Model model) throws Exception {
		
		//getInfo
		ProductDTO dto = dao.getProductInfo(p_id);
		
		//model
		model.addAttribute("mode", "update");
		model.addAttribute("pageIndex", pageIndex);
		model.addAttribute("sort", sort);
		model.addAttribute("dto", dto);

		return "product.productForm";

	}
	
	@RequestMapping("productUpdate.do")
	public String productUpdate(
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "sort", required = false, defaultValue = "P_ID DESC") String sort,
			@RequestParam MultipartFile file,
			ProductDTO dto,
			Model model) throws Exception {
			
			// name check
			HashMap map = new HashMap();
			map.put("p_name", dto.getP_name());
			map.put("p_id", dto.getP_id());
			String nameChk = dao.checkName(map);
			Optional<String> opt = Optional.ofNullable(nameChk);
			
			if (opt.isPresent()) {
				// send error
				model.addAttribute("mode", "update");
				model.addAttribute("pageIndex", pageIndex);
				model.addAttribute("sort", sort);
				model.addAttribute("dto", dto);
				model.addAttribute("result", 0);
				
				return "product.productForm";
	
			} else {
				
				// file check
				if(!file.isEmpty()) {
					// file update
					FileUpload fileUpload = new FileUpload();
					fileUpload.deleteFile("product",dto.getP_img());
					String fileName = fileUpload.uploadFile(file, "product");
					dto.setP_img(fileName);
				}
				
				// update
				dao.productUpdate(dto);
				
				// model
				model.addAttribute("pageIndex",pageIndex);
				model.addAttribute("sort", sort);
				model.addAttribute("p_id",dto.getP_id());
				model.addAttribute("result", 1);
				
				return "forward:productUpdateForm.do";
			}
	}
	
	@RequestMapping("productDelete.do")
	public String productDelete(
			HttpServletRequest request,
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "sort", required = false, defaultValue = "P_ID DESC") String sort,
			Model model) throws Exception {
			
		    String[] p_ids = request.getParameterValues("p_ids");
		    
		    // file delete
		    for(int i=0; i<p_ids.length; i++) {
		    	ProductDTO dto = dao.getProductInfo(Integer.parseInt(p_ids[i]));
		    	FileUpload fileUpload = new FileUpload();
				fileUpload.deleteFile("product",dto.getP_img());
		    }
		    
		    // delete setting
		    Map<String , Object> map = new HashMap<String, Object>();
		    map.put("p_ids", p_ids);
		    
		    // delete
			dao.productDelete(map);
			
			// model
			model.addAttribute("pageIndex",pageIndex);
			model.addAttribute("sort", sort);
			
			return "redirect:product.do";
	}
	
	
	@RequestMapping("productStockInsertForm.do")
	public String productStockInsertForm(
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "sort", required = false, defaultValue = "P_ID DESC") String sort,
			Model model)
			throws Exception {
		
		ProductSearchDTO search = new ProductSearchDTO();
		search.setSearchP_state("0");
		/// paging
		int totalCount = dao.getSearchProductTotalCount(search);
		Paging paging = new Paging(pageIndex, totalCount, 5, 5);
		paging.pageHandling();
		
		// list setting
		search.setStartRow(paging.getStartRow());
		search.setEndRow(paging.getEndRow());
		search.setSort(sort);
		
		// list
		List<ProductDTO> list = dao.getProductSearchList(search);
		
		// model
		model.addAttribute("paging", paging);
		model.addAttribute("sort", sort);
		model.addAttribute("list", list);
		
		return "product.productStockForm";
	}

}
