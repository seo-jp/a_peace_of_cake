package com.store.cake.controller.employee;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.store.cake.dto.employee.EmployeeDTO;
import com.store.cake.dao.employee.*;

@Controller
@RequestMapping("/employee/")
public class EmployeeController {
	
	@Resource
	private EmployeeDAO dao;
	
	//login page
	@RequestMapping(value="loginForm.do")
	public String LoginForm(HttpServletRequest request){
		HttpSession session = request.getSession();
		String e_id = (String)session.getAttribute("sessionID");
		
		if (e_id == null || e_id.length() == 0) 
			return "except.employee.login";
		else
			return "redirect:../home.do";
	}
	
	//login
	@RequestMapping("login.do")
	public String Login(HttpServletRequest request, String e_id, String e_pwd){
		/*
		 * result 0 : id_false
		 * result 1 : fwd_false
		 */
		
		if(e_id.equals("")||e_id == null) e_id = "";
		if(e_pwd.equals("")||e_pwd == null) e_pwd = "";
		
		String idCk = dao.idCheck(e_id);
		if(idCk.equals("id_false")) { 
			request.setAttribute("result", 0);
			return "except.employee.login";
		} else {
			String pwdCk = dao.pwdCheck(e_pwd);
			if(pwdCk.equals("pwd_false")){ 
				request.setAttribute("result", 1); 
				return "except.employee.login";
			} else {
				HttpSession session = request.getSession();
				session.setAttribute("sessionID", e_id);
				
				return "redirect:/home.do";
			}	
		}
	}
	
	//login out
	@RequestMapping("logout.do")
	public String Logout(HttpServletRequest request){
		request.getSession().invalidate();
		return "redirect:/home.do";
	}
}
