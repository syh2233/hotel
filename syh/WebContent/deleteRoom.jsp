<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<% 
    String url = "jdbc:mysql://localhost:3306/hotel?serverTimezone=Asia/Shanghai";
    String user = "root";
    String password = "syh2031.";

    Connection connection = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url, user, password);

        // 获取要删除的 room_id
        int roomId = Integer.parseInt(request.getParameter("room_id"));

        // SQL 删除语句
        String sql = "DELETE FROM tbl_rooms WHERE room_id = ?";
        pstmt = connection.prepareStatement(sql);
        pstmt.setInt(1, roomId);

        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            // 删除成功，重定向到房间列表页面
            response.sendRedirect("roomList?deleteSuccess=true");
        } else {
            // 删除失败
            response.sendRedirect("roomList?deleteError=failed");
        }

    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        response.sendRedirect("roomList?deleteError=driverNotFound");
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("roomList?deleteError=dbError&message=" + e.getMessage());
    } catch (NumberFormatException e) {
        e.printStackTrace();
        response.sendRedirect("roomList?deleteError=invalidId");
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%> 