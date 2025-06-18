<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>添加房间</title>
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
				<li class="breadcrumb-item active" aria-current="page">添加房间</li>
			</ol>
		</nav>
		<div class="card mt-4">
			<div class="card-header">
				<h2 class="mb-0">添加房间</h2>
			</div>
			<div class="card-body">
				<form action="addRoom" method="post">
					<div class="mb-3">
						<label for="branchName" class="form-label">分店名称</label> <select
							class="form-select" id="branchName" name="branchName" required>
							<option value="">请选择分店</option>
							<% 
								String url = "jdbc:mysql://localhost:3306/hotel?serverTimezone=Asia/Shanghai";
								String user = "root";
								String password = "syh2031.";
								Connection connection = null;
								Statement statement = null;
								ResultSet resultSet = null;
								try {
									Class.forName("com.mysql.cj.jdbc.Driver");
									connection = DriverManager.getConnection(url, user, password);
									statement = connection.createStatement();
									String sql = "SELECT hotel_id, hotel_name FROM tbl_hotels";
									resultSet = statement.executeQuery(sql);
									while (resultSet.next()) {
										int hotelId = resultSet.getInt("hotel_id");
										String hotelName = resultSet.getString("hotel_name");
							%> 
							<option value="<%= hotelId %>"><%= hotelName %></option>
							<% 
									}
								} catch (ClassNotFoundException e) {
									e.printStackTrace();
								} catch (SQLException e) {
									e.printStackTrace();
								} finally {
									if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
									if (statement != null) try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
									if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
								}
							%> 
						</select>
					</div>
					<div class="mb-3">
						<label for="roomNumber" class="form-label">房间号码</label> <input
							type="text" class="form-control" id="roomNumber" name="roomNumber"
							required />
					</div>
					<div class="mb-3">
						<label for="roomType" class="form-label">房间类型</label> <select
							class="form-select" id="roomType" name="roomType" required>
							<option value="">请选择房间类型</option>
							<option value="standard">标准间</option>
							<option value="deluxe">豪华间</option>
							<option value="suite">套房</option>
						</select>
					</div>
					<div class="mb-3">
						<label for="roomStatus" class="form-label">房间状态</label> <select
							class="form-select" id="roomStatus" name="roomStatus" required>
							<option value="available">未入住</option>
							<option value="occupied">已入住</option>
							<option value="maintenance">维护中</option>
						</select>
					</div>
					<div class="mb-3">
						<label for="roomMemo" class="form-label">备注</label>
						<input type="text" class="form-control" id="roomMemo" name="roomMemo" placeholder="请输入备注（可选）" />
					</div>
					<div class="mb-3">
						<label class="form-label">房间设施</label>
						<div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox"
									id="facilityFridge" name="facilities" value="fridge">
								<label class="form-check-label" for="facilityFridge">冰箱</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox"
									id="facilityTV" name="facilities" value="tv">
								<label class="form-check-label" for="facilityTV">平面液晶电视</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox"
									id="facilityAC" name="facilities" value="ac">
								<label class="form-check-label" for="facilityAC">空调</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox"
									id="facilityWifi" name="facilities" value="wifi">
								<label class="form-check-label" for="facilityWifi">无线网络</label>
							</div>
						</div>
					</div>
					<div class="text-center mt-4">
						<button type="submit" class="btn btn-primary px-4">提交</button>
						<a href="roomList" class="btn btn-secondary px-4 ms-2">返回</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html> 