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
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>About Us | TechBlog</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
<style> /* Reset */
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

body {
	background-color: #121212;
	color: #E2E2E2;
	line-height: 1.6;
	height:90vh;
/* 	overflow-y:scroll;  */
}

.main{
	height: 90vh;
	overflow-y:scroll; 
}

.main::-webkit-scrollbar {
	display: none;
}

/* Hide scrollbar for Firefox */
.main {
	scrollbar-width: none;
}
.navbar .navbar-brand {
	font-family: "Libre Baskerville", serif;
	font-size: 1.5em;
	/*     color: #007bff; */
	font-weight: bold;
}
/* Layout Styles */
.container {
	width: 90%;
	max-width: 1200px;
	margin: 0 auto;
}

.hero-section {
	background-color: #1D1D1D;
	padding: 60px 20px;
	text-align: center;
}

.hero-section h1 {
	font-size: 2.8rem;
	color: #FF605D;
}

.hero-section p {
	max-width: 700px;
	margin: 20px auto;
	color: #A0A0A0;
}

.about-content {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	padding: 50px 20px;

}

.about-text {
	flex: 1 1 60%;
	background-color: #1D1D1D;
	padding: 20px;
	border-radius: 8px;
	height: 45vh
}

.about-text h2 {
	color: #FF605D;
}

.about-text p {
	color: #E2E2E2;
}

.about-image {
	flex: 1 1 35%;
	display: flex;
	align-items: center;
	justify-content: center;
}

.about-image img {
	width: 100%;
	max-width: 400px;
	border-radius: 8px;
	height: 45vh;
}
/* Team Section */
.team-section {
	background-color: #1D1D1D;
	padding: 50px 20px;
	text-align: center;
}

.team-section h2 {
	color: #FF605D;
	font-size: 2.4rem;
}

.team-grid {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	justify-content: center;
	margin-top: 30px;
}

.team-member {
	background-color: #2D2D2D;
	width: 300px;
	padding: 30px;
	border-radius: 10px;
	text-align: center;
	transition: transform 0.3s;
}

.team-member:hover {
	transform: scale(1.05);
}

.team-member img {
	width: 120px;
	height: 120px;
	border-radius: 50%;
	/*             border: 3px solid #FF605D; */
	margin-bottom: 15px;
}

.team-member h3 {
	color: #FF605D;
	font-size: 1.6rem;
	margin: 10px 0;
}

.team-member p {
	color: #A0A0A0;
}

.social-icons a {
	color: #E2E2E2;
	margin: 0 10px;
	font-size: 1.2rem;
	transition: color 0.3s;
}

.social-icons a:hover {
	color: #FF605D;
}
/* Responsive */
@media ( max-width : 768px) {
	.about-content {
		flex-direction: column;
	}
	.about-image, .about-text {
		flex: 1 1 100%;
	}
}

@media ( max-width : 480px) {
	.hero-section h1 {
		font-size: 2rem;
	}
	.team-section h2 {
		font-size: 1.8rem;
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
					<li class="nav-item"><a class="nav-link"
						href="<%=application.getContextPath()%>/about.jsp">About</a></li>
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
					<li class="nav-item"><a class="nav-link"
						href="<%=application.getContextPath()%>/contact.jsp">Contact</a></li>
					<%
					if (user != null) {
					%>
					<li class="nav-item" data-bs-toggle="modal"
						data-bs-target="#doPostModal"><a class="nav-link"
						style="cursor: pointer;">DoPost</a></li>
					<%
					} else {
					%>
					<li class="nav-item" onclick="checkUserSession()"><a
						class="nav-link" style="cursor: pointer;">DoPost</a></li>
					<%
					}
					%>
				</ul>

				<ul class="navbar-nav mr-right">
					<%
					if (user != null) {
					%>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"><span
							class="fa fa-user-circle"></span> <%=user.getName()%> </a>
						<ul class="dropdown-menu" style="margin-right: 2vw;">

							<li><a class="dropdown-item"
								href="<%=application.getContextPath()%>/profile.jsp"
								style="cursor: pointer; width: fit-content;">View Profile</a></li>

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
	<!-- Hero Section -->
	<div class="main">
	<section class="hero-section">
		<div class="container">
			<h1>About TechBlog</h1>
			<p>Welcome to TechBlog, your go-to source for the latest
				insights, tutorials, and trends in the world of technology. We’re
				here to empower and educate tech enthusiasts everywhere.</p>
		</div>
	</section>

	<!-- About Content Section -->
	<section class="about-content container">
		<div class="about-text">
			<h2>Our Mission</h2>
			<p>At TechBlog, we aim to make technology accessible and exciting
				for everyone. We are committed to providing high-quality articles,
				tutorials, and resources that help tech enthusiasts, students, and
				professionals expand their skills and stay up-to-date with the
				latest in the tech world.</p>
			<h2>What We Do</h2>
			<p>From web development and software engineering to cybersecurity
				and artificial intelligence, our team covers a wide array of topics
				to ensure our readers get comprehensive insights into the tech
				industry.</p>
		</div>
		<div class="about-image">
			<img src="images/company.jpeg" alt="TechBlog Team">
		</div>
	</section>

	<!-- Team Section -->
	<section class="team-section">
		<div class="container">
			<h2>Meet Our Team</h2>
			<div class="team-grid">
				<div class="team-member">
					<img src="images/team4.jpg" alt="Alex Johnson">
					<h3>Alex Johnson</h3>
					<p>Founder & Lead Developer</p>
					<div class="social-icons">
						<a href="#"><i class="fab fa-twitter"></i></a> <a href="#"><i
							class="fab fa-linkedin"></i></a>
					</div>
				</div>
				<div class="team-member">
					<img src="images/team2.jpg" alt="Maria Chen">
					<h3>Maria Chen</h3>
					<p>Content Strategist</p>
					<div class="social-icons">
						<a href="#"><i class="fab fa-twitter"></i></a> <a href="#"><i
							class="fab fa-linkedin"></i></a>
					</div>
				</div>
				<div class="team-member">
					<img src="images/team1.jpg" alt="David Lee">
					<h3>Aless Bliss</h3>
					<p>Senior Editor</p>
					<div class="social-icons">
						<a href="#"><i class="fab fa-twitter"></i></a> <a href="#"><i
							class="fab fa-linkedin"></i></a>
					</div>
				</div>
			</div>
		</div>
	</section>
	</div>
	<%@include file="scripts.jsp"%>
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
	 window.location.href = "<%=application.getContextPath()%>/login.jsp"; // Replace with the actual login page URL
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
