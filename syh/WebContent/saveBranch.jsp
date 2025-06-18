<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page
	import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="java.util.List"%>

<%
    String hotelName = "";
    String hotelAddress = "";
    String hotelPhone = "";
    String roomCountStr = "";
    String hotelPicFileName = "";
    byte[] hotelPicBytes = null;
    FileItem hotelPic = null;

    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    if (isMultipart) {
        try {
            // 创建FileItemFactory
            DiskFileItemFactory factory = new DiskFileItemFactory();
            // 设置内存缓冲区大小
            factory.setSizeThreshold(1024 * 1024);
            // 设置临时文件目录
            factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
            
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setHeaderEncoding("UTF-8");
            List<FileItem> items = upload.parseRequest(request);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    // 处理普通表单字段
                    String fieldName = item.getFieldName();
                    String fieldValue = item.getString("UTF-8");
                    
                    if ("hotelName".equals(fieldName)) {
                        hotelName = fieldValue;
                    } else if ("hotelAddress".equals(fieldName)) {
                        hotelAddress = fieldValue;
                    } else if ("hotelPhone".equals(fieldName)) {
                        hotelPhone = fieldValue;
                    } else if ("roomCount".equals(fieldName)) {
                        roomCountStr = fieldValue;
                    }
                } else {
                    // 处理文件上传
                    hotelPic = item;
                    hotelPicFileName = item.getName();
                    InputStream fileContent = item.getInputStream();
                    ByteArrayOutputStream baos = new ByteArrayOutputStream();
                    byte[] buffer = new byte[1024];
                    int len;
                    while ((len = fileContent.read(buffer)) > -1) {
                        baos.write(buffer, 0, len);
                    }
                    hotelPicBytes = baos.toByteArray();
                }
            }
        } catch (Exception ex) {
            out.println("<div class='alert alert-danger'>表单处理失败！</div>");
            ex.printStackTrace();
            return;
        }
    }

    // 调试信息：输出 roomCount 的值
    out.println("<div>Received roomCount: " + roomCountStr + "</div>");
    
    // 检查 roomCount 是否为空或无效
    if (roomCountStr == null || roomCountStr.trim().isEmpty()) {
        out.println("<div class='alert alert-danger'>房间数量不能为空！</div>");
        return;
    }

    roomCountStr = roomCountStr.trim();  // 去除空格
    int roomCount = 0;
    try {
        roomCount = Integer.parseInt(roomCountStr); // 尝试解析为数字
    } catch (NumberFormatException e) {
        out.println("<div class='alert alert-danger'>房间数量必须是数字！</div>");
        return;  // 结束处理
    }

    String url = "jdbc:mysql://localhost:3306/hotel?serverTimezone=Asia/Shanghai";
    String user = "root";
    String password = "syh2031.";
    Connection connection = null;
    PreparedStatement statement = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url, user, password);
        String sql = "INSERT INTO tbl_hotels (hotel_name, hotel_addr, hotel_phone, hotel_room_count, hotel_pic) VALUES (?, ?, ?, ?, ?)";
        statement = connection.prepareStatement(sql);
        statement.setString(1, hotelName);
        statement.setString(2, hotelAddress);
        statement.setString(3, hotelPhone);
        statement.setInt(4, roomCount);
        if (hotelPicBytes != null) {
            statement.setBytes(5, hotelPicBytes);
        } else {
            statement.setNull(5, Types.BLOB);
        }
        statement.executeUpdate();
        out.println("<div id='success-alert' class='alert alert-success'>分店添加成功！</div>");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<div class=' alert-danger'>分店添加失败！</div>");
    } finally {
        if (statement != null) try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const successAlert = document.getElementById('success-alert');
        if (successAlert) {
            setTimeout(() => {
                successAlert.style.display = 'none';
            }, 3000); // 3秒后隐藏
        }
    });
</script>

<jsp:include page="branchList" />
