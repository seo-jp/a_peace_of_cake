package com.store.cake.dao.employee;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.store.cake.dto.employee.EmployeeDTO;

@Component
public class EmployeeDAOImpl implements EmployeeDAO {
	
	@Autowired
	private SqlSession sqlsession;
	

	@Override
	public String idCheck(String e_id) {
		EmployeeDAO dao = sqlsession.getMapper(EmployeeDAO.class);
		return dao.idCheck(e_id);	
	}

	@Override
	public String pwdCheck(String e_pwd) {
		EmployeeDAO dao = sqlsession.getMapper(EmployeeDAO.class);
		return dao.pwdCheck(e_pwd);
	}

	@Override
	public EmployeeDTO getEmpInfo(String e_id) {
		EmployeeDAO dao = sqlsession.getMapper(EmployeeDAO.class);
		return dao.getEmpInfo(e_id);
	}
	
	

}
