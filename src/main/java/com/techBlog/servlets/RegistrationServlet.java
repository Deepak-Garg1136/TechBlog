package com.techBlog.servlets;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import org.hibernate.Session;
import org.json.JSONObject;
import org.mindrot.jbcrypt.BCrypt;

import com.techBlog.dao.UserDao;
import com.techBlog.entities.User;
import com.techBlog.helper.SessionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")

public class RegistrationServlet extends HttpServlet{
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		try {
			StringBuilder builder = new StringBuilder();
			String dataString = "";
			BufferedReader reader = req.getReader();
			while((dataString = reader.readLine()) != null) {
				builder.append(dataString);
			}
			
			JSONObject jsonData = new JSONObject(builder.toString());
			
			String nameString = jsonData.getString("userName");
			String emailString = jsonData.getString("email");
			String passwordString = jsonData.getString("password");
			
			String salt = BCrypt.gensalt(12);
			String hashedPassword = BCrypt.hashpw(passwordString, salt);
			PrintWriter writer = res.getWriter();
			res.setContentType("application/json");			Thread.sleep(2000);
			User user = new User(nameString, emailString, hashedPassword);
			UserDao userDao = new UserDao(SessionProvider.getSession());
			if(userDao.saveUser(user)) {
				res.setStatus(200);
				writer.write("{\"message\" : \"User Registered Successsfully\", \"redirect\" : \"login.jsp\"}");
			}else {
				 res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
				writer.write("{\"message\" : \"Something went wrong\"}");
			}
		} catch (Exception e) {
			e.printStackTrace();
            res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            res.getWriter().println("{\"message\" : \"Internal server error\"}");
		}
	}
}
