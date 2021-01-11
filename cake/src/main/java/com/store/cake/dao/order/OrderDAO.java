package com.store.cake.dao.order;
import java.util.HashMap;
import java.util.List;

import com.store.cake.dto.order.IngredientDTO;
import com.store.cake.dto.order.IngredientSearchDTO;
import com.store.cake.dto.order.OrderDTO;
import com.store.cake.dto.order.OrderSearchDTO;

public interface OrderDAO {
	
	/* ingredient */
	
	public List<IngredientDTO> getIngredientList(HashMap map);

	public List<IngredientDTO> getIngredientSearchList(IngredientSearchDTO search);
	
	public int getIngredientTotalCount();
	
	public int getSearchIngredientTotalCount(IngredientSearchDTO search);
	
	public String checkName(HashMap map);
	
	public void ingredientInsert(IngredientDTO dto);

	public IngredientDTO getIngredientInfo(int i_id);
	
	public void ingredientUpdate(IngredientDTO dto);
	
	/* order */
	
	public void orderInsert(HashMap map);

	public List<OrderDTO> orderList(HashMap map);
	
	public List<OrderDTO> getOrderSearchList(OrderSearchDTO search);

	public int getOrderTotalCount(HashMap map);
	
	public int getSearchOrderTotalCount(OrderSearchDTO search);

	public void orderCancel(int o_id);
	
}
