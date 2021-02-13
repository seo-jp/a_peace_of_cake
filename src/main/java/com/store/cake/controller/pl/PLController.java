package com.store.cake.controller.pl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.store.cake.dao.pl.PLDAO;
import com.store.cake.dto.pl.PLDTO;
import com.store.cake.dto.pl.PLGraphDTO;
import com.store.cake.dto.pl.SpendDTO;
import com.store.cake.util.Paging;
import com.store.cake.util.ShowDate;

@Controller
@RequestMapping("/pl/")
public class PLController {
	
	@Resource
	private PLDAO dao;
	
	@RequestMapping("pl.do")
	public String pl(
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "viewType", required = false, defaultValue = "day") String viewType,
			@RequestParam(value = "showDateFrom", required = false) String showDateFrom,
			@RequestParam(value = "showDateTo", required = false) String showDateTo,
			@RequestParam(value = "result", required = false, defaultValue = "2") String result,
			Model model)
			throws Exception {
		
		// date 검색없을시 viewType on
		if ((showDateFrom == null || showDateFrom.length() == 0)
				|| (showDateTo == null || showDateTo.length() == 0)) {
			
			ShowDate showDate = new ShowDate();
			showDate.dateHandling(viewType);

			showDateFrom = showDate.getShowDateFrom();
			showDateTo = showDate.getShowDateTo();
		}
		
		// date
		HashMap map = new HashMap();
		map.put("showDateFrom", showDateFrom);
		map.put("showDateTo", showDateTo);
		
		// paging
		HashMap map2 = new HashMap();
		map2 = dao.getPLTotalCount(map);
		int totalCount = Integer.parseInt(map2.get("CNT").toString());
		
		Paging paging = new Paging(pageIndex, totalCount, 8, 5);
		paging.pageHandling();
				
		// list setting
		map.put("startRow", paging.getStartRow());
		map.put("endRow", paging.getEndRow());
				
		// list
		List<PLDTO> list = dao.getPLList(map);
				
		// model
		model.addAttribute("mode","list");
		model.addAttribute("paging", paging);
		model.addAttribute("viewType", viewType);
		model.addAttribute("showDateFrom", showDateFrom);
		model.addAttribute("showDateTo", showDateTo);
		model.addAttribute("list", list);
		model.addAttribute("sum",Integer.parseInt(map2.get("SUM").toString()));
		model.addAttribute("result",result);
		
		return "pl.pl";

	}
	
	@RequestMapping("spendInsertForm.do")
	public String spendInsertForm(
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "viewType", required = false, defaultValue = "day") String viewType,
			@RequestParam(value = "searchDate", required = false) String searchDate,
			HttpServletRequest request,
			Model model)
			throws Exception {
		
		HttpSession session = request.getSession();
		session.setAttribute("sessionID", (String)session.getAttribute("sessionID"));
		model.addAttribute("pageIndex", pageIndex);
		model.addAttribute("viewType", viewType);
		model.addAttribute("searchDate", searchDate);
		
		return "pl.spendForm";

	}
	
	@RequestMapping("spendInsert.do")
	public String spendInsert(
			SpendDTO dto,
			RedirectAttributes redirectAttributes,
			Model model)
			throws Exception {
		
		 // insert
		 dao.spendInsert(dto);
		 redirectAttributes.addAttribute("result",1);
		
		return "redirect:pl.do";

	}
	
	
	@RequestMapping("plGraph.do")
	public String plGraph(
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
		
		List<PLGraphDTO> list = null;
		
		switch(viewType) {
		
		case "day" : list = dao.getPLGraphDay(map);
			break;
		case "month" : list = dao.getPLGraphMonth(map);
			break;
		case "year" : list = dao.getPLGraphYear(map);
			break;
		}
		
		// model
		model.addAttribute("viewType", viewType);
		model.addAttribute("searchDate", searchDate);
		model.addAttribute("list", list);
		
		return "pl.plGraph";

	}
	
	
}
