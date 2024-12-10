package com.techBlog.entities;

import jakarta.annotation.Nonnull;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class ContactUs {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int contactId;

	@Nonnull
	private String name;
	
	@Nonnull
	private String email;
	
	@Nonnull
	private String subject;
	
	@Nonnull
	private String message;
	
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	public ContactUs() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ContactUs(String name, String email, String subject, String message, User user) {
		super();
		this.name = name;
		this.email = email;
		this.subject = subject;
		this.message = message;
		this.user = user;
	}

	public int getContactId() {
		return contactId;
	}

	public void setContactId(int contactId) {
		this.contactId = contactId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	
}
