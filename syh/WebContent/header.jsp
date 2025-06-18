<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Header</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Custom Styles -->
<link href="css/custom-styles.css" rel="stylesheet">
<!-- Popper.js -->
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<!-- Bootstrap JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</head>
<body>
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">酒店房间管理系统</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
				aria-controls="navbarNavDropdown" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNavDropdown">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="ShowHotel">首页</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"> 分店管理 </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="branchList">分店列表</a></li>
							<li><a class="dropdown-item" href="	addBranch">添加分店</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"> 房间管理 </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="roomList">房间列表</a></li>
							<li><a class="dropdown-item" href="addRoom">添加房间</a></li>
							<li><a class="dropdown-item" href="#">编辑房间</a></li>
							<li><a class="dropdown-item" href="#">删除房间</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"> 系统维护 </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="#">用户管理</a></li>
							<li><a class="dropdown-item" href="#">权限设置</a></li>
							<li><a class="dropdown-item" href="#">数据备份</a></li>
							<li><a class="dropdown-item" href="#">系统日志</a></li>
						</ul></li>
				</ul>
				<div class="navbar-nav ms-auto">
					<li class="nav-item"><a class="nav-link text-danger" href="#">退出系统</a>
					</li>
				</div>
			</div>
		</div>
	</nav>