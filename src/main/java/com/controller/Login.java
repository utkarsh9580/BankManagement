package com.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dao.UserDAO;
import com.model.Customer;
import com.model.User;
import com.validation.Validation;

@Controller
public class Login {

	@Autowired
	UserDAO userdao;

	@RequestMapping("/loginPage")
	public ModelAndView loginPage(@ModelAttribute("user") User user) {

		return new ModelAndView("login");

	}

	@RequestMapping("/errorLogin")
	public ModelAndView errorLoginPage(@ModelAttribute("user") User user, HttpServletRequest request) {

		return new ModelAndView("errorLogin");

	}

	@RequestMapping("/login")
	public ModelAndView login(User user, BindingResult br, @ModelAttribute("customer") Customer customer,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		if (br.hasErrors()) {
			return new ModelAndView("login");
		}
		session = request.getSession(false);
		if (session != null) {

			boolean flag = false;

			String ch = null;

			ch = user.getUserCode();

			flag = Validation.validateNull(ch);
			if (flag) {

			} else {
				request.setAttribute("msg", "Please Enter User_Code");
				return new ModelAndView("errorLogin");
			}
			ch = user.getUserPassword();
			if (Validation.validateNull(ch)) {

			} else {
				request.setAttribute("msg", "Please Enter User_Password");
				return new ModelAndView("errorLogin");
			}

			user = userdao.find(user);

			flag = (user.getUserRole() != null);

			if (flag) {

				String value = request.getParameter("rememberMe");

				boolean rememberMe = false;

				if (value != null && value.equalsIgnoreCase("on")) {

					rememberMe = true;
				}
				if (rememberMe) {

					Cookie cookieUsername = new Cookie("username", user.getUserCode());
					Cookie cookiePassword = new Cookie("password", user.getUserPassword());

					cookieUsername.setMaxAge(60 * 60 * 24 * 365);
					cookiePassword.setMaxAge(60 * 60 * 24 * 365);
					response.addCookie(cookieUsername);
					response.addCookie(cookiePassword);

				}

				if ("maker".equals(user.getUserRole())) {
					session.setAttribute("user", user);
					return new ModelAndView("makerHome");
				} else if ("checker".equals(user.getUserRole())) {
					session.setAttribute("user", user);
					return new ModelAndView("checkerHome");
				}

				else {
					request.setAttribute("msg", "No Role Assigned");
					return new ModelAndView("errorLogin");
				}

			} else {
				request.setAttribute("msg", "Your UserName or Password will not Correct," + "Please login first");
				return new ModelAndView("errorLogin");
			}

		} else {

			return new ModelAndView("login");
		}
	}

	@RequestMapping("/home")
	public ModelAndView home(User user, @ModelAttribute("customer") Customer customer, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {

		session = request.getSession(false);

		if (session != null) {

			boolean flag = false;

			user = (User) session.getAttribute("user");

			flag = (user.getUserRole() != null);

			if (flag) {

				if ("maker".equals(user.getUserRole())) {
					session.setAttribute("user", user);
					return new ModelAndView("makerHome");
				} else if ("checker".equals(user.getUserRole())) {
					session.setAttribute("user", user);
					return new ModelAndView("checkerHome");
				}

				else {
					request.setAttribute("msg", "No Role Assigned");
					return new ModelAndView("errorLogin");
				}

			} else {
				request.setAttribute("msg", "Your UserName or Password will not Correct," + "Please login first");
				return new ModelAndView("errorLogin");
			}

		} else {

			return new ModelAndView("login");
		}
	}

}
