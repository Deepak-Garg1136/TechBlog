package com.techBlog.servlets;

import java.io.File;
import java.io.IOException;
import java.lang.ProcessBuilder.Redirect;

import org.mindrot.jbcrypt.BCrypt;

import com.techBlog.dao.UserDao;
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

@WebServlet("/edit")
@MultipartConfig
public class EditServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String userName = req.getParameter("userName");
		String email = req.getParameter("userEmail");
		String password = req.getParameter("userPassword");
		Part part = req.getPart("profilePic");
		String saltString = BCrypt.gensalt(12);
		String hashedPasswordString = BCrypt.hashpw(password, saltString);
//		updating data to the session
		HttpSession session = req.getSession();
		User user = (User) session.getAttribute("currentUser");
		user.setEmail(email);
		user.setPassword(hashedPasswordString);
		user.setName(userName);
		String imageName = null;
		String oldImageName = user.getProfileImage();
		if(part != null) {
			imageName = part.getSubmittedFileName();
			user.setProfileImage(imageName);
		}
		res.setContentType("applicaton/json");
//		updating data to the database
		try {
			Thread.sleep(1000);
			UserDao userDao = new UserDao(SessionProvider.getSession());
			boolean isUpdate = userDao.updateUser(user);
			if (isUpdate) {
				if (part != null) { 
					String path = getServletContext().getRealPath("/profilePic") + File.separator + user.getProfileImage();
					ImageHandler imageHandler = new ImageHandler();
					if (!oldImageName.equalsIgnoreCase("default.png")) {
						String path1 = getServletContext().getRealPath("/profilePic") + File.separator + oldImageName;
						System.out.println(path1);
						imageHandler.deleteFile(path1);
					}
					if (imageHandler.saveFile(part.getInputStream(), path)) {
						res.getWriter().write("{\"message\" : \"Profile updated successfully!\", \"redirect\" : \"profile.jsp\"}");
					}else {
						res.getWriter().write("{\"message\" : \"Something went wrong!\"}");
					}
				}else {
					res.getWriter().write("{\"message\" : \"Profile updated successfully!\" , \"redirect\" : \"profile.jsp\"}");
				}

			} else {
				res.getWriter().write("{\"message\" : \"Something went wrong!\"}");
			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
