package com.store.cake.dao.product;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.store.cake.dto.product.ProductDTO;
import com.store.cake.dto.product.ProductSearchDTO;

public interface ProductDAO {
	
	public List<ProductDTO> getProductList(HashMap map);

	public List<ProductDTO> getProductSearchList(ProductSearchDTO search);
	
	public int getProductTotalCount();
	
	public int getSearchProductTotalCount(ProductSearchDTO search);
	
	public String checkName(HashMap map);
	
	public void productInsert(ProductDTO dto);

	public ProductDTO getProductInfo(int p_id);
	
	public void productUpdate(ProductDTO dto);
	
	public void productDelete(Map<String, Object> map);

	
}
