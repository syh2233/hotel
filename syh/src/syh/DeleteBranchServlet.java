package syh;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class DeleteBranchServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = "jdbc:mysql://localhost:3306/hotel?serverTimezone=Asia/Shanghai";
        String user = "root";
        String password = "syh2031.";
        Connection connection = null;
        PreparedStatement pstmt = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, user, password);
            int hotelId = Integer.parseInt(request.getParameter("hotel_id"));
            String sql = "DELETE FROM tbl_hotels WHERE hotel_id = ?";
            pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1, hotelId);
            pstmt.executeUpdate();
            response.sendRedirect("branchList?deleteSuccess=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("branchList?deleteSuccess=true");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
} 