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
        int hotelId = Integer.parseInt(request.getParameter("branchName")); // 假设branchName直接是hotel_id
        String roomNumber = request.getParameter("roomNumber");
        String roomTypeStr = request.getParameter("roomType");
        String roomStatusStr = request.getParameter("roomStatus");
        String[] facilitiesArray = request.getParameterValues("facilities");

        // 映射 room_type
        char roomType;
        switch (roomTypeStr) {
            case "standard":
                roomType = 'S';
                break;
            case "deluxe":
                roomType = 'D';
                break;
            case "suite":
                roomType = 'T'; // 假设 'T' 代表套房
                break;
            default:
                roomType = 'U'; // 未知类型
        }

        // 映射 room_status
        char roomStatus;
        switch (roomStatusStr) {
            case "available":
                roomStatus = 'A';
                break;
            case "occupied":
                roomStatus = 'O';
                break;
            case "maintenance":
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

        // SQL 插入语句
        String sql = "INSERT INTO tbl_rooms (room_no, room_type, room_equip, room_status, hotel_id) VALUES (?, ?, ?, ?, ?)";
        pstmt = connection.prepareStatement(sql);
        pstmt.setString(1, roomNumber);
        pstmt.setString(2, String.valueOf(roomType));
        pstmt.setString(3, roomEquip);
        pstmt.setString(4, String.valueOf(roomStatus));
        pstmt.setInt(5, hotelId);

        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            // 插入成功，重定向到房间列表页面 (假设roomList.jsp存在)
            response.sendRedirect("roomList?success=true");
        } else {
            // 插入失败
            response.sendRedirect("addRoom?error=insertFailed");
        }

    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        response.sendRedirect("addRoom?error=driverNotFound");
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("addRoom?error=dbError&message=" + e.getMessage());
    } catch (NumberFormatException e) {
        e.printStackTrace();
        response.sendRedirect("addRoom?error=invalidHotelId");
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%> 