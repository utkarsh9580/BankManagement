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
public class DeleteCustomer {

	@Autowired
	private CustomerDAO cdao;

	@RequestMapping("/deleteCustomer")
	public ModelAndView loginPage(@ModelAttribute("customer") Customer customer, BindingResult br,
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
		User user = (User) session.getAttribute("user");
		String date = new SimpleDateFormat("dd-MM-yyyy").format(new Date());
		String modifiedName = user.getUserName();
		boolean flag = false;
		flag = cdao.delete(customer);
		if (flag) {
			request.setAttribute("msg", "Record Deleted");
			return new ModelAndView("makerHome");
		} else {
			customer = cdao.find(customer);
			customer.setRecordStatus("D");
			customer.setModifiedBy(modifiedName);
			customer.setModifiedDate(date);
			flag = cdao.deleteAuthorized(customer);
			if (flag) {
				request.setAttribute("msg", "Record Deleted");
				return new ModelAndView("makerHome");
			} else {
				request.setAttribute("msg", "NO Record To Delete");
				return new ModelAndView("makerHome");
			}
		}

	}

}
