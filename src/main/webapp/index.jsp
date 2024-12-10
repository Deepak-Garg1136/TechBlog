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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TechBlog</title>
<%@include file="links.jsp"%>
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
<style type="text/css">
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
body{overflow: hidden;}
.navbar .navbar-brand {
	font-family: "Libre Baskerville", serif;
	font-size: 1.5em;
	/*     color: #007bff; */
	font-weight: bold;
}
.hero-section {
	position: relative;
	height: 91.2vh;
	background-image: url('images/home.jpg'); /* Background image path */
	background-size: cover;
	background-position: center;
	display: flex;
	align-items: center;
	justify-content: flex-start;
	padding-left: 50px;
}

.overlay {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.7); /* Dark overlay for text contrast */
}

.content {
	position: relative;
	z-index: 1;
	max-width: 600px;
	color: white;
}

.text-wrapper {
	display: flex;
	align-items: flex-start;
}

.vertical-line {
	width: 3px;
	height: 300px;
	background-color: #ff4d4d; /* Accent color */
	margin-right: 20px;
}

.text-content {
	max-width: 500px;
}

.subheading {
	font-size: 1.2em;
	margin-bottom: 15px;
	letter-spacing: 2px;
	opacity: 0.85;
}

.headline {
	font-size: 2.2em;
	font-weight: bold;
	margin-bottom: 20px;
	line-height: 1.3;
}

.description {
	font-size: 1em;
	margin-bottom: 30px;
	line-height: 1.6;
	opacity: 0.9;
}

.cta-button {
	display: inline-block;
	padding: 12px 24px;
	font-size: 1em;
	font-weight: bold;
	color: #fff;
	background-color: #ff4d4d; /* Red accent for button */
	border-radius: 30px;
	text-decoration: none;
	transition: background 0.3s ease;
}

.cta-button:hover {
	background-color: #e63939;
}

#navbarBrand{
margin-left: 2vw;
}
/* Responsive Styles */
@media ( max-width : 768px) {
	.headline {
		font-size: 2em;
	}
	.cta-button {
		padding: 10px 20px;
	}
}

@media ( max-width : 480px) {
	.headline {
		font-size: 1.5em;
	}
	.cta-button {
		padding: 8px 16px;
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
					<%
					if (user != null) {
					%>
					<li class="nav-item" data-bs-toggle="modal"
						data-bs-target="#doPostModal"><a class="nav-link"
						style="cursor: pointer;">DoPost</a></li>
						<%}else{ %>
						<li class="nav-item" onclick="checkUserSession()"><a
						class="nav-link" style="cursor: pointer;">DoPost</a></li>
						<%} %>
				</ul>
				
				<ul class="navbar-nav mr-right" >
				<%
					if (user != null) {
					%>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"><span
							class="fa fa-user-circle"></span> <%=user.getName()%> </a>
						<ul class="dropdown-menu" style="margin-right: 2vw;">
						
							<li><a class="dropdown-item" href="<%=application.getContextPath()%>/profile.jsp"
								style="cursor: pointer;width: fit-content;">View Profile</a></li>
							
						</ul></li>

					<li class="nav-item"><a class="nav-link"
						href="<%=application.getContextPath()%>/logout">Logout</a></li>
						<%
					} else {
					%>
					<li class="nav-item"><a class="nav-link"
						href="<%=application.getContextPath()%>/register.jsp">Register</a></li>
						<li class="nav-item"><a class="nav-link"
						href="<%=application.getContextPath()%>/login.jsp">Login</a></li>
					<%
					}
					%>
				</ul>
			</div>
		</div>
	</nav>

	<!-- 	navbar ends -->



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
	<section class="hero-section">
		<div class="overlay"></div>
		<div class="content">
			<div class="text-wrapper">
				<div class="vertical-line"></div>
				<div class="text-content">
					<p class="subheading">Empowering the Future of Technology</p>
					<h1 class="headline">
						Where Ideas Meet Execution<br>In the World of Code
					</h1>
					<p class="description">Dive into articles, tutorials, and
						insights that showcase the forefront of software development, from
						foundational concepts to advanced techniques. Our work isn't just
						a presentation—it's a roadmap for your digital journey.</p>
					<a href="<%=application.getContextPath()%>/posts.jsp"
						class="cta-button">Explore Now</a>
				</div>
			</div>
		</div>
	</section>
	<!--     <section> -->
	<!--     <h1>dsffffffff</h1> -->
	<!--     </section> -->

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
	<script>
    var user = "<%=session.getAttribute("user")%>";
</script>

	<script>
function checkUserSession() {
	 window.location.href = "<%= application.getContextPath() %>/login.jsp"; // Replace with the actual login page URL
}
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

</body>
</html>