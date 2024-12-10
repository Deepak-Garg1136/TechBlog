package com.techBlog.dao;

import java.io.Console;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.techBlog.entities.User;
import com.techBlog.helper.SessionProvider;

import jakarta.servlet.http.HttpSession;

public class UserDao {
	private Session session;

	public UserDao(Session session) {
		this.session = session;
	}

	public boolean saveUser(User user) {
		System.out.println(session);
		try {
			Transaction transaction = session.beginTransaction();
			System.out.println("inside");
			session.persist(user);
			transaction.commit();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return false;
		}

	}

	public User getUserDetails(String email) {
		User user = null;
		try {
			String queryString = "From User Where email = :email ";
			Query<User> query = session.createQuery(queryString, User.class);
			query.setParameter("email", email);
			user = query.uniqueResult();
			System.out.println(user.getEmail());
			return user;

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			
			return user;
		}
	}

	public boolean updateUser(User user) {
		try {
			Transaction transaction = session.beginTransaction();
			User user2 = session.get(User.class, user.getId());
			user2.setName(user.getName());
			user2.setEmail(user.getEmail());
			user2.setProfileImage(user.getProfileImage());
			user2.setPassword(user.getPassword());
			transaction.commit();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return false;
		}
	}

	public String getHashedPasswordByEmail(String email) {
		String passString = "";
		try {
			String queryString = "From User Where email = :email";
			Query<User> query = session.createQuery(queryString, User.class);
			query.setParameter("email", email);
			User user = query.uniqueResult();
			passString = user.getPassword();
			return passString;

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return passString;
		}
	}
}
