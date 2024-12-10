package com.techBlog.dao;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.techBlog.entities.ContactUs;

public class ContactDao {
	private Session session;
	
	public ContactDao(Session session) {
		this.session = session;
	}
	
	public boolean saveContactDetails(ContactUs contactUs) {
		try {
			Transaction transaction = session.beginTransaction();
			session.persist(contactUs);
			transaction.commit();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return false;
		}finally {
			session.close();
		}
	}
}
