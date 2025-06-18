package syh;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

public class RoomListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = "jdbc:mysql://localhost:3306/hotel?serverTimezone=Asia/Shanghai";
        String user = "root";
        String password = "syh2031.";
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        List<Map<String, Object>> roomList = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, user, password);
            statement = connection.createStatement();
            String sql = "SELECT r.room_id, r.room_no, r.room_type, r.room_equip, r.room_status, r.room_memo, h.hotel_name FROM tbl_rooms r JOIN tbl_hotels h ON r.hotel_id = h.hotel_id ORDER BY r.room_id";
            resultSet = statement.executeQuery(sql);
            while (resultSet.next()) {
                Map<String, Object> room = new HashMap<>();
                room.put("room_id", resultSet.getInt("room_id"));
                room.put("hotel_name", resultSet.getString("hotel_name"));
                room.put("room_no", resultSet.getString("room_no"));
                room.put("room_type", resultSet.getString("room_type"));
                room.put("room_equip", resultSet.getString("room_equip"));
                room.put("room_status", resultSet.getString("room_status"));
                room.put("room_memo", resultSet.getString("room_memo"));
                roomList.add(room);
            }
            request.setAttribute("roomList", roomList);
            RequestDispatcher dispatcher = request.getRequestDispatcher("roomList.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("roomList.jsp?error=true");
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (statement != null) try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
} 