package com.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dao.CustomerDAO;
import com.model.Customer;
import com.model.User;

@Controller
public class SaveCustomer {

	@Autowired
	CustomerDAO cdao;

	@RequestMapping("/saveCustomer")
	public ModelAndView save(@ModelAttribute("customer") Customer customer, BindingResult br,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		session = request.getSession(false);
		User user = null;
		if (session != null) {
			user = (User) session.getAttribute("user");
			if (br.hasErrors()) {
				return new ModelAndView("makerHome");
			}
			String date = new SimpleDateFormat("dd-MM-yyyy").format(new Date());
			String createdName = user.getUserName();
			String c = null;
			boolean flag = false;

			customer.setCreatedDate(date);
			customer.setCreatedBy(createdName);
			customer.setAuthorizedBy(c);
			customer.setAuthorizedDate(c);
			customer.setModifiedBy(c);
			customer.setModifiedDate(c);

			flag = cdao.save(customer);

			if (flag) {
				request.setAttribute("msg", "Successfully saved in database");
				return new ModelAndView("makerHome");
			} else {
				request.setAttribute("msg", "Not saved in database");
				return new ModelAndView("makerHome");
			}

		} else {
			request.setAttribute("msg", "Session experied");
			return new ModelAndView("login", "user", user);
		}
	}

}
