<%@page import="com.techBlog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techBlog.helper.SessionProvider"%>
<%@page import="com.techBlog.dao.PostDao"%>
<nav class="navbar navbar-expand-lg bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="<%=application.getContextPath()%>/index.jsp">TechBlog</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="<%=application.getContextPath()%>/index.jsp">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<%=application.getContextPath()%>/about.jsp">About</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Categories
          </a>
          <ul class="dropdown-menu">
          <%
								PostDao post = new PostDao(SessionProvider.getSession());
								ArrayList<Category> list = post.getAllCategories();
								for (Category c : list) {
								%>
								<li value="<%=c.getCategoryId()%>"><a class="dropdown-item" ><%=c.getcName()%></a></li>
								<%
								}
								%>
          </ul>
        </li>
        <li class="nav-item">
         <a class="nav-link" href="<%=application.getContextPath()%>/contact.jsp">Contact</a>
        </li>
       
      </ul>
    </div>
  </div>
</nav>