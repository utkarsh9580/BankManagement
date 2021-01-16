package com.dao;

/*import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.dao.DataAccessException;*/

import java.util.List;

import org.hibernate.Query;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.model.User;

@Repository
public class UserDAOImpl implements UserDAO {

	@Autowired
	private SessionFactory sesFact;

	@Transactional
	@SuppressWarnings("unchecked")
	@Override
	public User find(User user) {

		Query query = sesFact.getCurrentSession().createQuery("from User where userCode=? and userPassword=?");
		query.setParameter(0, user.getUserCode());
		query.setParameter(1, user.getUserPassword());
		List<User> userList = query.list();
		user = null;
		if (userList != null) {
			user = userList.get(0);
		}
		return user;
	}

}
