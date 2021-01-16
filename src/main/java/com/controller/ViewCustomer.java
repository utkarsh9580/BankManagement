package com.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dao.CustomerDAO;
import com.model.Customer;
import com.model.User;

@Controller
public class ViewCustomer {

	@Autowired
	CustomerDAO cdao;

	@RequestMapping("/viewCustomer")
	public ModelAndView view(@ModelAttribute("customer") Customer customer, BindingResult br,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		if (br.hasErrors()) {
			for (Object object : br.getAllErrors()) {
				if (object instanceof FieldError) {
					FieldError fieldError = (FieldError) object;
					if (fieldError.getField().equals("code")) {
						return new ModelAndView("makerHome");
					}

				}

			}
		}

		session = request.getSession(false);
		User user = null;
		if (session != null) {
			user = (User) session.getAttribute("user");
			boolean flag = false;
			customer = cdao.view(customer);
			flag = (customer.getName() != null);
			if (flag) {
				return new ModelAndView("makerCustomerView", "customer", customer);
			} else {
				customer = cdao.viewAuthorized(customer);
				flag = (customer.getName() != null);
				if (flag) {
					return new ModelAndView("makerCustomerView", "customer", customer);
				} else {
					return new ModelAndView("makerHome", "msg", "No Record To View");
				}
			}
		} else {
			request.setAttribute("msg", "Session experied");
			return new ModelAndView("login", "user", user);
		}
	}

	@RequestMapping("/viewAllCustomer")
	public ModelAndView viewAll(@ModelAttribute("customer") Customer customer, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {

		session = request.getSession(false);
		User user = null;
		if (session != null) {
			user = (User) session.getAttribute("user");
			boolean flag = false;
			List<Customer> ulist = new ArrayList<Customer>();
			ulist = cdao.viewAll();
			flag = (ulist != null);
			if (flag) {
				return new ModelAndView("makerAllCustomerView", "ulist", ulist);
			} else {
				return new ModelAndView("makerHome", "msg", "No Record To View");
			}
		} else {
			request.setAttribute("msg", "Session experied");
			return new ModelAndView("login", "user", user);
		}
	}

	@RequestMapping("/findCustomerNameUpdate")
	public ModelAndView viewAllOnName(@ModelAttribute("customer") Customer customer, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {

		session = request.getSession(false);

		User user = null;

		if (session != null) {

			user = (User) session.getAttribute("user");

			boolean flag = false;

			customer.setName(request.getParameter("customer_name"));

			List<Customer> ulist = new ArrayList<Customer>();

			ulist = cdao.viewAllOnName(customer);

			flag = (ulist != null);

			if (flag) {

				return new ModelAndView("makerAllCustomerViewOnName", "ulist", ulist);
			} else {
				return new ModelAndView("makerHome", "msg", "No Record To View");
			}

		} else {
			request.setAttribute("msg", "Session experied");
			return new ModelAndView("login", "user", user);
		}
	}

}
