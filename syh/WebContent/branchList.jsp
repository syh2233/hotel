<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>分店列表</title>
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
				<li class="breadcrumb-item active" aria-current="page">分店列表</li>
			</ol>
		</nav>
		<h2>分店列表</h2>
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>序号</th>
					<th>分店名称</th>
					<th>分店地址</th>
					<th>分店电话</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="branch" items="${branchList}" varStatus="status">
					<tr>
						<td>${status.index + 1}</td>
						<td>${branch.hotel_name}</td>
						<td>${branch.hotel_addr}</td>
						<td>${branch.hotel_phone}</td>
						<td>
							<a href="editBranch?hotel_id=${branch.hotel_id}" class="btn btn-primary btn-sm">修改</a>
							<a href="deleteBranch?hotel_id=${branch.hotel_id}" class="btn btn-danger btn-sm" onclick="return confirm('确定要删除该分店吗？');">删除</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>