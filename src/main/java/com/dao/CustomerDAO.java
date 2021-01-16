package com.dao;

import java.util.List;

import com.model.Customer;

public interface CustomerDAO {

	
	public boolean save(Customer customer);
	
	public Customer view(Customer customer);
	
	public Customer find(Customer customer);

	public Customer viewAuthorized(Customer customer);
	
	public List<Customer> viewAll();
	
	public List<Customer> viewAllOnName(Customer customer);

	public boolean delete(Customer customer);

	public boolean deleteAuthorized(Customer customer);

	public boolean update(Customer customer);
	
	public boolean updateAuthorized(Customer customer);

	public List<Customer> viewAllOnStatus(String status);

	public List<Customer> viewAllOnStatusReject(String status);

	public boolean updateApprovalForApproved(Customer customer);

	public boolean updateApprovalForDeletedApproved(Customer customer);

	public boolean updateApprovalForReject(Customer customer);
	
	
}
