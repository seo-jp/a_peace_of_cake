package com.store.cake.dao.sale;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.store.cake.dto.product.ProductDTO;
import com.store.cake.dto.sale.SaleDTO;
import com.store.cake.dto.sale.SaleGraphDTO;
import com.store.cake.dto.sale.SaleSearchDTO;

@Component
public class SaleDAOImpl implements SaleDAO {
	
	@Autowired 
	private SqlSession sqlsession;
	
	@Override
	public List<SaleDTO> getSaleList(HashMap map) {
		SaleDAO dao = sqlsession.getMapper(SaleDAO.class);
		return dao.getSaleList(map);
	}

	@Override
	public HashMap getSaleTotalCount(HashMap map) {
		SaleDAO dao = sqlsession.getMapper(SaleDAO.class);
		return dao.getSaleTotalCount(map);
	}

	@Override
	public void saleInsert(HashMap map) {
		SaleDAO dao = sqlsession.getMapper(SaleDAO.class);
		dao.saleInsert(map);
		
	}

	@Override
	public int getMaxGroupID() {
		SaleDAO dao = sqlsession.getMapper(SaleDAO.class);
		return dao.getMaxGroupID();
	}

	@Override
	public List<SaleDTO> getSaleSearchList(SaleSearchDTO search) {
		SaleDAO dao = sqlsession.getMapper(SaleDAO.class);
		return dao.getSaleSearchList(search);
	}

	@Override
	public HashMap getSearchSaleTotalCount(SaleSearchDTO search) {
		SaleDAO dao = sqlsession.getMapper(SaleDAO.class);
		return dao.getSearchSaleTotalCount(search);
	}
	
	@Override
	public List<SaleDTO> getPosRefundList(int s_group_id) {
		SaleDAO dao = sqlsession.getMapper(SaleDAO.class);
		return dao.getPosRefundList(s_group_id);
	}
	
	@Override
	public void posRefund(Map<String, Object> map) {
		SaleDAO dao = sqlsession.getMapper(SaleDAO.class);
		dao.posRefund(map);
	}

	@Override
	public List<SaleGraphDTO> getGraphDay(HashMap map) {
		SaleDAO dao = sqlsession.getMapper(SaleDAO.class);
		return dao.getGraphDay(map);
	}

	@Override
	public List<SaleGraphDTO> getGraphMonth(HashMap map) {
		SaleDAO dao = sqlsession.getMapper(SaleDAO.class);
		return dao.getGraphMonth(map);
	}

	@Override
	public List<SaleGraphDTO> getGraphYear(HashMap map) {
		SaleDAO dao = sqlsession.getMapper(SaleDAO.class);
		return dao.getGraphYear(map);
	}

	@Override
	public List<ProductDTO> getPosList() {
		SaleDAO dao = sqlsession.getMapper(SaleDAO.class);
		return dao.getPosList();
	}

	


}
