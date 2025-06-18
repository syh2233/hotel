package syh;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

public class EditRoomServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = "jdbc:mysql://localhost:3306/hotel?serverTimezone=Asia/Shanghai";
        String user = "root";
        String password = "syh2031.";
        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, user, password);
            int roomId = Integer.parseInt(request.getParameter("room_id"));
            String sql = "SELECT * FROM tbl_rooms WHERE room_id = ?";
            pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1, roomId);
            resultSet = pstmt.executeQuery();
            Map<String, Object> room = new HashMap<>();
            if (resultSet.next()) {
                room.put("room_id", resultSet.getInt("room_id"));
                room.put("hotel_id", resultSet.getInt("hotel_id"));
                room.put("room_no", resultSet.getString("room_no"));
                room.put("room_type", resultSet.getString("room_type"));
                room.put("room_equip", resultSet.getString("room_equip"));
                room.put("room_status", resultSet.getString("room_status"));
                room.put("room_memo", resultSet.getString("room_memo"));
            }
            // 查询所有分店
            Statement stmt2 = connection.createStatement();
            ResultSet rs2 = stmt2.executeQuery("SELECT hotel_id, hotel_name FROM tbl_hotels");
            List<Map<String, Object>> hotelList = new ArrayList<>();
            while (rs2.next()) {
                Map<String, Object> hotel = new HashMap<>();
                hotel.put("hotel_id", rs2.getInt("hotel_id"));
                hotel.put("hotel_name", rs2.getString("hotel_name"));
                hotelList.add(hotel);
            }
            rs2.close();
            stmt2.close();
            request.setAttribute("room", room);
            request.setAttribute("hotelList", hotelList);
            RequestDispatcher dispatcher = request.getRequestDispatcher("editRoom.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("roomList.jsp?editError=true");
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
} 