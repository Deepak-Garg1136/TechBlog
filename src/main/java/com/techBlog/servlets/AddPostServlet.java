package com.techBlog.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import org.hibernate.Session;

import com.techBlog.dao.PostDao;
import com.techBlog.entities.Category;
import com.techBlog.entities.Posts;
import com.techBlog.entities.User;
import com.techBlog.helper.ImageHandler;
import com.techBlog.helper.SessionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/addPost")
@MultipartConfig
public class AddPostServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		try {
			String postTitleString = req.getParameter("postTitle");
			String postContentString = req.getParameter("postContent");
			String postProgramString = req.getParameter("postProgram");
			String postCategory = req.getParameter("postCategory");
			Part part = req.getPart("postImage");
			String postImage = null;
			PrintWriter writer = res.getWriter();
			res.setContentType("application/json");
			if(part != null) {
				postImage = part.getSubmittedFileName();
			
			}
			// getting current user id
			HttpSession session = req.getSession();
			User user = (User) session.getAttribute("currentUser");
			System.out.println(user.getId());
			int userId = user.getId();
			
			Session session2 = SessionProvider.getSession();
			Category category = session2.get(Category.class, postCategory);
				
			Posts posts = new Posts(postTitleString, postContentString, postProgramString, postImage,  null, category, user);
			PostDao postDao = new PostDao(session2);
			if(postDao.savePost(posts)) {
				if(part != null) {
					String pathString = getServletContext().getRealPath("/blogPic") + File.separator + postImage;
					ImageHandler imageHandler = new ImageHandler();
					if(imageHandler.saveFile(part.getInputStream(), pathString)) {
						writer.println("{\"message\" : \"Post save succeessfully\"}");
					}else {
						writer.println("{\"message\" : \"Something went wrong\"}");
					}
				}else {
					writer.println("{\"message\" : \"Post save succeessfully\"}");
				}
			}else {
				writer.println("{\"message\" : \"Something went wrong\"}");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
