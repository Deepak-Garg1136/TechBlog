package com.techBlog.entities;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.Set;

import jakarta.annotation.Nonnull;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;

@Entity
public class Posts {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int pId;
	
	@Nonnull
	@Column(columnDefinition = "LONGTEXT")
	private String pTitle;
	
	@Nonnull
	@Column(columnDefinition = "LONGTEXT")
	
	private String pContent;

	@Nonnull
	@Column(columnDefinition = "LONGTEXT")
	
	private String pCode;
	
	private String pPic;
	
	private Timestamp pDate;
	
	@ManyToOne
	@JoinColumn(name = "category_id", nullable = false)
	private Category category;

	@ManyToOne
	@JoinColumn(name = "user_id", nullable = false)
	private User user;

	@OneToMany(mappedBy = "posts", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private Set<Likes> likes;
	
	public Posts() {
		super();
		this.pDate = Timestamp.from(Instant.now());
		// TODO Auto-generated constructor stub
	}

	public Posts(String pTitle, String pContent, String pCode, String pPic) {
		super();
		this.pTitle = pTitle;
		this.pContent = pContent;
		this.pCode = pCode;
		this.pPic = pPic;
		this.pDate = Timestamp.from(Instant.now());
	}

	public Posts(String pTitle, String pContent, String pCode, String pPic, Category category) {
		super();
		this.pTitle = pTitle;
		this.pContent = pContent;
		this.pCode = pCode;
		this.pPic = pPic;
		this.category = category;
		this.pDate = Timestamp.from(Instant.now());
	}

	
	public Posts(String pTitle, String pContent, String pCode, String pPic, Timestamp pDate, Category category,
			User user) {
		super();
		this.pTitle = pTitle;
		this.pContent = pContent;
		this.pCode = pCode;
		this.pPic = pPic;
		this.pDate = pDate;
		this.category = category;
		this.user = user;
		this.pDate = Timestamp.from(Instant.now());
	}

	public Posts(int pId, String pTitle, String pContent, String pCode, String pPic, Timestamp pDate, Category category,
			User user, Set<Likes> likes) {
		super();
		this.pId = pId;
		this.pTitle = pTitle;
		this.pContent = pContent;
		this.pCode = pCode;
		this.pPic = pPic;
		this.pDate = pDate;
		this.category = category;
		this.user = user;
		this.pDate = Timestamp.from(Instant.now());
		this.likes = likes;
	}

	public Set<Likes> getLikes() {
		return likes;
	}

	public void setLikes(Set<Likes> likes) {
		this.likes = likes;
	}

	public int getpId() {
		return pId;
	}

	public void setpId(int pId) {
		this.pId = pId;
	}

	public String getpTitle() {
		return pTitle;
	}

	public void setpTitle(String pTitle) {
		this.pTitle = pTitle;
	}

	public String getpContent() {
		return pContent;
	}

	public void setpContent(String pContent) {
		this.pContent = pContent;
	}

	public String getpCode() {
		return pCode;
	}

	public void setpCode(String pCode) {
		this.pCode = pCode;
	}

	public String getpPic() {
		return pPic;
	}

	public void setpPic(String pPic) {
		this.pPic = pPic;
	}

	public Timestamp getpDate() {
		return pDate;
	}

	public void setpDate(Timestamp pDate) {
		this.pDate = pDate;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
}
