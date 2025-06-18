<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>房间列表</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="css/custom-styles.css" rel="stylesheet">
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
				<li class="breadcrumb-item"><a href="#">房间管理</a></li>
				<li class="breadcrumb-item active" aria-current="page">房间列表</li>
			</ol>
		</nav>
		<h2 class="mb-3">房间列表</h2>
		<div class="mb-3">
			<a href="addRoom" class="btn btn-success">添加房间</a>
		</div>
		<table class="table table-bordered table-hover">
			<thead>
				<tr>
					<th>序号</th>
					<th>分店名称</th>
					<th>房间号码</th>
					<th>房间类型</th>
					<th>房间设施</th>
					<th>房间状态</th>
					<th>备注</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="room" items="${roomList}" varStatus="status">
					<tr>
						<td>${status.index + 1}</td>
						<td>${room.hotel_name}</td>
						<td>${room.room_no}</td>
						<td>
							<c:choose>
								<c:when test="${room.room_type == 'S'}">标准间</c:when>
								<c:when test="${room.room_type == 'D'}">豪华间</c:when>
								<c:when test="${room.room_type == 'T'}">套房</c:when>
								<c:otherwise>未知</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:set var="equipDisplay" value="${room.room_equip}" />
							<c:set var="equipDisplay" value="${fn:replace(equipDisplay, 'fridge', '冰箱')}" />
							<c:set var="equipDisplay" value="${fn:replace(equipDisplay, 'tv', '电视')}" />
							<c:set var="equipDisplay" value="${fn:replace(equipDisplay, 'ac', '空调')}" />
							<c:set var="equipDisplay" value="${fn:replace(equipDisplay, 'wifi', '无线网络')}" />
							${equipDisplay}
						</td>
						<td>
							<c:choose>
								<c:when test="${room.room_status == 'A'}">未入住</c:when>
								<c:when test="${room.room_status == 'O'}">已入住</c:when>
								<c:when test="${room.room_status == 'M'}">维护中</c:when>
								<c:otherwise>未知</c:otherwise>
							</c:choose>
						</td>
						<td>${empty room.room_memo ? '无' : room.room_memo}</td>
						<td>
							<a href="editRoom?room_id=${room.room_id}" class="btn btn-primary btn-sm">修改</a>
							<a href="deleteRoom?room_id=${room.room_id}" class="btn btn-danger btn-sm" onclick="return confirm('确定要删除该房间吗？');">删除</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html> 