package com.store.cake.dao.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.store.cake.dto.product.ProductDTO;
import com.store.cake.dto.product.ProductSearchDTO;

@Component
public class ProductDAOImpl implements ProductDAO {
	
	@Autowired 
	private SqlSession sqlsession;
	
	@Override
	public List<ProductDTO> getProductList(HashMap map) {
		ProductDAO dao = sqlsession.getMapper(ProductDAO.class);
		return dao.getProductList(map);
	}

	@Override
	public List<ProductDTO> getProductSearchList(ProductSearchDTO search) {
		ProductDAO dao = sqlsession.getMapper(ProductDAO.class);
		return dao.getProductSearchList(search);
	}

	@Override
	public int getProductTotalCount() {
		ProductDAO dao = sqlsession.getMapper(ProductDAO.class);
		return dao.getProductTotalCount();
	}

	@Override
	public int getSearchProductTotalCount(ProductSearchDTO search) {
		ProductDAO dao = sqlsession.getMapper(ProductDAO.class);
		return dao.getSearchProductTotalCount(search);
	}

	@Override
	public String checkName(HashMap map) {
		ProductDAO dao = sqlsession.getMapper(ProductDAO.class);
		return dao.checkName(map);
	}

	@Override
	public void productInsert(ProductDTO dto) {
		ProductDAO dao = sqlsession.getMapper(ProductDAO.class);
		dao.productInsert(dto);
	}

	@Override
	public ProductDTO getProductInfo(int p_id) {
		ProductDAO dao = sqlsession.getMapper(ProductDAO.class);
		return dao.getProductInfo(p_id);
	}

	@Override
	public void productUpdate(ProductDTO dto) {
		ProductDAO dao = sqlsession.getMapper(ProductDAO.class);
		dao.productUpdate(dto);
	}

	@Override
	public void productDelete(Map<String, Object> map) {
		ProductDAO dao = sqlsession.getMapper(ProductDAO.class);
		dao.productDelete(map);
	}


}
