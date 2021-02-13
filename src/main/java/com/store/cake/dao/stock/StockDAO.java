package com.store.cake.dao.stock;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.store.cake.dto.stock.StockSearchDTO;
import com.store.cake.dto.stock.StockDTO;

public interface StockDAO {
	
	public List<StockDTO> getStockList(HashMap map);

	public List<StockDTO> getStockSearchList(StockSearchDTO search);
	
	public int getStockTotalCount(HashMap map);
	
	public int getSearchStockTotalCount(StockSearchDTO search);
	
	public void stockInsert(HashMap map);

	public void stockUpdate(HashMap map);

	public void stockUpdate2(HashMap map);

	public int chkStock(HashMap map);
	
	public void stockStateUpdate();
	
}
