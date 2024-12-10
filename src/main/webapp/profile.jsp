<%@page import="com.techBlog.dao.LikeDao"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="com.techBlog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techBlog.helper.SessionProvider"%>
<%@page import="com.techBlog.dao.PostDao"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.BufferedReader"%><%@page
	import="java.time.LocalDate"%>
<%@page import="com.techBlog.entities.Posts"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.techBlog.entities.User, java.lang.Thread"%>
<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("login.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TechBlog</title>
<%@ include file="links.jsp"%>
<style>
/* General form styling */
.modal-content {
	background-color: #121212; /* Modal background */
	box-shadow: 0 6px 12px rgba(0, 0, 0, 0.6); /* Soft shadow for modal */
	height: 90vh;
	overflow-y:scroll; 
}
.modal-content::-webkit-scrollbar {
	display: none;
}

/* Hide scrollbar for Firefox */
.modal-content {
	scrollbar-width: none;
}


.modal-title {
	font-family: "Libre Baskerville", serif;
}

.form-control {
	background-color: #1D1D1D; /* Input field background */
	color: #E2E2E2; /* Text color */
	border: none;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.5);
	/* Initial floating shadow effect */
	padding: 10px;
	transition: transform 0.2s ease, box-shadow 0.2s ease;
	margin-bottom: 15px; /* Space between inputs */
}

.form-control::placeholder {
	color: #A0A0A0; /* Different color for placeholder */
}

.form-control:focus {
	outline: none;
	color: #E2E2E2; /* Keep text color on focus */
	background-color: #1D1D1D; /* Keep background same on focus */
	transform: translateY(-2px); /* Slight lift on focus */
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.7);
	/* Enhanced shadow on focus */
}

.form-label {
	/* 	font-weight: bold; */
	color: #E2E2E2;
	/* 	font-family: "Libre Baskerville", serif; */
}

.btn-close-white {
	filter: brightness(0) invert(1);
}

/* Submit button without shadow */
#postBtn {
	background-color: #007bff; /* Button color */
	border: none;
}

#editBtn:hover, #postBtn:hover {
	background-color: #0056b3; /* Darker shade of blue for hover */
}

.cat {
	color: #FF605D
}
</style>

<style>
@import
	url("https://fonts.googleapis.com/css2?family=Libre+Baskerville&display=swap");

@import
	url('https://fonts.googleapis.com/css2?family=Alkatra&display=swap');

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	/*   font-family: "Libre Baskerville", serif; */
	font-family: 'Alkatra', cursive;
}
/* General body and layout */
body, html {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
	background-color: #f8f9fa;
}

/* Navbar styling */
.navbar {
	position: fixed;
	top: 0;
	width: 100%;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	z-index: 1000;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}
.navbar .navbar-brand {
	font-family: "Libre Baskerville", serif;
	font-size: 1.5em;
	/*     color: #007bff; */
	font-weight: bold;
}
.navbar .navbar-brand {
	font-family: "Libre Baskerville", serif;
	font-size: 1.5em;
	/*     color: #007bff; */
	font-weight: bold;
}

/* Left sidebar styling */
.sidebar {
	/* 	position: fixed; */
	/* 	top: 60px;  */
	/* 	left: 0; */
	width: 17vw; /* Increased width slightly */
	margin-top: 0px;
	background-color: #2c2c2c;
	color: #ffffff;
	padding: 15px; /* Reduced padding */
	display: flex;
	flex-direction: column;
	gap: 5vh;
	/* 	margin-top: cm; */
	/*     justify-content: space-between; */
}

.catHeading, .categories {
	display: flex;
	flex-direction: column;
	/* 	gap:10px */
}

.categories {
	gap: 30px;
}

.sidebar h1 {
	font-size: 1.6em; /* Reduced font size */
	color: #FF605D;
	margin-bottom: 0px;
	font-weight: 500;
	font-family: "Libre Baskerville", serif;
	margin-top: 2vh;
	/* 	margin-bottom: 15px; /* Reduced gap */
	*/
}

.sidebar h5 {
	font-size: 1em; /* Reduced font size */
	cursor: pointer;
	/* 	padding: 6px 5px; /* Reduced padding */
	color: #E2E2E2;
	transition: color 0.3s ease;
}

.sidebar h5.cat {
	height: 2vh;
}

.sidebar h5.cat:hover {
	color: #FF605D;
}

.sidebar p, .sidebar a {
	font-size: 0.8em; /* Reduced font size */
	color: #B8B8B8;
	text-decoration: none;
	padding: 4px 0 0 0; /*Reduced gap */
	*/
}

.sidebar .styleCat {
	color: #FF605D;
	font-size: 1.2em;
}
/* Main content area */
.main-content {
	background-color: #f8f9fa;
	overflow-y: scroll;
}

/* Hide scrollbar for Chrome, Safari, and Opera */
.main-content::-webkit-scrollbar {
	display: none;
}

/* Hide scrollbar for Firefox */
.main-content {
	scrollbar-width: none;
}

.main-content h2 {
	font-size: 1.8em;
	margin-bottom: 2vh !important;
	color: #333;
}

/* Cards container */
.myPosts {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	justify-content: space-between;
}

/* Card styling */
.card.cards {
	flex: 1 1 48%;
	max-width: 47%;
	background-color: #ffffff;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1), 0 8px 12px rgba(0, 0, 0, 0.08),
		0 16px 24px rgba(0, 0, 0, 0.06);
	transition: transform 0.3s, box-shadow 0.3s;
	margin-bottom: 4vh;
	padding: 0px;
}

.card.cards:hover {
	transform: translateY(-5px);
	box-shadow: 0 8px 10px rgba(0, 0, 0, 0.15), 0 10px 30px
		rgba(0, 0, 0, 0.1), 0 20px 40px rgba(0, 0, 0, 0.08);
	cursor: pointer;
}

.card.cards img {
	height: 200px;
	width: 100%;
	object-fit: cover;
}

.card-body {
	display: flex;
	flex-direction: column;
	padding: 15px;
	color: #333;
	gap: 1.2vh;
}

.card-title {
	font-size: 1em;
	color: #007bff;
	text-align: justify;
	font-family: "Libre Baskerville", serif;
	height: 3vh;
	overflow-y: scroll;
}

/* Hide scrollbar for Chrome, Safari, and Opera */
.card-title::-webkit-scrollbar {
	display: none;
}

/* Hide scrollbar for Firefox */
.card-title {
	scrollbar-width: none;
}

.namediv {
	display: flex;
	justify-content: space-between;
	font-size: 0.85em;
	color: #555;
}

.card-text {
	font-size: 0.9em;
	text-align: justify;
}

.content {
	height: 10vh;
	overflow: scroll;
	font-size: 0.95em;
	color: #555;
}

/* Hide scrollbar for Chrome, Safari, and Opera */
.content::-webkit-scrollbar {
	display: none;
}

/* Hide scrollbar for Firefox */
.content {
	scrollbar-width: none;
}

/* Right sidebar styling */
.right-sidebar {
	padding: 20px;
	background-color: #f8f9fa;
	color: #333;
	border-left: 1px solid #ddd;
	max-width: 23vw;
}

.right-sidebar .widget {
	margin-bottom: 30px;
}

.popular-post {
	position: relative;
	width: 100%; /* Adjust width based on the container */
	/* 	max-width: 120px; /* Set a max width for larger screens */
	transition: transform 0.3s, boz-shadow 0.3s;
}
.popular-post:hover{
transform: translateY(-5px);
box-shadow: 0 8px 10px rgba(0, 0, 0, 0.15), 0 10px 30px
		rgba(0, 0, 0, 0.1), 0 20px 40px rgba(0, 0, 0, 0.08);
}

.popular-post img {
	width: 20vw;
	height: 30vh;
}

.post-overlay {
	position: absolute;
	bottom: 0;
	left: 0;
 	background:linear-gradient(to top, rgba(0, 0, 0, 0.8), rgba(0, 0, 0, 0)); /* Semi-transparent background */
	color: white;
	width: 20vw;
	height:30vh;
	padding: 1em;
	box-sizing: border-box;
	text-align: left;
display: flex;
flex-direction: column;
justify-content: flex-end;
}

.post-date {
	font-size: 0.8em; /* Responsive font size */
	margin: 0;
	
}

.post-title {
	font-size: 1em; /* Responsive font size */
	margin: 0;
	text-align: justify;
}

/* Media queries for responsiveness */
@media ( min-width : 600px) {
	.popular-post {
		max-width: 150px;
	}
	.post-date {
		font-size: 0.9em;
	}
	.post-title {
		font-size: 1.1em;
	}
}

@media ( min-width : 900px) {
	.popular-post {
		max-width: 180px;
	}
	.post-date {
		font-size: 1em;
	}
	.post-title {
		font-size: 1.2em;
	}
}

.right-sidebar h4 {
	font-size: 1.3em;
	margin-bottom: 10px;
	color: #007bff;
}

.right-sidebar .widget input.form-control {
	background-color: #eeeeee;
	color: #333;
	border: none;
	padding: 8px;
	margin-bottom: 10px;
}

.right-sidebar ul.list-unstyled {
	padding-left: 0;
	list-style: none;
}

.right-sidebar ul.list-unstyled li {
	padding: 5px 0;
}

.right-sidebar ul.list-unstyled li a {
	color: #555;
	text-decoration: none;
	font-size: 0.95em;
}

.right-sidebar ul.list-unstyled li a:hover {
	color: #333;
}

.recentPosts{
display: flex;
justify-content: space-between;
align-items: center;

}

.recentImg {
	width: 24%;
transition: transform 0.3s, box-shadow 0.3s;
}
.recentImg:hover{
transform: translateY(-5px);
box-shadow: 0 8px 10px rgba(0, 0, 0, 0.15), 0 10px 30px
		rgba(0, 0, 0, 0.1), 0 20px 40px rgba(0, 0, 0, 0.08);
}


.recentDetail{
width: 70%;

}
.recentImg img{
width: 5vw;
height: auto;
}

.posttitle{
font-size: 0.66em;
font-weight:bold;
font-family: "Libre Baskerville", serif; 
margin-bottom: 0px;
text-decoration: none;
color:black;
}
.posttitle:hover{
color:#007BFF
}

.mainRPostDiv{
	display: flex;
	flex-direction: column;
	gap:2vh;
	overflow-y:scroll;
}

.mainRPostDiv::-webkit-scrollbar {
	display: none;
}

/* Hide scrollbar for Firefox */
.mainRPostDiv {
	scrollbar-width: none;
}
/* Responsive adjustments */
@media ( max-width : 768px) {
	.sidebar, .right-sidebar {
		display: none;
	}
	.main-content {
		margin-left: 0;
		width: 100%;
		padding-top: 60px;
	}
	.myPosts {
		flex-direction: column;
	}
	.card.cards {
		width: 100%;
		max-width: 100%;
	}
}
</style>


</head>
<body>
	<!-- navbar -->
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<div class="container-fluid">
			<a class="navbar-brand" href="<%=application.getContextPath()%>/">TechBlog</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-tar get="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="<%=application.getContextPath()%>/">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="<%=application.getContextPath()%>/about.jsp">About</a></li>
					<li class="nav-item"><a class="nav-link" href="<%=application.getContextPath()%>/posts.jsp">Posts</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"> Categories </a>
						<ul class="dropdown-menu">
							<%
							PostDao post = new PostDao(SessionProvider.getSession());
							ArrayList<Category> list = post.getAllCategories();
							for (Category c : list) {
							%>
							<li value="<%=c.getCategoryId()%>" ><a class="dropdown-item"
								style="cursor: pointer;" onclick = "triggerH5Click(<%=c.getCategoryId()%>)"><%=c.getcName()%></a></li>
							<%
							}
							%>
						</ul></li>
					<li class="nav-item"><a class="nav-link" href="<%=application.getContextPath()%>/contact.jsp">Contact</a>
					</li>
					<li class="nav-item" data-bs-toggle="modal"
						data-bs-target="#doPostModal"><a class="nav-link"
						style="cursor: pointer;">DoPost</a></li>
				</ul>
				<ul class="navbar-nav mr-right">
					<li class="nav-item"><a class="nav-link"
						style="cursor: pointer;" data-bs-toggle="modal"
						data-bs-target="#profileInfo" id="userInfo"><span
							class="fa fa-user-circle"></span> <%=user.getName()%></a></li>

					<li class="nav-item"><a class="nav-link"
						href="<%=application.getContextPath()%>/logout">Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- 	navbar ends -->

	<div class="container-fluid">
		<div class="row">
			<!-- Sidebar -->
			<div class="col-md-2 sidebar">
				<div class="catHeading">
					<h1>Categories</h1>
					<p>Explore topics that matter to you.</p>
				</div>
				<div class="categories">
					<h5 class="cat styleCat" onclick="getPosts(0, this, 0)"
						style="cursor: pointer;">All Posts</h5>
					<%
					for (Category c : list) {
					%>
					<h5 class="cat" style="cursor: pointer;" id = <%=c.getCategoryId()%>
						onclick="getPosts(<%=c.getCategoryId()%>, this, 0)"><%=c.getcName()%></h5>
					<%
					}
					%>
				</div>
			</div>

			<!-- Main Content Area -->
			<main class="col-md-7 main-content py-4">
				<h2 style="margin-bottom: 0px">Our Stories</h2>

				<div class="container-fluid" id="postContainer"></div>
			</main>

			<!-- Right Sidebar -->
			<aside class="col-md-3 right-sidebar py-4">
				<!-- Search Bar -->

				<!-- Popular Posts -->
				<div class="widget popular">
					<h4>Popular Posts</h4>
					<%
							LikeDao likeDao = new LikeDao(SessionProvider.getSession())	;
							int pId =  likeDao.popularPost();
							PostDao postDao = new PostDao(SessionProvider.getSession());
							Posts p1 = postDao.getPostByPostId(pId);
					%>
					<div class="popular-post" onclick ="showPost(<%=p1.getpId()%>)" style="cursor: pointer;">
						<img src="blogPic/<%=p1.getpPic()%>" alt="Popular Post Image" >
						<div class="post-overlay">
							<p class="post-title"><%=p1.getpTitle() %></p>
							<p class="post-date">By: <%=p1.getUser().getName()%></p>
						</div>
					</div>

				</div>

				<!-- Recent Posts -->
				<div class="widget">
					<h4>Recent Posts</h4>
					<div class="mainRPostDiv" style="height: 32vh">
					</div>
				</div>
			</aside>
		</div>
	</div>

	<!-- Showing posts section ends -->



	<!-- Modal -->
	<div class="modal fade" id="profileInfo" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content bg-dark text-white ">
				<div class="modal-header bg-dark text-white border-bottom-0 pb-3">
					<h1 class="modal-title fs-5" id="exampleModalLabel">TechBlog</h1>
					<button type="button" class="btn-close btn-close-white"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body bg-dark text-white pt-0">
					<div class="container text-center">

						<div id="pDetails">
							<img class="image-fluid" alt="<%=user.getProfileImage()%>"
								src="profilePic/<%=user.getProfileImage()%>"
								style="border-radius: 50%; width: 145px; margin-top: 0px; height: 145px">
							<h5 class="modal-title fs-5" id="exampleModalLabel"
								style="padding-top: 10px"><%=user.getName()%></h5>

							<table class="table table-dark" style="margin-top: 10px">
								<tbody>
									<tr>
										<th scope="row">ID</th>
										<td><%=user.getId()%></td>

									</tr>
									<tr>
										<th scope="row">Email</th>
										<td><%=user.getEmail()%></td>
									<tr>
										<th scope="row">Registered on</th>
										<%
										LocalDate localDate = user.getDateTimestamp().toLocalDateTime().toLocalDate();
										DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM d, yyyy");
										
										%>
										<td><%= localDate.format(formatter)%></td>
									</tr>
								</tbody>
							</table>

						</div>

						<div id="editDetails" style="display: none">
							<form action="">
								<label for="newImage" id="newImg" style="cursor: pointer;"><img
									id="previewImage" class="image-fluid"
									alt="<%=user.getProfileImage()%>"
									src="profilePic/<%=user.getProfileImage()%>"
									style="border-radius: 50%; width: 145px; margin-top: 0px; height: 145px"></label>

								<input type="file" id="newImage" style="display: none;">
								<h5 class="modal-title fs-5 mt-10" id="exampleModalLabel"
									style="padding-top: 10px">
									<input id="newUserName" type="text" value="<%=user.getName()%>"
										style="background: transparent; border: none; outline: none; color: white; text-align: center; font-weight: 500" />
								</h5>

								<table class="table table-dark" style="margin-top: 10px">
									<tbody>
										<tr>
											<th scope="row">ID</th>
											<td><%=user.getId()%></td>

										</tr>
										<tr>
											<th scope="row">Email</th>
											<td><input id="newEmail" type="email"
												value="<%=user.getEmail()%>"
												style="background: transparent; border: none; outline: none; color: white; text-align: center"></td>
										<tr>
										<tr>
											<th scope="row">Password</th>
											<td><input id="newPassword" type="password"
												value="<%=user.getPassword()%>"
												style="background: transparent; border: none; outline: none; color: white; text-align: center"></td>
										<tr>
											<th scope="row">Registered on</th>
											<td><%=user.getDateTimestamp()%></td>
										</tr>
									</tbody>
								</table>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer bg-dark text-white border-top-0 pt-0">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="editBtn">Edit</button>
				</div>
			</div>
		</div>
	</div>

	<!-- modal end -->

	<!-- 	doPost modal starts -->

	<div class="modal fade" id="doPostModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content text-white">
				<div class="modal-header border-bottom-0 pb-3">
					<h1 class="modal-title fs-5" id="exampleModalLabel">Provide
						your Post Details</h1>
					<button type="button" class="btn-close btn-close-white"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body pt-0">
					<form action="">
						<div class="form-group mb-3">
							<label for="categorySelect" class="form-label">Category</label> <select
								id="categorySelect" class="form-control">
								<option selected="selected" disabled="disabled">---Select
									Category---</option>
								<!-- Dynamic category options -->
								<%
								for (Category c : list) {
								%>
								<option value="<%=c.getCategoryId()%>"><%=c.getcName()%></option>
								<%
								}
								%>
							</select>
						</div>
						<div class="form-group mb-3">
							<label for="postTitle" class="form-label">Post Title</label> <input
								type="text" id="postTitle" class="form-control"
								placeholder="Enter Post Title" required="required">
						</div>
						<div class="form-group mb-3">
							<label for="postContent" class="form-label">Post Content</label>
							<textarea id="postContent" rows="4" class="form-control"
								placeholder="Enter your Content" required="required"></textarea>
						</div>
						<div class="form-group mb-3">
							<label for="postProgram" class="form-label">Program (if
								any)</label>
							<textarea id="postProgram" rows="4" class="form-control"
								placeholder="Enter your Program (if any)"></textarea>
						</div>
						<div class="form-group mb-3">
							<label for="postImage" class="form-label">Select an Image</label>
							<input type="file" id="postImage" class="form-control"
								style="padding: 6px 12px;">
						</div>
					</form>
				</div>
				<div class="modal-footer border-top-0 pt-0">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="postBtn">Submit
						Post</button>
				</div>
			</div>
		</div>
	</div>

	<!-- doPost modal ends -->
	<%@ include file="scripts.jsp"%>

	<script type="text/javascript">
	const pDetails = document.getElementById("pDetails");
	const editDetails = document.getElementById("editDetails");
	const editBtn = document.getElementById("editBtn");
	const newImg = document.getElementById("newImg");
	const newImage = document.getElementById("newImage");
	 const previewImage = document.getElementById("previewImage");
	 const newUserName = document.getElementById("newUserName");
	 const newEmail = document.getElementById("newEmail");
	 const newPassword = document.getElementById("newPassword");
	 const userInfo = document.getElementById("userInfo");
	let edit = false;
	let fileToUpload = null;
	editBtn.addEventListener("click", () => {
		if(edit == false){
			pDetails.style.display = "none";
			editDetails.style.display = "block";
			editBtn.innerHTML = "Save changes"
			edit = true;
		}else{
			editBtn.innerHTML = '<span class="spinner-border spinner-border-sm mr-5" aria-hidden="true"></span> <span id="btnText">Saving</span>'
			editBtn.disabled = true
			var formData = new FormData();
			if(fileToUpload != null){
				formData.append("profilePic",fileToUpload);				
			}
			formData.append("userName",newUserName.value);
			formData.append("userEmail",newEmail.value);
			formData.append("userPassword",newPassword.value);
			
			fetch("<%=application.getContextPath()%>/edit", {
				method:"POST",
				body : formData
			}) .then(response => {
				if(!response.ok){
					throw new Error("Something went wrong");
				}
				return response.json();
			})
		    .then(data => {
		    	editBtn.disabled = false
		    	if (data.redirect) {
		    		const Toast = Swal.mixin({
		    			  toast: true,
		    			  position: "top-end",
		    			  showConfirmButton: false,
		    			  timer: 1700,
		    			  timerProgressBar: true,
		    			  color: '#FFFFFF',
		    		        background: '#212529',
		    			  didOpen: (toast) => {
		    			    toast.onmouseenter = Swal.stopTimer;
		    			    toast.onmouseleave = Swal.resumeTimer;
		    			  }
		    			});
		    			Toast.fire({
		    			  icon: "success",
		    			  title: data.message
		    			}).then((value) => {
							window.location.href = data.redirect;
						})
<%-- 		    			<% Thread.sleep(1700);%> --%>
// 		    			window.location.href = data.redirect
// 		    			console.log("Success:", data)
// 				    	pDetails.style.display = "block";
// 						editDetails.style.display = "none";
						editBtn.innerHTML = "Saved"
// 						edit = false;
				}
		    	
		    	})
		    .catch((error) => {
		    	editBtn.disabled = false
		    	editBtn.innerHTML = "Save changes"
		    	console.error("Error:", error)
		    	const Toast = Swal.mixin({
	    			  toast: true,
	    			  position: "top-end",
	    			  showConfirmButton: false,
	    			  timer: 2000,
	    			  timerProgressBar: true,
	    			  color: '#FFFFFF',
	    		        background: '#212529',
	    			  didOpen: (toast) => {
	    			    toast.onmouseenter = Swal.stopTimer;
	    			    toast.onmouseleave = Swal.resumeTimer;
	    			  }
	    			});
	    			Toast.fire({
	    			  icon: "error",
	    			  title: error.message
	    			});
		    });
			
		}
	})
	
	if (newImg != null) {
        newImage.addEventListener("change", (e) => {
            fileToUpload = e.target.files[0];  // Get the selected file
            if (fileToUpload) {
                const reader = new FileReader();
                reader.onload = (event) => {
      
                    previewImage.src = event.target.result;  // Update the image preview
                };
                reader.readAsDataURL(fileToUpload);  // Read the selected file as a data URL
            }
        });
    }
	
	userInfo.addEventListener("click", () => {
		pDetails.style.display = "block";
		editDetails.style.display = "none";
		editBtn.innerHTML = "Edit"
			edit = false;
	})
	
</script>

	<script type="text/javascript">
const postBtn = document.getElementById("postBtn");
const categorySelect = document.getElementById("categorySelect");
const postTitle = document.getElementById("postTitle");
const postContent = document.getElementById("postContent");
const postProgram = document.getElementById("postProgram");
const postImage = document.getElementById("postImage");

postBtn.addEventListener("click", () => {
	postBtn.disabled = true
	let formData = new FormData();
	formData.append("postImage", postImage.files[0])
	formData.append("postTitle", postTitle.value.trim())
	formData.append("postContent", postContent.value.trim())
	formData.append("postProgram", postProgram.value)
	formData.append("postCategory", categorySelect.value.trim())
	let emptyField = "";
	if(categorySelect.value.trim() == "---Select Category---"){
		emptyField = "Category"
	}else if(postContent.value.trim() == ""){
		emptyField = "Content"
	}else if(postTitle.value.trim() == ""){
		emptyField = "Title"
	}else if(postImage.value.trim() == ""){
		emptyField = "Image"
	}
	if(emptyField != ""){
		const Toast = Swal.mixin({
			  toast: true,
			  position: "top-end",
			  showConfirmButton: false,
			  timer: 3000,
			  timerProgressBar: true,
			  color: '#E2E2E2',
			  fontweight:"light",	
		        background: '#121212',
			  didOpen: (toast) => {
			    toast.onmouseenter = Swal.stopTimer;
			    toast.onmouseleave = Swal.resumeTimer;
			  }
			});
			Toast.fire({
			  icon: "warning",
			  title: emptyField + " is required. Fill out  to proceed with submission."
			}).then(value => {
				postBtn.disabled = false
			})
	}else{

		fetch("<%=application.getContextPath()%>/addPost", {
			method : "POST",
			body: formData,
		}).then((response) => {
			if(!response.ok){
				throw new Error("Something went wrong!!")
			}
			return response.json();
		}).then(data => {
	
	    	if (data.message) {
	    		const Toast = Swal.mixin({
	    			  toast: true,
	    			  position: "top-end",
	    			  showConfirmButton: false,
	    			  timer: 2200,
	    			  timerProgressBar: true,
	    			  color: '#E2E2E2',
	    		        background: '#121212',
	    			  didOpen: (toast) => {
	    			    toast.onmouseenter = Swal.stopTimer;
	    			    toast.onmouseleave = Swal.resumeTimer;
	    			  }
	    			});
	    			Toast.fire({
	    			  icon: "success",
	    			  title: data.message
	    			}).then(value => {
	    				categorySelect.value = "---Select Category---"
	    				postTitle.value = ""
	    				postContent.value = ""
	    				postProgram.value = ""
	    				postImage.value = ""
	    				getRecentPosts(0);
	    			}).then(value => {
	    				postBtn.disabled = false
	    			})
		}
		}).catch(error => {

			const Toast = Swal.mixin({
				  toast: true,
				  position: "top-end",
				  showConfirmButton: false,
				  timer: 2000,
				  timerProgressBar: true,
				  color: '#E2E2E2',
			        background: '#121212',
				  didOpen: (toast) => {
				    toast.onmouseenter = Swal.stopTimer;
				    toast.onmouseleave = Swal.resumeTimer;
				  }
				});
				Toast.fire({
				  icon: "error",
				  title: error.message
				}).then(value => {
					postBtn.disabled = false
			console.log(error)
				})
		})

	}
	
})

</script>
	<script type="text/javascript">
const postContainer = document.getElementById("postContainer");
const catElements = document.getElementsByClassName("cat");
const mainRPostDiv = document.querySelector(".mainRPostDiv");
function getPosts(catId, tempElement,all) {
		Array.from(catElements).forEach(el => el.classList.remove("styleCat"));
		fetch("<%=application.getContextPath()%>/loadPost.jsp", {
			method : "POST",
			body: JSON.stringify({ cid: catId, all:all}),
	        headers: {
	            "Content-Type": "application/json"
	        }
		}).then(response => {
			return response.text();
		}).then(data => {
			postContainer.innerHTML = data
			 tempElement.classList.add("styleCat");
		})
	}
	
function getRecentPosts(all) {
	fetch("<%=application.getContextPath()%>/recentPost.jsp",{
		method: "POST",
		body : JSON.stringify({all: all}),
		headers:{
			"Content-Type" : "application/json"
		}
	}).then(response => {
		return response.text();
	}).then(data => {
		mainRPostDiv.innerHTML = data
	})
}

function triggerH5Click(catId){
	const ele = document.getElementById(catId);
	if(ele){
		ele.click();
	}
}
	window.onload = () => {
		const navbar = document.querySelector('.navbar'); // or '#navbar' if it has an ID
		const sidebar = document.querySelector('.sidebar');
		const main_content = document.querySelector('.main-content');
		const rightsidebar = document.querySelector('.right-sidebar');
		const navbarHeight = navbar.offsetHeight;
		const mainContentWidth = main_content.offsetWidth;
		console.log('Navbar Height:', navbarHeight, mainContentWidth);
		const marginTopValue = `calc(100vh - ${navbarHeight}px)`;
		console.log(marginTopValue)
 		sidebar.style.marginTop = `${navbarHeight}px`;
 		sidebar.style.height = marginTopValue;
 		
 		main_content.style.marginTop = `${navbarHeight}px`;
 		main_content.style.height = marginTopValue;
 		
 		rightsidebar.style.marginTop = `${navbarHeight}px`;
 		rightsidebar.style.height = marginTopValue;
		getPosts(0, catElements[0], 0);
 		getRecentPosts(0);
//  		rightsidebar.style.width = `calc(83vh - ${mainContentWidth}px)`;
	} 
</script>
<script type="text/javascript">
function showPost(pId){
	window.location.href = `<%=application.getContextPath()%>/post_details.jsp?post_id=${pId}`
}

</script>

</body>
</html>