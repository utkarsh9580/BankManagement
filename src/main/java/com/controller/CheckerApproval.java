package com.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dao.CustomerDAO;
import com.model.Customer;
import com.model.User;

@Controller
public class CheckerApproval {

	@Autowired
	CustomerDAO cdao;

	@RequestMapping("/ccheckerApproval")
	public ModelAndView checkerApproval(User user, @ModelAttribute("customer") Customer customer,
			HttpServletRequest request, HttpSession session) {
		request.getSession(false);

		user = (User) session.getAttribute("user");

		String status = request.getParameter("status");

		boolean flag = false;

		String date = new SimpleDateFormat("dd-MM-yyyy").format(new Date());

		String authorizedby = user.getUserName();

		String button = request.getParameter("buttonapproval");

		String[] customerCheck = request.getParameterValues("customerCheck");

		customer.setAuthorizedDate(date);

		customer.setAuthorizedBy(authorizedby);

		// approved the customer

		if (button != null && ("APPROVE").equals(button)) {

			if (customerCheck != null) {

				for (int i = 0; i < customerCheck.length; i++) {

					String string = customerCheck[i];

					String[] parts = string.split(",");

					customer.setCode(parts[0]);

					customer.setRecordStatus("A");

					if (parts[1] != null && !parts[1].equals("D")) {

						flag = cdao.updateApprovalForApproved(customer);
					}

					else if (parts[1] != null && parts[1].equals("D")) {

						customer.setFlag("I");

						flag = cdao.updateApprovalForDeletedApproved(customer);
					}

				}

			}

		}

		// Reject the Customer

		else if (button != null && ("REJECT").equals(button)) {

			if (customerCheck != null) {

				for (int i = 0; i < customerCheck.length; i++) {

					String string = customerCheck[i];

					String[] parts = string.split(",");

					customer.setCode(parts[0]);

					if (parts[1] != null) {

						customer.setRecordStatus(parts[1] + "R");

						flag = cdao.updateApprovalForReject(customer);
					}

				}

			}

		}

		if (flag) {

			session.setAttribute("msg", "Successfully approv/reject in database");
			return new ModelAndView("redirect:/customerOnStatus?status=" + status);

		} else {
			session.setAttribute("msg", "Not approv/reject in database");
			return new ModelAndView("redirect:/customerOnStatus?status=" + status);
		}

	}

}
