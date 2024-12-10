
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.techBlog.entities.User"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="com.techBlog.entities.Posts"%>
<%@page import="java.util.List"%>
<%@page import="com.techBlog.helper.SessionProvider"%>
<%@page import="com.techBlog.dao.PostDao"%>
<div class = "row myPosts">
<%
PostDao postDao = new PostDao(SessionProvider.getSession());
List<Posts> posts = null;
User user = (User) session.getAttribute("currentUser");
int userId = user.getId();
StringBuilder sb = new StringBuilder();
String data = "";
BufferedReader reader = request.getReader();
while((data = reader.readLine()) != null){
	sb.append(data);
}
JSONObject jsonObject = new JSONObject(sb.toString());
int cid = jsonObject.getInt("cid");
int all = jsonObject.getInt("all");
if(session.getAttribute("postCategoryId") != null){
	Integer pcid = (Integer) session.getAttribute("postCategoryId");
	int postcid = pcid;
	 posts = postDao.getPostByCategoryId(postcid);
	 session.removeAttribute("postCategoryId");
}else{
	 if(cid == 0){
		 if(all == 0){
			posts = postDao.getAllPostsOfCurrentUser(userId);		 
		 }else{
			 posts = postDao.getAllPosts();
		 }
	 }else{
		 if(all == 0){
			 posts = postDao.getPostByCategoryIdOfCurrentUser(cid, userId);		 
		 }else{
			 posts = postDao.getPostByCategoryId(cid);
		 }
	 }	
}
for (Posts p : posts) {
LocalDate dateOnly = p.getpDate().toLocalDateTime().toLocalDate();
DateTimeFormatter oDateTimeFormatter = DateTimeFormatter.ofPattern("MMM d, yyyy");
String formattedDate = dateOnly.format(oDateTimeFormatter);
%>



	<div class="card cards" style="width: 18rem;">
		<img src="blogPic/<%=p.getpPic() %>" class="card-img-top" alt="..." style="height: 34vh">
		<div class="card-body">
			<h6 class="card-title"><%= p.getpTitle() %></h6>
			<div class="namediv">
			<span class="card-text" style="font-size: 13px;">By: <%=p.getUser().getName() %></span>
			<span class="card-text" style="font-size: 13px;"><i class="fa-regular fa-clock"></i> <%=formattedDate%></span>			
			</div>
			<p class="card-text content"><%= p.getpContent() + "..."%></p>
			<a href="<%=application.getContextPath()%>/post_details.jsp?post_id=<%=p.getpId() %>" class="btn btn-primary">Read More</a>
		</div>
	</div>



<%
}
%>
</div>