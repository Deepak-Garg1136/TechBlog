package com.techBlog.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.techBlog.entities.Likes;

public class LikeDao {
	private Session session = null;
	
	public LikeDao(Session session) {
		this.session = session;
	}
	
	public boolean saveLike(Likes likes) {
		try {
			Transaction transaction = session.beginTransaction();
			session.persist(likes);
			transaction.commit();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return false;
		}
		
	}
	
	public int countLikeOnPost(int postId) {
		try {
			String queryString = "Select count(*) From Likes Where posts.pId =: postId";
			Query<Long> query = session.createQuery(queryString, Long.class);
			query.setParameter("postId", postId);
			int count = query.uniqueResult().intValue();
			return count;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return 0;
		}finally {
			session.close();
		}
	}
	
	public boolean hasLiked(int postId, int userId) {
		try {
			String queryString = "From Likes Where posts.pId =: postId and user.id =: userId";
			Query<Likes> query = session.createQuery(queryString);
			query.setParameter("postId", postId);
			query.setParameter("userId", userId);
			return query.uniqueResult() != null;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean disLike(int postId, int userId) {
		try {
			Transaction transaction = session.beginTransaction();
			String queryString = "Delete From Likes Where posts.pId =: postId and user.id =: userId";
			Query<Likes> query = session.createQuery(queryString);
			query.setParameter("postId", postId);
			query.setParameter("userId", userId);
			int rowsAffected = query.executeUpdate();
			transaction.commit();
			return rowsAffected > 0;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return false;
		}
	}
	
	public int popularPost() {
		try {
			String query = "Select posts.pId from Likes group by posts.pId order by count(posts.pId) desc";
			Query<Integer> query2 = session.createQuery(query, Integer.class);
			query2.setMaxResults(1);
			Integer result = query2.uniqueResult();
			System.out.println(result);
			return result;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return 0;
		}finally {
			session.close();
		}
	}
}
