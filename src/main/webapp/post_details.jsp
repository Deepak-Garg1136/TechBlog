<%@page import="com.techBlog.dao.LikeDao"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.techBlog.entities.Posts"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.techBlog.entities.Category"%>
<%@page import="com.techBlog.entities.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techBlog.helper.SessionProvider"%>
<%@page import="com.techBlog.dao.PostDao"%>
<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("login.jsp");
	return;
}
%>
<%
int postId = Integer.parseInt(request.getParameter("post_id"));
PostDao postDao = new PostDao(SessionProvider.getSession());
Posts posts = postDao.getPostByPostId(postId);
LocalDate date = posts.getpDate().toLocalDateTime().toLocalDate();
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM d, yyyy");
String dateString = date.format(formatter);
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%=posts.getpTitle()%></title>

<%@ include file="links.jsp"%>
<style>
/* General form styling */
.modal-content {
	background-color: #121212; /* Modal background */
	box-shadow: 0 6px 12px rgba(0, 0, 0, 0.6); /* Soft shadow for modal */
	height: 90vh;
	overflow-y: scroll;
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

.navbar .navbar-brand {
	font-family: "Libre Baskerville", serif;
	font-size: 1.5em;
	/*     color: #007bff; */
	font-weight: bold;
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
	url("https://fonts.googleapis.com/css2?family=Libre+Baskerville&display=swap")
	;

@import
	url('https://fonts.googleapis.com/css2?family=Alkatra&display=swap');

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	/*   font-family: "Libre Baskerville", serif; */
	font-family: 'Alkatra', cursive;
}
/* Custom styles */
body {
	background-color: #121212;
	color: #E2E2E2;
	overflow: hidden
}

.post-container {
	background-color: #1D1D1D;
	border-radius: 8px;
	padding: 20px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
	margin-top: 30px;
	overflow-y: scroll;
	height: 82vh;
}

.post-container::-webkit-scrollbar {
	display: none;
}

.post-container {
	scrollbar-width: none;
}

.post-image {
	border-radius: 8px;
	width: 100%;
	height: 60vh;
	/*    object-fit:contain;  */
	margin-bottom: 20px;
}

.post-title {
	color: #E2E2E2;
	text-align: justify;
}

.post-meta {
	font-size: 0.9rem;
	color: #A0A0A0;
}

.post-text {
	height: auto;
	max-height: 36vh;
	overflow-y: scroll;
	text-align: justify;
	overflow-y: scroll;
}

/* Hide scrollbar for Chrome, Safari, and Opera */
.post-text::-webkit-scrollbar {
	display: none;
}

/* Hide scrollbar for Firefox */
.post-text {
	scrollbar-width: none;
}

.code-block {
	background-color: #2D2D2D;
	padding: 15px;
	border-radius: 6px;
	color: #0FAE96;
	font-family: monospace;
	overflow-x: auto;
	margin: 20px 0;
}

.author-info {
	display: flex;
	justify-content: space-between; align-items : center;
	border-top: 1px solid #333;
	padding-top: 15px;
	margin-top: 30px !important;
	height: 10vh;
	align-items: center;
}

.author {
	display: flex;
}

.author-avatar {
	width: 50px;
	height: 50px;
	border-radius: 50%;
	background-color: #444;
	margin-right: 10px;
	flex-wrap: wrap;
}

.text-muted {
	color: #A0A0A0 !important; /* Adjust the color to a visible shade */
}
.like {
    display: flex;
    gap: 15px;
    align-items: center;
}

.like-btn, .comment-btn {
    background-color: #f5f5f5;
    border: none;
   color: #333; 
    padding: 8px 12px;
    font-size: 14px;
    border-radius: 5px;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 5px;
    transition: background-color 0.3s ease, color 0.3s ease;
}

.like-btn:hover, .comment-btn:hover {
    background-color: #007bff;
    color: #fff !important;
}
.like-btn:hover .like-count{
color: #fff
}

.like-btn i, .comment-btn i {
    font-size: 16px;
}

/* Style for the Like Count */
.like-count {
    font-size: 14px;
    color: #333;
    margin-left: 5px;
}

/* Responsive Design for Smaller Screens */
@media (max-width: 768px) {
    .author-info {
        flex-direction: column; /* Stack elements vertically */
        align-items: flex-start;
    }

    .author {
        flex-direction: row;
        width: auto;
    }

    .like {
        flex-direction: row;
        width: 100%;
        justify-content: space-between;
    }

    .like-btn, .comment-btn {
        padding: 8px 10px;
        font-size: 12px;
    }

    .like-count {
        font-size: 12px;
    }
}

@media (max-width: 480px) {
    .like-btn, .comment-btn {
        padding: 6px 8px;
        font-size: 10px;
    }

    .like-count {
        font-size: 10px;
    }

    .author-avatar {
        width: 30px;
        height: 30px;
    }
}
</style>
</head>
<body>
	<!-- navbar -->
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">TechBlog</a>
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
					<li class="nav-item"><a class="nav-link"
						href="<%=application.getContextPath()%>/posts.jsp">Posts</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"> Categories </a>
						<ul class="dropdown-menu">
							<%
							PostDao post = new PostDao(SessionProvider.getSession());
							ArrayList<Category> list = post.getAllCategories();
							for (Category c : list) {
							%>
							<li value="<%=c.getCategoryId()%>"
								onclick="getSpecificPosts(<%=c.getCategoryId()%>)"><a
								class="dropdown-item" style="cursor: pointer;"><%=c.getcName()%></a></li>
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
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"><span
							class="fa fa-user-circle"></span> <%=user.getName()%> </a>
						<ul class="dropdown-menu">

							<li><a class="dropdown-item"
								href="<%=application.getContextPath()%>/profile.jsp"
								style="cursor: pointer;">View Profile</a></li>

						</ul></li>

					<li class="nav-item"><a class="nav-link"
						href="<%=application.getContextPath()%>/logout">Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>


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
										<td><%=user.getDateTimestamp()%></td>
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

	<div class="container">
		<div class="post-container">
			<!-- Post Image -->
			<img src="blogPic/<%=posts.getpPic()%>" alt="Post Image"
				class="post-image">

			<!-- Post Content -->
			<div class="post-content">
				<!-- Title -->
				<h1 class="post-title"><%=posts.getpTitle()%></h1>

				<!-- Meta Information -->
				<p class="post-meta">
					By <span class="font-weight-bold"><%=posts.getUser().getName()%></span>
					on <span><%=dateString%></span>
				</p>

				<!-- Post Text Content -->
				<div class="post-text mt-3">
					<p><%=posts.getpContent()%></p>
				</div>

				<!-- Code Block -->
				<%
				if (!posts.getpCode().equals("")) {
				%>
				<pre class="code-block">
					<code><%=posts.getpCode()%></code>
				</pre>
				<%
				}
				%>
			</div>

			<!-- Author Section -->
			<div class="author-info mt-4">
				<div class="author">
					<img class="author-avatar"
						alt="<%=posts.getUser().getProfileImage()%>"
						src="profilePic/<%=posts.getUser().getProfileImage()%>">
					<div style="height: 40px">
						<p class="mb-0 font-weight-bold"><%=posts.getUser().getName()%></p>
						<p class="post-date text-muted"><%=dateString%></p>
					</div>
				</div>
				<div class="like">
					<!-- Like Button with Like Count -->
					<%
						LikeDao likeDao = new LikeDao(SessionProvider.getSession());
					%>
					<a class="like-btn " onclick="increaseLikeCount(<%=posts.getpId()%>, <%=user.getId()%>, 'like')" style="text-decoration: none;">
						<i class="fas fa-thumbs-up likeicon"></i> 
						<%
							int totalLikes = likeDao.countLikeOnPost(posts.getpId());
// 							if(totalLikes <= 0){
						%>
					<span class="like-count" id="likeCount"><%=totalLikes%></span>
<%-- 					<%}else{ %> --%>
<%-- 					<span class="like-count" id="likeCount"><%=totalLikes%></span> --%>
<%-- 					<%} %> --%>
					</a>

<!-- 					Comment Button -->
<!-- 					<button class="comment-btn"> -->
<!-- 						<i class="fas fa-comment"></i> Comment -->
<!-- 					</button> -->
				</div>
			</div>
		</div>
	</div>

	<%@ include file="scripts.jsp"%>



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
	    				getRecentPosts();
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
	function getSpecificPosts(cid) {
		fetch("<%=application.getContextPath()%>/loadSpecificPosts.jsp",{
			method: "POST",
			body : JSON.stringify({
				postCategoryId : cid
			}),
			headers : {
				"Content-Type" : "application/json"
			}
		}).then(response =>{
			if(!response.ok){
				throw new Error("Something went wrong!!")
			}
			return response.json();
		}).then(data => {
			if(data.redirect){
				window.location.href = data.redirect;
			}
		}).catch((error) => {
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
  			  icon: "error",
  			  title: error.message
  			})
			console.log(error.message);
		})
	}
</script>

<script type="text/javascript">
const like_count = document.getElementById("likeCount");
const like_btn = document.querySelector(".like-btn")
const likeicon = document.querySelector(".likeicon")
function increaseLikeCount(postId, userId, operation){
	fetch("<%=application.getContextPath()%>/likeServlet", {
		method: "POST",
		body:JSON.stringify({
			postId : postId,
			userId : userId,
			operation : operation
		}),
		headers:{
			"Content-Type" : "application/json"
		}
	}).then(response => {
		if(!response.ok){
			throw new Error("Something went worng!!")
		}
		return response.json()
	}).then(data => {
		if(data.message == "likedPost"){
			like_count.style.color = "#fff"
				likeicon.style.color = "#fff"
				like_btn.style.background = "#007bff"
		}else if (data.message == "notLiked") {
			like_count.style.color = "#333"
				likeicon.style.color = "#333"
				like_btn.style.background = "#fff"
		}
		else if(data.message == "true"){
			let count = parseInt(like_count.innerHTML)
			count = count + 1;
			like_count.innerHTML = count
			like_count.style.color = "#fff"
			likeicon.style.color = "#fff"
			like_btn.style.background = "#007bff"
			console.log(data)			
		}else if (data.message == "dislike") {
			let count = parseInt(like_count.innerHTML)
			count = count - 1;
			like_count.innerHTML = count
			like_count.style.color = "#333"
				likeicon.style.color = "#333"
				like_btn.style.background = "#fff"
			console.log(data)
		}else{
			throw new Error("Something went wrong!!")
		}
	}).catch(error => {
		console.log(error.message)
	})
	
}
</script>

<script type="text/javascript">
	window.onload = () => {
		increaseLikeCount(<%=posts.getpId()%>, <%=user.getId()%>, "haslikedPost")
		
	}

</script>
</body>
</html>
