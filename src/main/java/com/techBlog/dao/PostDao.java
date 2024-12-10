package com.techBlog.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.techBlog.entities.Category;
import com.techBlog.entities.Posts;

public class PostDao {
	 private Session session;
	 
	 public PostDao(Session session) {
		 this.session = session;
	 }
	 
	 public ArrayList<Category> getAllCategories(){
		 ArrayList<Category> list = new ArrayList<>();
		 try {
			String query = "From Category";
			Query<Category> resultQuery =  session.createQuery(query);
			List<Category> resultCategories =  resultQuery.list();
			list.addAll(resultCategories);
			return list;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return list;
		}
		 
	 }
	 
	 public boolean savePost(Posts posts) {
		 try {
			 Transaction transaction = session.beginTransaction();
			 session.persist(posts);
			 transaction.commit();
			 return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			
		}finally {
			session.close();
		}
		 return false;
	 }
	 
	 public List<Posts> getAllPosts(){
		 List<Posts> list = new ArrayList<>();
		 try {
			String queryString = "From Posts";
			Query<Posts> query = session.createQuery(queryString);
			List<Posts> resultList =  query.list();
			list.addAll(resultList);
			return list;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return list;
		}finally {
			session.close();
		}
	 }
	 
	 public List<Posts> getAllPostsOfCurrentUser(int userId){
		 List<Posts> list = new ArrayList<>();
		 try {
			String queryString = "From Posts Where user.id =: userId";
			Query<Posts> query = session.createQuery(queryString);
			query.setParameter("userId", userId);
			List<Posts> resultList =  query.list();
			list.addAll(resultList);
			return list;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return list;
		}finally {
			session.close();
		}
	 }
	 
	 public List<Posts> getPostByCategoryId(int categoryId){
		 List<Posts> list = new ArrayList<>();
		 try {
			String queryString = "From Posts Where category.categoryId =: catId ";			
			Query<Posts> query = session.createQuery(queryString);
			query.setParameter("catId", categoryId);
			List<Posts> resultList =  query.list();
			list.addAll(resultList);
			System.out.println(list);	
			return list;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return list;
		} finally {
			session.close();
		}
	 }
	 
	 
	 public List<Posts> getPostByCategoryIdOfCurrentUser(int categoryId, int userId){
		 List<Posts> list = new ArrayList<>();
		 try {
			String queryString = "From Posts Where category.categoryId =: catId and user.id =: userId";
			
			Query<Posts> query = session.createQuery(queryString);
			query.setParameter("catId", categoryId);
			query.setParameter("userId", userId);
			List<Posts> resultList =  query.list();
			list.addAll(resultList);
			System.out.println(list);	
			return list;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return list;
		} finally {
			session.close();
		}
	 }
	 
	 public List<Posts> getAllRecentPosts(){
		 List<Posts> list = new ArrayList<>();
		 try {
			String queryString = "From Posts  order by pId Desc";
			Query<Posts> query = session.createQuery(queryString);
			query.setMaxResults(4);
			List<Posts> resultList =  query.list();
			list.addAll(resultList);
			return list;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return list;
		}finally {
			session.close();
		}
	 }
	 
	 
	 public List<Posts> getAllRecentPostsOfCurrentUser(int userId){
		 List<Posts> list = new ArrayList<>();
		 try {
			String queryString = "From Posts Where user.id =: userId order by pId Desc";
			Query<Posts> query = session.createQuery(queryString);
			query.setParameter("userId", userId);
			query.setMaxResults(4);
			List<Posts> resultList =  query.list();
			list.addAll(resultList);
			return list;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return list;
		}finally {
			session.close();
		}
	 }
	 
	 public Posts getPostByPostId(int postId){
		 Posts posts = null;
		 try {
			String queryString = "From Posts Where pId =: postId";
			Query<Posts> query = session.createQuery(queryString);
			query.setParameter("postId", postId);
			posts = new Posts();
			posts = query.uniqueResult();
			return posts;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return posts;
		}finally {
			session.close();
		}
	 }
}
