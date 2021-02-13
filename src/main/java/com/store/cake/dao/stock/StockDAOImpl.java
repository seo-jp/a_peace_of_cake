package com.store.cake.dao.stock;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.store.cake.dto.stock.StockDTO;
import com.store.cake.dto.stock.StockSearchDTO;

@Component
public class StockDAOImpl implements StockDAO {
	
	@Autowired 
	private SqlSession sqlsession;
	
	@Override
	public List<StockDTO> getStockList(HashMap map) {
		StockDAO dao = sqlsession.getMapper(StockDAO.class);
		return dao.getStockList(map);
	}

	@Override
	public List<StockDTO> getStockSearchList(StockSearchDTO search) {
		StockDAO dao = sqlsession.getMapper(StockDAO.class);
		return dao.getStockSearchList(search);
	}

	@Override
	public int getStockTotalCount(HashMap map) {
		StockDAO dao = sqlsession.getMapper(StockDAO.class);
		return dao.getStockTotalCount(map);
	}

	@Override
	public int getSearchStockTotalCount(StockSearchDTO search) {
		StockDAO dao = sqlsession.getMapper(StockDAO.class);
		return dao.getSearchStockTotalCount(search);
	}

	@Override
	public void stockInsert(HashMap map) {
		StockDAO dao = sqlsession.getMapper(StockDAO.class);
		dao.stockInsert(map);
	}

	@Override
	public void stockUpdate(HashMap map) {
		StockDAO dao = sqlsession.getMapper(StockDAO.class);
		dao.stockUpdate(map);
	}

	@Override
	public void stockUpdate2(HashMap map) {
		StockDAO dao = sqlsession.getMapper(StockDAO.class);
		dao.stockUpdate2(map);
	}

	@Override
	public int chkStock(HashMap map) {
		StockDAO dao = sqlsession.getMapper(StockDAO.class);
		return dao.chkStock(map);
	}

	@Override
	public void stockStateUpdate() {
		StockDAO dao = sqlsession.getMapper(StockDAO.class);
		dao.stockStateUpdate();
	}

}
