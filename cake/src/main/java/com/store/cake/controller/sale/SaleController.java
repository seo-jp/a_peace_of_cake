package com.store.cake.controller.sale;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.store.cake.dao.sale.SaleDAO;
import com.store.cake.dao.stock.StockDAO;
import com.store.cake.dto.product.ProductDTO;
import com.store.cake.dto.sale.SaleDTO;
import com.store.cake.dto.sale.SaleGraphDTO;
import com.store.cake.dto.sale.SaleSearchDTO;
import com.store.cake.util.Paging;
import com.store.cake.util.ShowDate;

@Controller
@RequestMapping("/sale/")
public class SaleController {
	
	@Resource
	private SaleDAO dao;
	
	@Resource
	private StockDAO Sdao;
	
	@RequestMapping("sale.do")
	public String sale(
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "sort", required = false, defaultValue = "S_ID DESC") String sort,
			@RequestParam(value = "viewType", required = false, defaultValue = "day") String viewType,
			Model model)
			throws Exception {
		
		// date
		ShowDate showDate = new ShowDate();
		showDate.dateHandling(viewType);
				
		HashMap map = new HashMap();
		map.put("showDateFrom", showDate.getShowDateFrom());
		map.put("showDateTo", showDate.getShowDateTo());
		
		SaleSearchDTO search = new SaleSearchDTO();
		search.setSearchFromDate(showDate.getShowDateFrom());
		search.setSearchToDate(showDate.getShowDateTo());
		
		// paging
		HashMap map2 = new HashMap();
		map2 = dao.getSaleTotalCount(map);
		int totalCount = Integer.parseInt(map2.get("CNT").toString());
		
		Paging paging = new Paging(pageIndex, totalCount, 8, 5);
		paging.pageHandling();
				
		// list setting
		map.put("startRow", paging.getStartRow());
		map.put("endRow", paging.getEndRow());
		map.put("sort", sort);
				
				
		// list
		List<SaleDTO> list = dao.getSaleList(map);
				
		// model
		model.addAttribute("mode","list");
		model.addAttribute("paging", paging);
		model.addAttribute("sort", sort);
		model.addAttribute("viewType", viewType);
		model.addAttribute("list", list);
		model.addAttribute("search", search);
		model.addAttribute("sum",Integer.parseInt(map2.get("SUM").toString()));
		
		return "sale.sale";

	}
	
	@RequestMapping("saleSearch.do")
	public String orderSearch(
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "sort", required = false, defaultValue = "O_ID DESC") String sort,
			@RequestParam(value = "viewType", required = false, defaultValue = "day") String viewType,
			SaleSearchDTO search,
			Model model) throws Exception {
		
		Optional<SaleSearchDTO> opt = Optional.ofNullable(search);
		if (opt.isPresent()) {
			
			HashMap map = new HashMap();
			
			// date 검색없을시 viewType on
			if((search.getSearchFromDate() == null || search.getSearchFromDate().length() == 0)
					|| (search.getSearchToDate() == null || search.getSearchToDate().length() == 0) ) {
				ShowDate showDate = new ShowDate();
				showDate.dateHandling(viewType);
				
				search.setSearchFromDate(showDate.getShowDateFrom());
				search.setSearchToDate(showDate.getShowDateTo());
			}
			
			// paging
			HashMap map2 = new HashMap();
			map2 = dao.getSearchSaleTotalCount(search);
			int totalCount = Integer.parseInt(map2.get("CNT").toString());
			Paging paging = new Paging(pageIndex, totalCount, 8, 5);
			paging.pageHandling();
				
			// list setting
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			// list
			List<SaleDTO> list = dao.getSaleSearchList(search);
			
			// model
			model.addAttribute("mode","search");
			model.addAttribute("paging", paging);
			model.addAttribute("sort", search.getSort());
			model.addAttribute("viewType", viewType);
			model.addAttribute("list", list);
			model.addAttribute("search", search);
			model.addAttribute("sum",Integer.parseInt(map2.get("SUM").toString()));
			
		}else {
			System.out.println("null");
		}
		
		return "sale.sale";
	}
	

	@RequestMapping("pos.do")
	public String pos(
			HttpServletRequest request,
			Model model)
			throws Exception {
		
		// list
		List<ProductDTO> list = dao.getPosList();
		// session
		HttpSession session = request.getSession();
		session.setAttribute("sessionID", (String)session.getAttribute("sessionID"));
		
		model.addAttribute("list", list);
		
		return "except.sale.pos";

	}
	
	@RequestMapping("saleInsert.do")
	public String saleInsert(
			HttpServletRequest request,
			Model model) throws Exception {
			
		    String[] p_ids = request.getParameterValues("p_ids");
		    String[] p_amounts = request.getParameterValues("p_amounts");
		    String[] p_discounts = request.getParameterValues("p_discounts");
		    String[] p_allprices = request.getParameterValues("p_allprices");
		    int s_group_id = dao.getMaxGroupID();
		    int result = 1;
		    
		    // insert setting
		    HashMap map = new HashMap();
		    
		    // check
		    Loop:
		    for(int i=0; i<p_ids.length; i++) {
		    	map.put("s_p_id", p_ids[i]);
		    	map.put("s_amount", p_amounts[i]);
		    	result = Sdao.chkStock(map);
		    	if(result == 0) { 
		    		throw new Exception();
		    		//break Loop;
		    	}
		    }
		    
			if(result != 0) {
				for(int i=0; i<p_ids.length; i++) {
					map.put("s_group_id", s_group_id);
					map.put("s_p_id", p_ids[i]);
					map.put("s_allprice", p_allprices[i]);
					map.put("s_discount", p_discounts[i]);
					map.put("s_amount", p_amounts[i]);
					
					// insert
					dao.saleInsert(map);
					// stock setting
					for(int j=0; j<Integer.parseInt(p_amounts[i]); j++)
						Sdao.stockUpdate2(map);
					// state update
					Sdao.stockStateUpdate();
				}
			}
			
			return "redirect:pos.do";
	}
	
	@RequestMapping("posRefund.do")
	public String posRefundInsert(
			HttpServletRequest request,
			Model model)
			throws Exception {
		
		HttpSession session = request.getSession();
		session.setAttribute("sessionID", (String)session.getAttribute("sessionID"));
		
		return "except.sale.posRefund";

	}
	
	@RequestMapping("posRefundSearch.do")
	public String posRefundSearch(
			@RequestParam(value = "s_group_id", required = false, defaultValue = "0") Integer s_group_id,
			HttpServletRequest request,
			Model model)
			throws Exception {
		
		// list
		List<SaleDTO> list = dao.getPosRefundList(s_group_id);
		
		// model
		HttpSession session = request.getSession();
		session.setAttribute("sessionID", (String)session.getAttribute("sessionID"));
		model.addAttribute("list", list);
		model.addAttribute("s_group_id", s_group_id);
		
		return "except.sale.posRefund";

	}
	
	@RequestMapping("posRefundExe.do")
	public String posRefundExe(
			HttpServletRequest request,
			Model model)
			throws Exception {
		
		 String[] s_ids = request.getParameterValues("s_ids");

		 // update setting
		 Map<String , Object> map = new HashMap<String, Object>();
		 map.put("s_ids", s_ids);
		 // update
		 dao.posRefund(map);
		
		return "redirect:pos.do";

	}
	
	@RequestMapping("saleGraph.do")
	public String saleGraph(
			@RequestParam(value = "viewType", required = false, defaultValue = "day") String viewType,
			@RequestParam(value = "searchDate", required = false) String searchDate,
			Model model)
			throws Exception {
		
		
		// date 검색없을시 viewType on
		ShowDate showDate = new ShowDate();
		
		if(searchDate == null || searchDate.length() == 0) {
			showDate.dateHandling2(viewType);
			searchDate = showDate.getSearchDate();
		}else {
			showDate.dateHandling3(viewType,searchDate);
		}
		
		
		// list
		
		HashMap map = new HashMap();
		map.put("showDateFrom", showDate.getShowDateFrom());
		map.put("showDateTo", showDate.getShowDateTo());
		
		List<SaleGraphDTO> list = null;
		
		switch(viewType) {
		
		case "day" : list = dao.getGraphDay(map);
			break;
		case "month" : list = dao.getGraphMonth(map);
			break;
		case "year" : list = dao.getGraphYear(map);
			break;
		}
		
		// model
		model.addAttribute("viewType", viewType);
		model.addAttribute("searchDate", searchDate);
		model.addAttribute("list", list);
		
		return "sale.saleGraph";

	}
	
	
}
