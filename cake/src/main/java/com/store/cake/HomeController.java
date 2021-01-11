package com.store.cake;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	@RequestMapping(value = "home.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model,HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String e_id = (String)session.getAttribute("sessionID");
		
		if (e_id == null || e_id.length() == 0) 
			return "redirect:employee/loginForm.do";
		else
			return "redirect:sale/saleGraph.do";
		
	}
}
