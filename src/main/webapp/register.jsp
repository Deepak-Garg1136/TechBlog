<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.techBlog.entities.Message"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register | TechBlog</title>
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
.navbar .navbar-brand {
	font-family: "Libre Baskerville", serif;
	font-size: 1.5em;
	/*     color: #007bff; */
	font-weight: bold;
}
     .navbar .nav-link, .navbar .navbar-brand{
    color: #E2E2E2 !important;
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

.btn-primary,.swal2-confirm {
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
							<p>Register Here</p>
						</div>

						<div class="card-body">
                <div
                  class="alert alert-danger"
                  role="alert"
                  id="myAlert"
                  style="
                    text-align: center;
                    display: none;
                    padding-top: 1.5vh;
                    padding-bottom: 1.5vh;
                    height: auto;
                  "
                ></div>

                <div
                  class="alert alert-success"
                  role="alert"
                  id="myAlert1"
                  style="
                    text-align: center;
                    display: none;
                    padding-top: 1.5vh;
                    padding-bottom: 1.5vh;
                    height: auto;
                  "
                ></div>

                <form
                  id="myForm"
                  action="<%=application.getContextPath()%>/register"
                  method="post"
                >
                  <div class="mb-3">
                    <label for="user_name" class="form-label">User Name</label>
                    <input
                      id="userName"
                      type="text"
                      name="userName"
                      class="form-control"
                      id="user_name"
                      placeholder="Enter name"
                    />
                  </div>

                  <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label"
                      >Email address</label
                    >
                    <input
                      type="email"
                      id="email"
                      name="email"
                      class="form-control"
                      id="exampleInputEmail1"
                      placeholder="Enter email"
                      aria-describedby="emailHelp"
                    />
                    <div id="emailHelp" class="form-text">
                      We'll never share your email with anyone else.
                    </div>
                  </div>

                  <div class="mb-3">
                    <label for="exampleInputPassword1" class="form-label"
                      >Password</label
                    >
                    <input
                      type="password"
                      id="password"
                      name="password"
                      class="form-control"
                      id="exampleInputPassword1"
                      placeholder="Enter password"
                    />
                  </div>

                  <button type="submit" class="btn btn-primary" id="button"  style="width: 100%">
                    <span
                      id="loader"
                      class="spinner-border spinner-border-sm mr-5"
                      aria-hidden="true"
                      style="display: none"
                    ></span>
                    <span id="btnText">Submit</span>
                  </button>
                </form>
              </div>
						<div class="card-footer">
                <p>
                  Already have an account?<a
                    href="<%=application.getContextPath()%>/login.jsp"
                   style="text-decoration: none">
                    Login</a
                  >
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
      const userName = document.getElementById("userName");
      const email = document.getElementById("email");
      const password = document.getElementById("password");
      const btnText = document.getElementById("btnText");
      const loader = document.getElementById("loader");
      const myAlert = document.getElementById("myAlert");
      const myAlert1 = document.getElementById("myAlert1");
      button.addEventListener("click", (e) => {
        e.preventDefault();
        let url = "<%=application.getContextPath()%>/register";
        button.disabled = true;
        loader.style.display = "inline-block";
        btnText.innerHTML = "Please wait";
        if (
          userName.value.trim() === "" ||
          email.value.trim() === "" ||
          password.value.trim() === ""
        ) {
          myAlert.innerHTML = "All fields are required.";
          myAlert.style.display = "block";
          button.disabled = false;
          loader.style.display = "none";
          btnText.innerHTML = "Submit";
          return;
        }
        if (!passwordValidate(password.value)) {
        	Swal.fire({
                icon: "warning",
                text: "Password must contain at least 8 characters, including uppercase, lowercase, numbers, and special characters.",
                color: "#FFFFFF",
                background: "#212529",
              })
              button.disabled = false;
          loader.style.display = "none";
          btnText.innerHTML = "Submit";
              return;
          }
        fetch(url, {
          method: "POST",
          body: JSON.stringify({
            userName: userName.value,
            email: email.value.trim(),
            password: password.value,
          }),
          headers: {
            "Content-Type": "application/json",
          },
        })
          .then((response) => {
            if (!response.ok) {
              throw new Error("Internal Server Error");
            }
            return response.json();
          })
          .then((data) => {
            if (data.redirect) {
              Swal.fire({
                icon: "success",
                title: "Registered Successfully",
                text: "We are going to redirect you to the login page!",
                color: "#FFFFFF",
                background: "#212529",
              }).then((value) => {
                window.location.href = data.redirect;
              });
            }
            userName.value = "";
            email.value = "";
            password.value = "";
            button.disabled = false;
            loader.style.display = "none";
            btnText.innerHTML = "Submit";
          })
          .catch((error) => {
            myAlert.innerHTML = error.message;
            myAlert.style.display = "block";
            button.disabled = false;
            loader.style.display = "none";
            btnText.innerHTML = "Submit";
          });
      });
      
      function passwordValidate(pass) {
    	  const passwordPattern =
    	    /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
    	  return passwordPattern.test(pass);
    	}
    </script>
</body>
</html>
