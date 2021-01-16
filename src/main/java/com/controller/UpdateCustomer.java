package com.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

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
public class UpdateCustomer {

	@Autowired
	CustomerDAO cdao;

	@RequestMapping("/customerUpdate")
	public ModelAndView findCustomer(@ModelAttribute("customer") Customer customer, BindingResult br,
			HttpServletRequest request, HttpServletResponse response, HttpSession session)

	{

		session = request.getSession(false);

		User user = null;

		if (session != null) {

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

			user = (User) session.getAttribute("user");

			boolean flag = false;

			customer = cdao.view(customer);

			flag = (customer.getName() != null);

			if (flag) {

				return new ModelAndView("updateCustomer", "customer", customer);
			} else {

				customer = cdao.viewAuthorized(customer);

				flag = (customer.getName() != null);

				if (flag) {

					return new ModelAndView("updateCustomer", "customer", customer);
				}

				else {
					return new ModelAndView("makerHome", "msg", "No Customer of This Code To Update");
				}

			}

		} else {
			request.setAttribute("msg", "Session experied");
			return new ModelAndView("login", "user", user);
		}
	}

	@RequestMapping("/updateCustomer")
	public ModelAndView updateCustomer(@ModelAttribute("customer") Customer customer, BindingResult br,
			HttpServletRequest request, HttpServletResponse response, HttpSession session)

	{

		session = request.getSession(false);

		User user = null;

		if (session != null) {

			if (br.hasErrors()) {
				return new ModelAndView("updateCustomer");
			}

			user = (User) session.getAttribute("user");

			String date = new SimpleDateFormat("dd-MM-yyyy").format(new Date());

			String modifiedName = user.getUserName();

			boolean flag = false;

			customer.setModifiedDate(date);
			customer.setModifiedBy(modifiedName);

			String status = customer.getRecordStatus();

			if (null != status && (status.equals("A"))) {

				customer.setRecordStatus("M");
				flag = cdao.updateAuthorized(customer);
			}

			else if (null != status && (status.equals("MR") || status.equals("M"))) {
				customer.setRecordStatus("M");
				flag = cdao.update(customer);
			}

			else {
				customer.setRecordStatus(request.getParameter("customer_recordstatus"));
				flag = cdao.update(customer);
			}

			if (flag) {
				return new ModelAndView("makerHome", "msg", "Update Customer");
			} else {
				return new ModelAndView("makerHome", "msg", "Not Update Customer");
			}

		} else {
			return new ModelAndView("login", "user", user);
		}

	}

}
