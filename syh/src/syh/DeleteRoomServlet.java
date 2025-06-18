 package syh;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class DeleteRoomServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = "jdbc:mysql://localhost:3306/hotel?serverTimezone=Asia/Shanghai";
        String user = "root";
        String password = "syh2031.";
        Connection connection = null;
        PreparedStatement pstmt = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, user, password);
            int roomId = Integer.parseInt(request.getParameter("room_id"));
            String sql = "DELETE FROM tbl_rooms WHERE room_id = ?";
            pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1, roomId);
            pstmt.executeUpdate();
            response.sendRedirect("roomList.jsp?deleteSuccess=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("roomList.jsp?deleteError=true");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}