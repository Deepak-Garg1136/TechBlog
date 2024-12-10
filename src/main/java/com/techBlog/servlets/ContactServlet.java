package com.techBlog.servlets;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import org.hibernate.Session;
import org.json.JSONObject;

import com.techBlog.dao.ContactDao;
import com.techBlog.dao.PostDao;
import com.techBlog.entities.Category;
import com.techBlog.entities.ContactUs;
import com.techBlog.entities.Posts;
import com.techBlog.entities.User;
import com.techBlog.helper.ImageHandler;
import com.techBlog.helper.SessionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/contactServlet")
public class ContactServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		PrintWriter writer = res.getWriter();
		try {
			StringBuilder stringBuilder = new StringBuilder();
			String dataString = "";
			BufferedReader reader = req.getReader();
			while((dataString = reader.readLine()) != null) {
				stringBuilder.append(dataString);
			}
			
			JSONObject jsonData = new JSONObject(stringBuilder.toString());
			String name = jsonData.getString("name");
			String email = jsonData.getString("email");
			String subject = jsonData.getString("subject");
			String message = jsonData.getString("message");
		    HttpSession session = req.getSession();
		    User user = (User) session.getAttribute("currentUser");
			res.setContentType("application/json");
			System.out.println(name);
			Thread.sleep(1000);
			ContactUs contactUs = new ContactUs(name, email, subject, message, user);
			ContactDao contactDao = new ContactDao(SessionProvider.getSession());
			if(contactDao.saveContactDetails(contactUs)) {
				writer.println("{\"message\" : \"Thank you for contacting us. We will get back to you shortly\"}");
			}else {
				writer.println("{\"message\" : \"Something went wrong. Try again later\"}");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			writer.println("{\"message\" : \"Something went wrong. Try again later\"}");
		}
	}
}
