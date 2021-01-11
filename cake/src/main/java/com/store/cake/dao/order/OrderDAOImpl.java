package com.store.cake.dao.order;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.store.cake.dto.order.IngredientDTO;
import com.store.cake.dto.order.IngredientSearchDTO;
import com.store.cake.dto.order.OrderDTO;
import com.store.cake.dto.order.OrderSearchDTO;

@Component
public class OrderDAOImpl implements OrderDAO{
	
	@Autowired 
	private SqlSession sqlsession;

	@Override
	public List<IngredientDTO> getIngredientList(HashMap map) {
		OrderDAO dao = sqlsession.getMapper(OrderDAO.class);
		return dao.getIngredientList(map);
	}

	@Override
	public List<IngredientDTO> getIngredientSearchList(IngredientSearchDTO search) {
		OrderDAO dao = sqlsession.getMapper(OrderDAO.class);
		return dao.getIngredientSearchList(search);
	}

	@Override
	public int getIngredientTotalCount() {
		OrderDAO dao = sqlsession.getMapper(OrderDAO.class);
		return dao.getIngredientTotalCount();
	}

	@Override
	public int getSearchIngredientTotalCount(IngredientSearchDTO search) {
		OrderDAO dao = sqlsession.getMapper(OrderDAO.class);
		return dao.getSearchIngredientTotalCount(search);
	}

	@Override
	public String checkName(HashMap map) {
		OrderDAO dao = sqlsession.getMapper(OrderDAO.class);
		return dao.checkName(map);
	}

	@Override
	public void ingredientInsert(IngredientDTO dto) {
		OrderDAO dao = sqlsession.getMapper(OrderDAO.class);
		dao.ingredientInsert(dto);
	}

	@Override
	public IngredientDTO getIngredientInfo(int i_id) {
		OrderDAO dao = sqlsession.getMapper(OrderDAO.class);
		return dao.getIngredientInfo(i_id);
	}

	@Override
	public void ingredientUpdate(IngredientDTO dto) {
		OrderDAO dao = sqlsession.getMapper(OrderDAO.class);
		dao.ingredientUpdate(dto);
	}

	@Override
	public void orderInsert(HashMap map) {
		OrderDAO dao = sqlsession.getMapper(OrderDAO.class);
		dao.orderInsert(map);
	}

	@Override
	public List<OrderDTO> orderList(HashMap map) {
		OrderDAO dao = sqlsession.getMapper(OrderDAO.class);
		return dao.orderList(map);
	}

	@Override
	public int getOrderTotalCount(HashMap map) {
		OrderDAO dao = sqlsession.getMapper(OrderDAO.class);
		return dao.getOrderTotalCount(map);
	}

	@Override
	public int getSearchOrderTotalCount(OrderSearchDTO search) {
		OrderDAO dao = sqlsession.getMapper(OrderDAO.class);
		return dao.getSearchOrderTotalCount(search);
	}

	@Override
	public void orderCancel(int o_id) {
		OrderDAO dao = sqlsession.getMapper(OrderDAO.class);
		dao.orderCancel(o_id);
	}

	@Override
	public List<OrderDTO> getOrderSearchList(OrderSearchDTO search) {
		OrderDAO dao = sqlsession.getMapper(OrderDAO.class);
		return dao.getOrderSearchList(search);
	}


}
