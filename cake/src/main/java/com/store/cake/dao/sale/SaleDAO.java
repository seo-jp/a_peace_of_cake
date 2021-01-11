package com.store.cake.dao.sale;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.store.cake.dto.product.ProductDTO;
import com.store.cake.dto.sale.SaleDTO;
import com.store.cake.dto.sale.SaleGraphDTO;
import com.store.cake.dto.sale.SaleSearchDTO;

public interface SaleDAO {
	
	public List<SaleDTO> getSaleList(HashMap map);

	public HashMap getSaleTotalCount(HashMap map);

	public void saleInsert(HashMap map);

	public int getMaxGroupID();

	public List<SaleDTO> getSaleSearchList(SaleSearchDTO search);

	public HashMap getSearchSaleTotalCount(SaleSearchDTO search);
	
	public List<SaleDTO> getPosRefundList(int s_group_id);
	
	public List<SaleGraphDTO> getGraphDay(HashMap map);
	
	public List<SaleGraphDTO> getGraphMonth(HashMap map);
	
	public List<SaleGraphDTO> getGraphYear(HashMap map);

	public void posRefund(Map<String, Object> map);

	public List<ProductDTO> getPosList();
	
}
