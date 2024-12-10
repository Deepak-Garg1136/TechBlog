package com.techBlog.servlets;

import java.io.IOException;

import com.techBlog.entities.Message;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet{
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		HttpSession session =  req.getSession();
		session.removeAttribute("currentUser");
		Message message = new Message("Logout Successfully", "success", "alert-success");
		session.setAttribute("message", message);
		res.sendRedirect("login.jsp");
	}
}
