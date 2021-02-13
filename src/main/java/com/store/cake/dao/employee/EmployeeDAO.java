package com.store.cake.dao.employee;
import com.store.cake.dto.employee.EmployeeDTO;

public interface EmployeeDAO {

	public String idCheck(String e_id);
	public String pwdCheck(String e_pwd);
	
	public EmployeeDTO getEmpInfo(String e_id);
	
}
