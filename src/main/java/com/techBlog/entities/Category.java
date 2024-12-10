package com.techBlog.entities;

import java.util.List;

import jakarta.annotation.Nonnull;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;

@Entity
public class Category {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "category_id")
	private int categoryId;
	
	@Nonnull
	private String cName;
	
	private String cDescription;
	
	@OneToMany(mappedBy = "category", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private List<Posts> posts;

	public Category() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Category(String cName, List<Posts> posts) {
		super();
		this.cName = cName;
		this.posts = posts;
	}

	public Category(String cName, String cDescription, List<Posts> posts) {
		super();
		this.cName = cName;
		this.cDescription = cDescription;
		this.posts = posts;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public String getcName() {
		return cName;
	}

	public void setcName(String cName) {
		this.cName = cName;
	}

	public String getcDescription() {
		return cDescription;
	}

	public void setcDescription(String cDescription) {
		this.cDescription = cDescription;
	}

	public List<Posts> getPosts() {
		return posts;
	}

	public void setPosts(List<Posts> posts) {
		this.posts = posts;
	}
	
	
}
