package com.store.cake.controller.stock;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.store.cake.dao.stock.StockDAO;
import com.store.cake.dto.order.OrderSearchDTO;
import com.store.cake.dto.stock.StockDTO;
import com.store.cake.dto.stock.StockSearchDTO;
import com.store.cake.util.Paging;

@Controller
@RequestMapping("/stock/")
public class StockController {
	
	@Resource
	private StockDAO dao;
	
	@RequestMapping("stock.do")
	public String stock(
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "sort", required = false, defaultValue = "S_NAME ASC") String sort,
			@RequestParam(value = "viewType", required = false, defaultValue = "P") String viewType,
			Model model)
			throws Exception {
		
		HashMap map = new HashMap();
		map.put("viewType",viewType);
		map.put("state", 0);
		
		// paging
		int totalCount = dao.getStockTotalCount(map);
		Paging paging = new Paging(pageIndex, totalCount, 5, 5);
		paging.pageHandling();

		// list setting
		map.put("startRow", paging.getStartRow());
		map.put("endRow", paging.getEndRow());
		map.put("sort", sort);
				
				
		// list
		List<StockDTO> list = dao.getStockList(map);
				
		// model
		model.addAttribute("mode","list");
		model.addAttribute("paging", paging);
		model.addAttribute("sort", sort);
		model.addAttribute("viewType", viewType);
		model.addAttribute("list", list);
		
		return "stock.stock";

	}
	
	@RequestMapping("stockSearch.do")
	public String stockSearch(
				@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
				@RequestParam(value = "sort", required = false, defaultValue = "S_NAME ASC") String sort,
				@RequestParam(value = "viewType", required = false, defaultValue = "P") String viewType,
				StockSearchDTO search,
				Model model) throws Exception {
		
		Optional<StockSearchDTO> opt = Optional.ofNullable(search);
		if (opt.isPresent()) {
			
			// paging
			if(search.getSearchS_state()== null || search.getSearchS_state().length() == 0) {
				search.setSearchS_state("0");
			}
			int totalCount = dao.getSearchStockTotalCount(search);
			Paging paging = new Paging(pageIndex, totalCount, 5, 5);
			paging.pageHandling();
			
			// list setting
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			
			// list
			List<StockDTO> list = dao.getStockSearchList(search);
			
			// model
			model.addAttribute("mode","search");
			model.addAttribute("paging", paging);
			model.addAttribute("sort", search.getSort());
			model.addAttribute("viewType", search.getViewType());
			model.addAttribute("list", list);
			model.addAttribute("search", search);
			
		}else {
			System.out.println("null");
		}
		
		return "stock.stock";

	}
	
	@RequestMapping("stockUpdate.do")
	public String stockUpdate(
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "sort", required = false, defaultValue = "O_ID DESC") String sort,
			@RequestParam(value = "viewType", required = false, defaultValue = "day") String viewType,
			@RequestParam int s_id,
			@RequestParam int s_amount,
			StockSearchDTO search,
			Model model) throws Exception {
			
			HashMap map = new HashMap();
			map.put("s_id", s_id);
			map.put("s_amount", s_amount);
			dao.stockUpdate(map);
			
			model.addAttribute("pageIndex", pageIndex);
			model.addAttribute("sort", sort);
			model.addAttribute("viewType", viewType);
			model.addAttribute("search", search);
		
		return "forward:stock.do";
	}
	
	@RequestMapping("stockInsert.do")
	public String stockInsert(
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam int p_id,
			@RequestParam int p_amount,
			Model model) throws Exception {
			
			HashMap map = new HashMap();
			map.put("p_id", p_id);
			map.put("p_amount", p_amount);
			dao.stockInsert(map);
			
			model.addAttribute("pageIndex", pageIndex);
		
		return "forward:../product/productStockInsertForm.do";
	}
	

}
