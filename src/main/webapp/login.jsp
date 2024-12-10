<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.techBlog.entities.Message"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login | TechBlog</title>
<%@ include file="links.jsp"%>
<style>
    /* Dark Theme Styling */
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
        font-family: Arial, sans-serif;
    }
     .navbar .nav-link, .navbar .navbar-brand{
    color: #E2E2E2 !important;
  }
  .navbar .navbar-brand {
	font-family: "Libre Baskerville", serif;
	font-size: 1.5em;
	/*     color: #007bff; */
	font-weight: bold;
}
    .card {
        background-color: #1E1E1E;
        color: #E2E2E2;
        border: none;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        border-radius: 8px;
    }
    
    .card-header, .card-footer {
        background-color: #1B1B1B;
        color: #E2E2E2;
        text-align: center;
        font-size: 1.2em;
        font-weight: bold;
    }
    
    .form-label {
        color: #E2E2E2;
    }
    
    .form-control {
        background-color: #2C2C2C;
        color: #E2E2E2;
        border: 1px solid #3A3A3A;
        border-radius: 4px;
    }
    
    .form-control::placeholder {
        color: #8A8A8A;
    }
    
    .form-control:focus {
        background-color: #333;
        color: #FFF;
        border-color: #5A5A5A;
    }
	#emailHelp{
	color:#E2E2E2 !important;
	}

    .btn-primary {
        background-color: #3D8AF7;
        border: none;
        border-radius: 4px;
        padding: 10px 20px;
        font-weight: bold;
        color: #FFFFFF;
    }
    
    .btn-primary:hover {
        background-color: #3478DB;
    }
    
    .alert {
        font-size: 0.9em;
        border-radius: 4px;
    }
    
    .alert-danger {
        background-color: #FF4D4D;
        color: #FFFFFF;
        border: none;
    }

    a {
        color: #3D8AF7;
    }
    
    a:hover {
        color: #3478DB;
        text-decoration: none;
    }
    
    /* Loader Spinner */
    .spinner-border {
        border-width: 3px;
        color: #FFFFFF;
    }
</style>
</head>
<body>
	<%@ include file="navbar.jsp"%>
	<main class="d-flex align-items-center" style="height: 90vh">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-5">
					<div class="card">
						<div class="card-header">
							<p>Login Here</p>
						</div>

						<div class="card-body">
							<div class="alert alert-danger" role="alert" id="myAlert"
								style="text-align: center; display: none;"></div>

							<%
							Message mess = (Message) session.getAttribute("message");
							if (mess != null) {
							%>
							<div class="alert <%=mess.getCssClass()%>" role="alert"
								id="myAlert1"
								style="text-align: center;"><%=mess.getContent()%></div>
							<%
							session.removeAttribute("message");
							}
							%>
							<form id="myForm"
								action="<%=application.getContextPath()%>/login" method="post">
								<div class="mb-3">
									<label for="exampleInputEmail1" class="form-label">Email
										address</label>
									<input id="email" type="email" name="email"
										class="form-control" placeholder="Enter email">
									<div id="emailHelp" class="form-text text-muted">We'll never share
										your email with anyone else.</div>
								</div>
								<div class="mb-3">
									<label for="exampleInputPassword1" class="form-label">Password</label>
									<input id="password" type="password" name="password"
										class="form-control" placeholder="Enter password">
								</div>

								<button type="submit" class="btn btn-primary w-100" id="button">
									<span id="loader" class="spinner-border spinner-border-sm mr-2"
										aria-hidden="true" style="display: none;"></span> 
									<span id="btnText">Submit</span>
								</button>
							</form>
						</div>
						<div class="card-footer">
							<p>
								Don't have an account? <a
									href="<%=application.getContextPath()%>/register.jsp" style="text-decoration: none">
									Register</a>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<%@ include file="scripts.jsp"%>
	<script type="text/javascript">
	const myForm = document.getElementById("myForm");
	const button = document.getElementById("button");
	const email = document.getElementById("email");
	const password = document.getElementById("password");
	const loader = document.getElementById("loader");
	const myAlert = document.getElementById("myAlert");
	const myAlert1 = document.getElementById("myAlert1");
	const btnText = document.getElementById("btnText");
	button.addEventListener("click", (e) => {
		if (myAlert1 != null) {
			myAlert1.style.display = "none";
		}
		e.preventDefault();
		let url = "<%=application.getContextPath()%>/login";
		button.disabled = true;
		loader.style.display = "inline-block";
		btnText.innerHTML = "Please wait";
		if (email.value.trim() === "" || password.value.trim() === "") {
			myAlert.innerHTML = "All fields are required.";
			myAlert.style.display = "block";
			button.disabled = false;
			loader.style.display = "none";
			btnText.innerHTML = "Submit";
			return;
		}
		myAlert.style.display = "none";
		fetch(url, {
			method: "POST",
			body: JSON.stringify({
				email: email.value,
				password: password.value
			}),
			headers: {
				"Content-Type": "application/json"
			}
		}).then(response => {
			if (response.status == 500) {
				throw new Error("Internal Server Error");
			}
			if (response.status == 401)
				throw new Error("Invalid email or password");

			return response.json();
		}).then(data => {
			if (data.redirect) {
				window.location.href = data.redirect;
			} else {
				alert(data.message);
			}
			email.value = "";
			password.value = "";
			button.disabled = false;
			loader.style.display = "none";
			btnText.innerHTML = "Submit";
		}).catch(error => {
			button.disabled = false;
			loader.style.display = "none";
			btnText.innerHTML = "Submit";
			myAlert.innerHTML = error.message;
			myAlert.style.display = "block";
		});
	});
	</script>
</body>
</html>
