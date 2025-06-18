<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>编辑分店</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Popper.js -->
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<!-- Bootstrap JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</head>
<body>
	<jsp:include page="header.jsp" />
	<div class="container mt-4">
		<nav aria-label="breadcrumb" class="syh-breadcrumb">
			<ol class="breadcrumb mb-0">
				<li class="breadcrumb-item"><a href="#">首页</a></li>
				<li class="breadcrumb-item"><a href="#">分店管理</a></li>
				<li class="breadcrumb-item active" aria-current="page">编辑分店</li>
			</ol>
		</nav>
		<h2>编辑分店</h2>
		<form action="updateBranch" method="post">
			<input type="hidden" name="hotelId" value="${branch.hotel_id}" />
			<div class="mb-3">
				<label for="hotelName" class="form-label">分店名称</label> 
				<input type="text" class="form-control" id="hotelName" name="branchName" value="${branch.hotel_name}" required />
			</div>
			<div class="mb-3">
				<label for="hotelAddress" class="form-label">分店地址</label> 
				<input type="text" class="form-control" id="hotelAddress" name="branchAddress" value="${branch.hotel_addr}" required />
			</div>
			<div class="mb-3">
				<label for="hotelPhone" class="form-label">分店电话</label> 
				<input type="text" class="form-control" id="hotelPhone" name="branchPhone" value="${branch.hotel_phone}" required />
			</div>
			<button type="submit" class="btn btn-primary">提交</button>
		</form>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>