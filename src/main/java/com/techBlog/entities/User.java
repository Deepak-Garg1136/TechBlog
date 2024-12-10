package com.techBlog.entities;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.Date;


import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.annotation.Nonnull;
import java.util.List;
import java.util.Set;
@Entity
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name = "user_name", length = 40)
	@Nonnull
	private String name;

	@Column(length = 100, unique = true)
	@Nonnull

	private String email;

	@Column(columnDefinition = "LONGTEXT")
	@Nonnull
	private String password;

	@Column(name = "reg_date")
	@Nonnull
	private Timestamp dateTimestamp;

	@Column(name = "profile_image")
	@Nonnull
	private String profileImage;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private List<Posts> posts;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private Set<Likes> likes;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private List<ContactUs> contactUs;
	
	public User() {
		super();
		this.profileImage = "default.png";
		// TODO Auto-generated constructor stub
	}

	public User(String name, String email, String password) {
		super();
		this.name = name;
		this.email = email;
		this.password = password;
		this.dateTimestamp = Timestamp.from(Instant.now());
		this.profileImage = "default.png";
	}

	public User(String name, String email, String password, Timestamp dateTimestamp, String profileImage,
			List<Posts> posts) {
		super();
		this.name = name;
		this.email = email;
		this.password = password;
		this.dateTimestamp = Timestamp.from(Instant.now());
		this.profileImage = profileImage;
		this.posts = posts;
	}

	public User(String name, String email, String password, Timestamp dateTimestamp, String profileImage,
			List<Posts> posts, Set<Likes> likes, List<ContactUs> contactUs) {
		super();
		this.name = name;
		this.email = email;
		this.password = password;
		this.dateTimestamp = Timestamp.from(Instant.now());
		this.profileImage = profileImage;
		this.posts = posts;
		this.likes = likes;
		this.contactUs = contactUs;
	}

	public List<ContactUs> getContactUs() {
		return contactUs;
	}

	public void setContactUs(List<ContactUs> contactUs) {
		this.contactUs = contactUs;
	}

	public Set<Likes> getLikes() {
		return likes;
	}

	public void setLikes(Set<Likes> likes) {
		this.likes = likes;
	}

	public User(String name, String email, String password, Timestamp dateTimestamp, String profileImage,
			List<Posts> posts, Set<Likes> likes) {
		super();
		this.name = name;
		this.email = email;
		this.password = password;
		this.dateTimestamp = dateTimestamp;
		this.profileImage = profileImage;
		this.posts = posts;
		this.likes = likes;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Timestamp getDateTimestamp() {
		return dateTimestamp;
	}

	public void setDateTimestamp(Timestamp dateTimestamp) {
		this.dateTimestamp = dateTimestamp;
	}

	public String getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}

	public List<Posts> getPosts() {
		return posts;
	}

	public void setPosts(List<Posts> posts) {
		this.posts = posts;
	}

}
