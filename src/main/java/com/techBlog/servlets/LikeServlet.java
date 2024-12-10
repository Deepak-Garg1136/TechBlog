package com.techBlog.servlets;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import org.hibernate.Session;
import org.json.JSONObject;

import com.techBlog.dao.LikeDao;
import com.techBlog.entities.Likes;
import com.techBlog.entities.Posts;
import com.techBlog.entities.User;
import com.techBlog.helper.SessionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/likeServlet")
public class LikeServlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		PrintWriter writer = res.getWriter();
		Session session = SessionProvider.getSession();
		try {
			StringBuilder sBuilder  = new StringBuilder();
			String dataString = "";
			BufferedReader reader = req.getReader();
			while((dataString = reader.readLine()) != null) {
				sBuilder.append(dataString);
			}
			res.setContentType("application/json");
			JSONObject jsonData = new JSONObject(sBuilder.toString());
			int postId = jsonData.getInt("postId");
			int userId = jsonData.getInt("userId");
			String operationString = jsonData.getString("operation");
			LikeDao likeDao = new LikeDao(session);
			if(operationString.equalsIgnoreCase("hasLikedPost")) {
				if(likeDao.hasLiked(postId, userId)) {
					writer.println("{\"message\" : \"likedPost\"}");
				}else {
					writer.println("{\"message\" : \"notLiked\"}");
				}
			}else {				
				Posts posts = session.get(Posts.class, postId);
				HttpSession session2 = req.getSession();
				User user =(User) session2.getAttribute("currentUser");

				Likes likes = new Likes(posts, user);
				if(!likeDao.hasLiked(postId, userId)) {
					if(likeDao.saveLike(likes)) {
						writer.println("{\"message\" : \"true\"}");
					}else {
						System.out.println("1");
						writer.println("{\"message\" : \"false\"}");
					}				
				}else {
					if(likeDao.disLike(postId, userId)) {
						writer.println("{\"message\" : \"dislike\"}");
					}else {
						System.out.println("2");
						writer.println("{\"message\" : \"false\"}");
					}
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("3");
			e.printStackTrace();
			writer.println("{\"message\" : \"false\"}");
		}finally {
			session.close();
		}
	}
}
