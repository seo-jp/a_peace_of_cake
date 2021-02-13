package com.store.cake.dao.pl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.store.cake.dto.pl.PLDTO;
import com.store.cake.dto.pl.PLGraphDTO;
import com.store.cake.dto.pl.SpendDTO;

@Component
public class PLDAOImpl implements PLDAO {
	
	@Autowired 
	private SqlSession sqlsession;
	
	@Override
	public List<PLDTO> getPLList(HashMap map) {
		PLDAO dao = sqlsession.getMapper(PLDAO.class);
		return dao.getPLList(map);
	}

	@Override
	public HashMap getPLTotalCount(HashMap map) {
		PLDAO dao = sqlsession.getMapper(PLDAO.class);
		return dao.getPLTotalCount(map);
	}
	

	@Override
	public void spendInsert(SpendDTO dto) {
		PLDAO dao = sqlsession.getMapper(PLDAO.class);
		dao.spendInsert(dto);
	}

	@Override
	public List<PLGraphDTO> getPLGraphDay(HashMap map) {
		PLDAO dao = sqlsession.getMapper(PLDAO.class);
		return dao.getPLGraphDay(map);
	}

	@Override
	public List<PLGraphDTO> getPLGraphMonth(HashMap map) {
		PLDAO dao = sqlsession.getMapper(PLDAO.class);
		return dao.getPLGraphMonth(map);
	}

	@Override
	public List<PLGraphDTO> getPLGraphYear(HashMap map) {
		PLDAO dao = sqlsession.getMapper(PLDAO.class);
		return dao.getPLGraphYear(map);
	}


	


}
