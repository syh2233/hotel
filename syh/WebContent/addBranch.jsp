<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>添加分店</title>
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

<script>
  // 前端验证房间数量是否为有效数字
  function validateForm(event) {
    let roomCount = document.getElementById("roomCount").value;
    if (roomCount === "" || isNaN(roomCount) || roomCount <= 0) {
      alert("请输入有效的房间数量！");
      event.preventDefault(); // 阻止表单提交
      return false;
    }
    return true;
  }

  // 图片预览功能
  document.addEventListener('DOMContentLoaded', function() {
    const hotelPicInput = document.getElementById('hotelPic');
    const hotelPicPreview = document.getElementById('hotelPicPreview');

    if (hotelPicInput && hotelPicPreview) {
      hotelPicInput.addEventListener('change', function(event) {
        const file = event.target.files[0];
        if (file) {
          const reader = new FileReader();
          reader.onload = function(e) {
            hotelPicPreview.src = e.target.result;
            hotelPicPreview.style.display = 'block'; // 显示图片
          };
          reader.readAsDataURL(file);
        } else {
          hotelPicPreview.src = '';
          hotelPicPreview.style.display = 'none'; // 隐藏图片
        }
      });
    }
  });
</script>

</head>
<body>
	<jsp:include page="header.jsp" />
	<div class="container mt-4">
		<nav aria-label="breadcrumb" class="syh-breadcrumb">
			<ol class="breadcrumb mb-0">
				<li class="breadcrumb-item"><a href="#">首页</a></li>
				<li class="breadcrumb-item"><a href="#">分店管理</a></li>
				<li class="breadcrumb-item"><a href="branchList">分店列表</a></li>
				<li class="breadcrumb-item active" aria-current="page">添加分店</li>
			</ol>
		</nav>
		<div class="card mt-4">
			<div class="card-header">
				<h2 class="mb-0">添加分店</h2>
			</div>
			<div class="card-body">
				<form action="addBranch" method="post"
					enctype="multipart/form-data" onsubmit="return validateForm(event)">
					<div class="row">
						<div class="col-md-6">
							<div class="mb-3">
								<label for="hotelName" class="form-label">分店名称</label> <input
									type="text" class="form-control" id="hotelName" name="hotelName"
									required />
							</div>
							<div class="mb-3">
								<label for="hotelAddress" class="form-label">分店地址</label> <input
									type="text" class="form-control" id="hotelAddress"
									name="hotelAddress" required />
							</div>
							<div class="mb-3">
								<label for="hotelPhone" class="form-label">分店电话</label> <input
									type="text" class="form-control" id="hotelPhone" name="hotelPhone"
									required />
							</div>
							<div class="mb-3">
								<label for="roomCount" class="form-label">房间总数</label> <input
									type="text" class="form-control" id="roomCount" name="roomCount"
									required />
							</div>
						</div>
						<div class="col-md-6">
							<div class="mb-3">
								<label for="hotelPic" class="form-label">分店图片</label> <input
									type="file" class="form-control" id="hotelPic" name="hotelPic" />
								<div class="mt-3 text-center">
									<img id="hotelPicPreview" src="#" alt="图片预览" 
										style="max-width: 100%; max-height: 300px; display: none; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);"/>
								</div>
							</div>
						</div>
					</div>
					<div class="text-center mt-4">
						<button type="submit" class="btn btn-primary px-4">提交</button>
						<a href="branchList" class="btn btn-secondary px-4 ms-2">返回</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>
