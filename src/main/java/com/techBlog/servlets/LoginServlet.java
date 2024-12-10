package com.techBlog.servlets;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import org.hibernate.Session;
import org.json.JSONObject;
import org.mindrot.jbcrypt.BCrypt;

import com.techBlog.dao.UserDao;
import com.techBlog.entities.Message;
import com.techBlog.entities.User;
import com.techBlog.helper.SessionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        StringBuilder builder = new StringBuilder();
        String dataString;

        Message message;
        Session session = SessionProvider.getSession();
        try (BufferedReader reader = req.getReader(); PrintWriter writer = res.getWriter()) {
            res.setContentType("application/json");
            while ((dataString = reader.readLine()) != null) {
                builder.append(dataString);
            }
            JSONObject jsonData = new JSONObject(builder.toString());
            String email = jsonData.getString("email");
            String password = jsonData.getString("password");
            Thread.sleep(2000);
            UserDao userDao = new UserDao(session);
            String hashedPassword = userDao.getHashedPasswordByEmail(email);
            System.out.println(hashedPassword);
            if(!hashedPassword.equalsIgnoreCase("")) {
            	boolean isValidUser = BCrypt.checkpw(password, hashedPassword);
            	if(isValidUser) {
            		User user = userDao.getUserDetails(email);
            		if (user == null) {
                        res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                        message = new Message("Invalid email or password", "error", "alert-danger");
                        writer.println("{\"message\" : \"Invalid email or password\"}");
                    } else {
                    	 HttpSession session1 = req.getSession();
                         session1.setAttribute("currentUser", user);
                         message = new Message("Logged in successfully", "success", "alert-success");
                         writer.println("{\"message\" : \"Logged in successfully\", \"redirect\": \"index.jsp\"}");     
                    }
            	}else {
                	res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                	message = new Message("Invalid email or password", "error", "alert-danger");
                	writer.println("{\"message\" : \"Invalid email or password\"}");
                }
            }else {
            	res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            	message = new Message("Invalid email or password", "error", "alert-danger");
            	writer.println("{\"message\" : \"Invalid email or password\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            message = new Message("Internal server error", "error", "alert-danger");
            
            res.getWriter().println("{\"message\" : \"Server error\"}");
        }finally {
        	 if (session != null && session.isOpen()) {
                 session.close(); // Close the session in the finally block
             }
		}
    }
}
