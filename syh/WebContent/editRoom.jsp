<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>修改房间信息</title>
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
				<li class="breadcrumb-item"><a href="roomList">房间列表</a></li>
				<li class="breadcrumb-item active" aria-current="page">修改房间</li>
			</ol>
		</nav>
		<div class="card mt-4">
			<div class="card-header">
				<h2 class="mb-0">修改房间信息</h2>
			</div>
			<div class="card-body">
				<form action="updateRoom" method="post">
					<input type="hidden" name="roomId" value="${room.room_id}" />
					<div class="mb-3">
						<label for="branchName" class="form-label">分店名称</label> 
						<select class="form-select" id="branchName" name="branchName" required>
							<option value="">请选择分店</option>
							<c:forEach var="hotel" items="${hotelList}">
								<option value="${hotel.hotel_id}" ${hotel.hotel_id == room.hotel_id ? 'selected' : ''}>
									${hotel.hotel_name}
								</option>
							</c:forEach>
						</select>
					</div>
					<div class="mb-3">
						<label for="roomNumber" class="form-label">房间号码</label> 
						<input type="text" class="form-control" id="roomNumber" name="roomNumber" value="${room.room_no}" required />
					</div>
					<div class="mb-3">
						<label for="roomType" class="form-label">房间类型</label> 
						<select class="form-select" id="roomType" name="roomType" required>
							<option value="standard" ${room.room_type == 'S' ? 'selected' : ''}>标准间</option>
							<option value="deluxe" ${room.room_type == 'D' ? 'selected' : ''}>豪华间</option>
							<option value="suite" ${room.room_type == 'T' ? 'selected' : ''}>套房</option>
						</select>
					</div>
					<div class="mb-3">
						<label for="roomStatus" class="form-label">房间状态</label> 
						<select class="form-select" id="roomStatus" name="roomStatus" required>
							<option value="available" ${room.room_status == 'A' ? 'selected' : ''}>未入住</option>
							<option value="occupied" ${room.room_status == 'O' ? 'selected' : ''}>已入住</option>
							<option value="maintenance" ${room.room_status == 'M' ? 'selected' : ''}>维护中</option>
						</select>
					</div>
					<div class="mb-3">
						<label class="form-label">房间设施</label>
						<c:set var="equipList" value="${fn:split(room.room_equip, ',')}" />
						<div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" id="facilityFridge" name="facilities" value="fridge" <c:if test="${fn:contains(room.room_equip, 'fridge')}">checked</c:if>>
								<label class="form-check-label" for="facilityFridge">冰箱</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" id="facilityTV" name="facilities" value="tv" <c:if test="${fn:contains(room.room_equip, 'tv')}">checked</c:if>>
								<label class="form-check-label" for="facilityTV">平面液晶电视</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" id="facilityAC" name="facilities" value="ac" <c:if test="${fn:contains(room.room_equip, 'ac')}">checked</c:if>>
								<label class="form-check-label" for="facilityAC">空调</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" id="facilityWifi" name="facilities" value="wifi" <c:if test="${fn:contains(room.room_equip, 'wifi')}">checked</c:if>>
								<label class="form-check-label" for="facilityWifi">无线网络</label>
							</div>
						</div>
					</div>
					<div class="mb-3">
						<label for="roomMemo" class="form-label">备注</label>
						<textarea class="form-control" id="roomMemo" name="roomMemo" rows="3">${room.room_memo}</textarea>
					</div>
					<div class="text-center mt-4">
						<button type="submit" class="btn btn-primary px-4">保存修改</button>
						<a href="roomList" class="btn btn-secondary px-4 ms-2">取消</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html> 