package com.store.cake.dao.common;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CommonDAOImpl implements CommonDAO {

	@Autowired 
	private SqlSession sqlsession;
	
	@Override
	public int getTotalCount(HashMap map) {
		CommonDAO dao = sqlsession.getMapper(CommonDAO.class);
		return dao.getTotalCount(map);
	}

}
