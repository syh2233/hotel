package syh;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class UpdateRoomServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String url = "jdbc:mysql://localhost:3306/hotel?serverTimezone=Asia/Shanghai";
        String user = "root";
        String password = "syh2031.";
        Connection connection = null;
        PreparedStatement pstmt = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, user, password);
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            int hotelId = Integer.parseInt(request.getParameter("branchName"));
            String roomNumber = request.getParameter("roomNumber");
            String roomType = request.getParameter("roomType");
            String roomStatus = request.getParameter("roomStatus");
            String[] facilitiesArray = request.getParameterValues("facilities");
            String roomMemo = request.getParameter("roomMemo");
            String roomEquip = facilitiesArray != null ? String.join(",", facilitiesArray) : "";
            char roomTypeChar = 'U';
            switch (roomType) {
                case "standard": roomTypeChar = 'S'; break;
                case "deluxe": roomTypeChar = 'D'; break;
                case "suite": roomTypeChar = 'T'; break;
            }
            char roomStatusChar = 'X';
            switch (roomStatus) {
                case "available": roomStatusChar = 'A'; break;
                case "occupied": roomStatusChar = 'O'; break;
                case "maintenance": roomStatusChar = 'M'; break;
            }
            String sql = "UPDATE tbl_rooms SET room_no = ?, room_type = ?, room_equip = ?, room_status = ?, room_memo = ?, hotel_id = ? WHERE room_id = ?";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, roomNumber);
            pstmt.setString(2, String.valueOf(roomTypeChar));
            pstmt.setString(3, roomEquip);
            pstmt.setString(4, String.valueOf(roomStatusChar));
            pstmt.setString(5, roomMemo);
            pstmt.setInt(6, hotelId);
            pstmt.setInt(7, roomId);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("roomList.jsp?updateSuccess=true");
            } else {
                response.sendRedirect("editRoom.jsp?room_id=" + roomId + "&updateError=failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("editRoom.jsp?room_id=" + request.getParameter("roomId") + "&updateError=exception");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
} 