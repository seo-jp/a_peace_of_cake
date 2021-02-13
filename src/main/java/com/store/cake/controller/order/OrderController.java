package com.store.cake.controller.order;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.store.cake.dao.order.OrderDAO;
import com.store.cake.dto.order.IngredientDTO;
import com.store.cake.dto.order.IngredientSearchDTO;
import com.store.cake.dto.order.OrderDTO;
import com.store.cake.dto.order.OrderSearchDTO;
import com.store.cake.util.FileUpload;
import com.store.cake.util.Paging;
import com.store.cake.util.ShowDate;

@Controller
@RequestMapping("/order/")
public class OrderController {
	
	@Resource
	private OrderDAO dao;
	
	@RequestMapping("order.do")
	public String order(
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "sort", required = false, defaultValue = "I_ID DESC") String sort,
			@RequestParam(value = "result", required = false, defaultValue = "2") String result,
			Model model)
			throws Exception {
		
		// paging
				int totalCount = dao.getIngredientTotalCount();
				Paging paging = new Paging(pageIndex, totalCount, 5, 5);
				paging.pageHandling();

				// list setting
				HashMap map = new HashMap();
				map.put("startRow", paging.getStartRow());
				map.put("endRow", paging.getEndRow());
				map.put("sort", sort);
				
				// list
				List<IngredientDTO> list = dao.getIngredientList(map);
				
				// model
				model.addAttribute("mode","list");
				model.addAttribute("paging", paging);
				model.addAttribute("sort", sort);
				model.addAttribute("list", list);
				model.addAttribute("result", result);
		
		return "order.orderForm";

	}
	
	@RequestMapping("ingredientSearch.do")
	public String ingredientSearch(
				@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
				@RequestParam(value = "sort", required = false, defaultValue = "I_ID DESC") String sort,
				IngredientSearchDTO search,
				Model model) throws Exception {
		
		Optional<IngredientSearchDTO> opt = Optional.ofNullable(search);
		if (opt.isPresent()) {
			// paging
			int totalCount = dao.getSearchIngredientTotalCount(search);
			Paging paging = new Paging(pageIndex, totalCount, 5, 5);
			paging.pageHandling();
			
			// list setting
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			// list
			List<IngredientDTO> list = dao.getIngredientSearchList(search);
			
			// model
			model.addAttribute("mode","search");
			model.addAttribute("paging", paging);
			model.addAttribute("sort", search.getSort());
			model.addAttribute("list", list);
			model.addAttribute("search", search);
			
		}else {
			System.out.println("null");
		}
		
		return "order.orderForm";

	}
	
	@RequestMapping("ingredientInsertForm.do")
	public String ingredientInsertForm(
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "sort", required = false, defaultValue = "I_ID DESC") String sort,
			Model model)
			throws Exception {
		
		// model
		model.addAttribute("mode", "insert");
		model.addAttribute("pageIndex", pageIndex);
		model.addAttribute("sort", sort);

		return "order.ingredientForm";

	}
	
	@RequestMapping("ingredientInsert.do")
	public String ingredientInsert(
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "sort", required = false, defaultValue = "I_ID DESC") String sort,
			@RequestParam MultipartFile file,
			RedirectAttributes redirectAttributes,
			IngredientDTO dto,
			Model model) throws Exception {

		// name check
		HashMap map = new HashMap();
		map.put("i_name", dto.getI_name());
		String nameChk = dao.checkName(map);
		Optional<String> opt = Optional.ofNullable(nameChk);
		
		if (opt.isPresent()) {
			// send error
			model.addAttribute("mode", "insert");
			model.addAttribute("pageIndex", pageIndex);
			model.addAttribute("sort", sort);
			model.addAttribute("dto", dto);
			model.addAttribute("result", 0);
			
			return "order.ingredientForm";

		} else {
			// file upload
			FileUpload fileUpload = new FileUpload();
			String fileName = fileUpload.uploadFile(file, "ingredient");
			dto.setI_img(fileName);
			
			// insert
			dao.ingredientInsert(dto);
			redirectAttributes.addAttribute("result",1);

			return "redirect:order.do";
		}

	}

	@RequestMapping("ingredientUpdateForm.do")
	public String ingredientUpdateForm(
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "sort", required = false, defaultValue = "I_ID DESC") String sort,
			@RequestParam(value = "i_id") Integer i_id, Model model) throws Exception {
		
		//getInfo
		IngredientDTO dto = dao.getIngredientInfo(i_id);
		
		//model
		model.addAttribute("mode", "update");
		model.addAttribute("pageIndex", pageIndex);
		model.addAttribute("sort", sort);
		model.addAttribute("dto", dto);

		return "order.ingredientForm";

	}
	
	@RequestMapping("ingredientUpdate.do")
	public String ingredientUpdate(
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "sort", required = false, defaultValue = "I_ID DESC") String sort,
			@RequestParam MultipartFile file,
			IngredientDTO dto,
			Model model) throws Exception {
		
			// name check
			HashMap map = new HashMap();
			map.put("i_name", dto.getI_name());
			map.put("i_id", dto.getI_id());
			String nameChk = dao.checkName(map);
			Optional<String> opt = Optional.ofNullable(nameChk);
			
			if (opt.isPresent()) {
				// send error
				model.addAttribute("mode", "update");
				model.addAttribute("pageIndex", pageIndex);
				model.addAttribute("sort", sort);
				model.addAttribute("dto", dto);
				model.addAttribute("result", 0);
				
				return "order.ingredientForm";
	
			} else {
				
				// file check
				if(!file.isEmpty()) {
					// file update
					FileUpload fileUpload = new FileUpload();
					fileUpload.deleteFile("ingredient",dto.getI_img());
					String fileName = fileUpload.uploadFile(file, "ingredient");
					dto.setI_img(fileName);
				}
				
				// update
				dao.ingredientUpdate(dto);
				
				// model
				model.addAttribute("pageIndex",pageIndex);
				model.addAttribute("sort", sort);
				model.addAttribute("i_id",dto.getI_id());
				model.addAttribute("result", 1);
				
				return "forward:ingredientUpdateForm.do";
			}
	}
	
	@RequestMapping("orderInsert.do")
	public String orderInsert(
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "sort", required = false, defaultValue = "I_ID DESC") String sort,
			@RequestParam int i_id,
			@RequestParam char i_state,
			@RequestParam int o_amount,
			RedirectAttributes redirectAttributes,
			Model model) throws Exception {
		
		// 다중발주 일단 구현안할거임 .. 나중에 시간 남을때 보수하자
		// state check	
		if(i_state == '0') {
			// insert
			HashMap map = new HashMap();
			map.put("o_i_id",i_id);
			map.put("o_amount",o_amount);
			map.put("o_state", 0);
			// state : 0 > 주문완료 / 1 > 배송중 / 2 > 배송완료 / 3 > 취소
			dao.orderInsert(map);
			redirectAttributes.addAttribute("result",1);
			
		} else if(i_state == '1'){
			System.out.println("주문 불가능한 상품입니다.");
			model.addAttribute("result", 0);
			model.addAttribute("pageIndex",pageIndex);
			model.addAttribute("sort", sort);
			return "order.orderForm";
		} else {
			System.out.println("주문 불가능한 상품입니다.");
			redirectAttributes.addAttribute("result", 0);
			redirectAttributes.addAttribute("pageIndex",pageIndex);
			redirectAttributes.addAttribute("sort", sort);
		}
		
		return "redirect:orderList.do";
	}
	
	@RequestMapping("orderList.do")
	public String orderList(
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "sort", required = false, defaultValue = "O_REGDATE DESC") String sort,
			@RequestParam(value = "viewType", required = false, defaultValue = "day") String viewType,
			@RequestParam(value = "result", required = false, defaultValue = "2") String result,
			Model model) throws Exception {
		
		// confirm, 그리고 서치, 추가는 오더창에서(만들필요없음), 수정삭제불가, 주문취소가능 . 버튼하나 눌러서 order state만 바꾸기
		// state는 자동 업데이트 시켜줘야하는데 하..이걸우찌 업데이트시키지 여튼 방법찾아보기 , 모든일자는 발주하고나서 2일로 잡기.
		// 그날 발주마감시간은 11시 까지 . 그 뒤 발주한것들은 그다음날로 넘어감. jsp단에 기재해주기.
		// 서치는 날짜. 이름. 상태 세개만.
		
		// date
		ShowDate showDate = new ShowDate();
		showDate.dateHandling(viewType);
		
		HashMap map = new HashMap();
		map.put("showDateFrom", showDate.getShowDateFrom());
		map.put("showDateTo", showDate.getShowDateTo());
		
		OrderSearchDTO search = new OrderSearchDTO();
		search.setSearchFromDate(showDate.getShowDateFrom());
		search.setSearchToDate(showDate.getShowDateTo());
		
		// paging
		int totalCount = dao.getOrderTotalCount(map);
		Paging paging = new Paging(pageIndex, totalCount, 8, 5);
		paging.pageHandling();
		
		// list setting
		map.put("startRow", paging.getStartRow());
		map.put("endRow", paging.getEndRow());
		map.put("sort", sort);
		
		
		// list
		// 규칙 : 기본적으로 당일에 처리한 주문, (or)그리고 배송완료,취소가 아닌 상태들 (아직 처리되지않은)
		//       배송완료가 되면 업데이트 되면서 .. 배송date 란을 추가해주고 그것도 같이 업데이트해줘야하는데 일단 이건 나중에 덧붙이는식으로 가자.
		//		 where 절에 OR O_도착DATE = showDate 인식으로.. 근데 또 viewType변경할때 진행중인 값 보이면 안돼니까 .. 일단 상태값처리는 나중에 생각하자
		
		List<OrderDTO> list = dao.orderList(map);
		
		// model
		model.addAttribute("mode","list");
		model.addAttribute("paging", paging);
		model.addAttribute("sort", sort);
		model.addAttribute("viewType", viewType);
		model.addAttribute("list", list);
		model.addAttribute("search", search); // date default
		model.addAttribute("result",result);
		
		return "order.orderList";
	}
	
	@RequestMapping("orderSearch.do")
	public String orderSearch(
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "sort", required = false, defaultValue = "O_ID DESC") String sort,
			@RequestParam(value = "viewType", required = false, defaultValue = "day") String viewType,
			OrderSearchDTO search,
			Model model) throws Exception {
		
			//검색기능 구현
			// 날짜가 on 일 시 viewType은 주석처리
		
		Optional<OrderSearchDTO> opt = Optional.ofNullable(search);
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
			int totalCount = dao.getSearchOrderTotalCount(search);
			Paging paging = new Paging(pageIndex, totalCount, 8, 5);
			paging.pageHandling();
				
			// list setting
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			// list
			List<OrderDTO> list = dao.getOrderSearchList(search);
			
			// model
			model.addAttribute("mode","search");
			model.addAttribute("paging", paging);
			model.addAttribute("sort", search.getSort());
			model.addAttribute("viewType", viewType);
			model.addAttribute("list", list);
			model.addAttribute("search", search);
			
		}else {
			System.out.println("null");
		}
		
		return "order.orderList";
	}
	
	@RequestMapping("orderCancel.do")
	public String orderCancel(
			@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "sort", required = false, defaultValue = "O_ID DESC") String sort,
			@RequestParam(value = "viewType", required = false, defaultValue = "day") String viewType,
			@RequestParam int o_id,
			OrderSearchDTO search,
			Model model) throws Exception {
		
			// 선택한 order 상태를 3으로 바꾼다.
			dao.orderCancel(o_id);
			
			model.addAttribute("pageIndex", pageIndex);
			model.addAttribute("sort", sort);
			model.addAttribute("viewType", viewType);
			model.addAttribute("search", search);
		
		return "forward:orderList.do";
	}
	
}
