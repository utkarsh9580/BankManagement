package com.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.transaction.annotation.Transactional;

import com.model.Customer;

@Transactional
public class CustomerDAOImpl implements CustomerDAO {

	@Autowired
	DataSource datasource;

	@Autowired
	private SessionFactory sesFact;

	JdbcTemplate template;

	@Override
	public boolean save(Customer customer) {
		boolean flag = false;
		Session session = sesFact.openSession();
		session.save(customer);
		session.flush();
		session.close();
		flag = true;
		return flag;
	}

	@Override
	public Customer find(Customer customer) {		
		Query query = sesFact.getCurrentSession().createQuery("from Customer where code=?");
		query.setParameter(0, customer.getCode());
		List<Customer> cusList = query.list();
		if (cusList != null) {
			return cusList.get(0);
		}
		return customer;
	}

	@Override
	public Customer view(Customer customer) {		
		Query query = sesFact.getCurrentSession().createQuery("from Customer where code=?");
		query.setParameter(0, customer.getCode());
		List<Customer> cusList = query.list();
		if (cusList != null) {
			return cusList.get(0);
		}
		return customer;
	}

	@Override
	public Customer viewAuthorized(Customer customer) {
		Query query = sesFact.getCurrentSession().createQuery("from Customer where code=?");
		query.setParameter(0, customer.getCode());
		List<Customer> cusList = query.list();
		if (cusList != null) {
			return cusList.get(0);
		}
		return customer;
	}

	@Override
	public List<Customer> viewAll() {
		
		Query query = sesFact.getCurrentSession().createQuery("from Customer order by id");
		List<Customer> cusList = query.list();
		if (cusList != null) {
			return cusList;
		}
		return null;
	}

	@Override
	public List<Customer> viewAllOnName(Customer customer) {

		Query query = sesFact.getCurrentSession().createQuery("from Customer where name=?");
		query.setParameter(0, customer.getName());
		List<Customer> cusList = query.list();
		if (cusList != null) {
			return cusList;
		}
		return null;
	}

	@Override
	public boolean delete(Customer customer) {
		boolean flag = false;
		template = new JdbcTemplate(datasource);
		Object obj[] = { customer.getCode(), customer.getRecordStatus() };
		int i = template.update("delete from BANK_CUSTOMER where code=? and recordStatus<>?", obj);
		flag = (i == 1);
		return flag;
	}

	@Override
	public boolean deleteAuthorized(Customer customer) {
		boolean flag = false;
		Session session = sesFact.openSession();
		session.update("Customer", customer);
		session.flush();
		session.close();
		flag = true;
		return flag;
	}

	@Override
	public boolean update(Customer customer) {
		boolean flag = false;
		Session session = sesFact.openSession();
		session.update("Customer", customer);
		session.flush();
		session.close();
		flag = true;
		return flag;
	}

	// update from master

	@Override
	public boolean updateAuthorized(Customer customer) {
		boolean flag = false;
		Session session = sesFact.openSession();
		session.update("Customer", customer);
		session.flush();
		session.close();
		flag = true;
		return flag;
	}

	@Override
	public List<Customer> viewAllOnStatus(String status) {
		Query query = sesFact.getCurrentSession().createQuery("from Customer where recordStatus=?");
		query.setParameter(0, status);
		List<Customer> cusList = query.list();
		if (cusList != null) {
			return cusList;
		}
		return null;
	}

	@Override
	public List<Customer> viewAllOnStatusReject(String status) {
		Query query = sesFact.getCurrentSession().createQuery("from Customer where recordStatus like ?");
		query.setParameter(0, "%"+status+"%");
		List<Customer> cusList = query.list();
		if (cusList != null) {
			return cusList;
		}
		return null;
	}

	@Override
	public boolean updateApprovalForApproved(Customer customer) {
		boolean flag = false;
		Session session = sesFact.openSession();
		session.update("Customer", customer);
		session.flush();
		session.close();
		flag = true;
		return flag;
	}

	@Override
	public boolean updateApprovalForDeletedApproved(Customer customer) {
		boolean flag = false;
		Session session = sesFact.openSession();
		session.update("Customer", customer);
		session.flush();
		session.close();
		flag = true;
		return flag;
	}

	@Override
	public boolean updateApprovalForReject(Customer customer) {
		boolean flag = false;
		Session session = sesFact.openSession();
		session.update("Customer", customer);
		session.flush();
		session.close();
		flag = true;
		return flag;
	}

}
