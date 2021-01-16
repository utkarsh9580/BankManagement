package com.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.model.User;


@Controller
public class Logout {

	
	
	@RequestMapping("/logout")
	public ModelAndView loginPage(@ModelAttribute("user") User user,HttpServletRequest request,HttpSession session){
		
		session = request.getSession(false);
		
		session.setAttribute("user",null);
		
		user=null;
		
		session.invalidate();
		
		return new ModelAndView("login");
		
	}
	
	
}
