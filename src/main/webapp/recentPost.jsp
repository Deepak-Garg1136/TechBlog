<%@page import="org.json.JSONObject"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.techBlog.entities.Posts"%>
<%@page import="java.util.List"%>
<%@page import="com.techBlog.entities.User"%>
<%@page import="com.techBlog.helper.SessionProvider"%>
<%@page import="com.techBlog.dao.PostDao"%>
<%
PostDao postDao = new PostDao(SessionProvider.getSession());
User user = (User) session.getAttribute("currentUser");
StringBuilder sb = new StringBuilder();
String data = "";
BufferedReader reader = request.getReader();
while((data = reader.readLine()) != null){
	sb.append(data);
}
JSONObject jsonObject = new JSONObject(sb.toString());
int all = jsonObject.getInt("all");
List<Posts> posts =  null;
if(all == 0){
	posts = postDao.getAllRecentPostsOfCurrentUser(user.getId());
}else{
	posts = postDao.getAllRecentPosts();
}
for(Posts p : posts){
	LocalDate dateOnly = p.getpDate().toLocalDateTime().toLocalDate();
	DateTimeFormatter oDateTimeFormatter = DateTimeFormatter.ofPattern("MMM d, yyyy");
	String formattedDate = dateOnly.format(oDateTimeFormatter);
%>
<div class = "recentPosts" style="cursor: pointer;">
							<a href = "<%=application.getContextPath()%>/post_details.jsp?post_id=<%=p.getpId() %>" class = "recentImg" style="text-decoration: none">
							<img alt="" src="blogPic/<%=p.getpPic()%>">
							</a>
							<div class = "recentDetail">
							<a href = "<%=application.getContextPath()%>/post_details.jsp?post_id=<%=p.getpId() %>" class="posttitle"><%=p.getpTitle() %><br><%=formattedDate%></a>
							</div>
						</div>
<%
}
%>