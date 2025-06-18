package syh;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class AddRoomServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("addRoom.jsp").forward(request, response);
    }

    @Override
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
            String sql = "INSERT INTO tbl_rooms (room_no, room_type, room_equip, room_status, room_memo, hotel_id) VALUES (?, ?, ?, ?, ?, ?)";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, roomNumber);
            pstmt.setString(2, String.valueOf(roomTypeChar));
            pstmt.setString(3, roomEquip);
            pstmt.setString(4, String.valueOf(roomStatusChar));
            pstmt.setString(5, roomMemo);
            pstmt.setInt(6, hotelId);
            pstmt.executeUpdate();
            response.sendRedirect("roomList?addSuccess=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addRoom?addError=true");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}