<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.util.stream.Collectors"%>
<% 
    String url = "jdbc:mysql://localhost:3306/hotel?serverTimezone=Asia/Shanghai";
    String user = "root";
    String password = "syh2031.";

    Connection connection = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url, user, password);

        // 获取表单数据
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        int hotelId = Integer.parseInt(request.getParameter("branchName")); 
        String roomNumber = request.getParameter("roomNumber");
        String roomTypeStr = request.getParameter("roomType");
        String roomStatusStr = request.getParameter("roomStatus");
        String[] facilitiesArray = request.getParameterValues("facilities");
        String roomMemo = request.getParameter("roomMemo");

        // 映射 room_type
        char roomType;
        switch (roomTypeStr) {
            case "S":
                roomType = 'S';
                break;
            case "D":
                roomType = 'D';
                break;
            case "T":
                roomType = 'T';
                break;
            default:
                roomType = 'U'; // 未知类型
        }

        // 映射 room_status
        char roomStatus;
        switch (roomStatusStr) {
            case "A":
                roomStatus = 'A';
                break;
            case "O":
                roomStatus = 'O';
                break;
            case "M":
                roomStatus = 'M';
                break;
            default:
                roomStatus = 'X'; // 未知状态
        }

        // 组合房间设施
        String roomEquip = "";
        if (facilitiesArray != null) {
            roomEquip = String.join(",", facilitiesArray);
        }

        // SQL 更新语句
        String sql = "UPDATE tbl_rooms SET room_no = ?, room_type = ?, room_equip = ?, room_status = ?, room_memo = ?, hotel_id = ? WHERE room_id = ?";
        pstmt = connection.prepareStatement(sql);
        pstmt.setString(1, roomNumber);
        pstmt.setString(2, String.valueOf(roomType));
        pstmt.setString(3, roomEquip);
        pstmt.setString(4, String.valueOf(roomStatus));
        pstmt.setString(5, roomMemo);
        pstmt.setInt(6, hotelId);
        pstmt.setInt(7, roomId);

        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            // 更新成功，重定向到房间列表页面
            response.sendRedirect("roomList?updateSuccess=true");
        } else {
            // 更新失败
            response.sendRedirect("editRoom?room_id=" + roomId + "&updateError=failed");
        }

    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        response.sendRedirect("editRoom?room_id=" + roomId + "&updateError=driverNotFound");
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("editRoom?room_id=" + roomId + "&updateError=dbError&message=" + e.getMessage());
    } catch (NumberFormatException e) {
        e.printStackTrace();
        response.sendRedirect("editRoom?room_id=" + roomId + "&updateError=invalidId");
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%> 