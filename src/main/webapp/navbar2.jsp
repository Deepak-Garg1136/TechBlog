
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
						aria-current="page" href="#">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="#">About</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"> Categories </a>
						<ul class="dropdown-menu">
							<%
							PostDao post = new PostDao(SessionProvider.getSession());
							ArrayList<Category> list = post.getAllCategories();
							for (Category c : list) {
							%>
							<li value="<%=c.getCategoryId()%>"><a class="dropdown-item"
								style="cursor: pointer;"><%=c.getcName()%></a></li>
							<%
							}
							%>
						</ul></li>
					<li class="nav-item"><a class="nav-link" href="#">Contact</a>
					</li>
					<li class="nav-item" data-bs-toggle="modal"
						data-bs-target="#doPostModal"><a class="nav-link"
						style="cursor: pointer;">DoPost</a></li>
				</ul>
				<ul class="navbar-nav mr-right">
					<li class="nav-item"><a class="nav-link"
						style="cursor: pointer;" data-bs-toggle="modal"
						data-bs-target="#profileInfo" id="userInfo"><span
							class="fa fa-user-circle"></span> <%=user1.getName()%></a></li>

					<li class="nav-item"><a class="nav-link"
						href="<%=application.getContextPath()%>/logout">Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>
