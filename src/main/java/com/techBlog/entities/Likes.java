package com.techBlog.entities;

import com.techBlog.entities.Posts;
import com.techBlog.entities.User;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
	@Entity
	public class Likes {
		@Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int likeId;
	
	@ManyToOne
	 @JoinColumn(name = "post_id", nullable = false)
	private Posts posts;

	@ManyToOne
	 @JoinColumn(name = "user_id", nullable = false)
	private User user;

	public Likes() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Likes(Posts posts, User user) {
		super();
		this.posts = posts;
		this.user = user;
	}

	public int getLikeId() {
		return likeId;
	}

	public void setLikeId(int likeId) {
		this.likeId = likeId;
	}

	public Posts getPosts() {
		return posts;
	}

	public void setPosts(Posts posts) {
		this.posts = posts;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
		
	}

