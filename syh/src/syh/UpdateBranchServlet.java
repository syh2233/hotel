package syh;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class UpdateBranchServlet extends HttpServlet {
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
            int hotelId = Integer.parseInt(request.getParameter("hotelId"));
            String branchName = request.getParameter("branchName");
            String branchAddress = request.getParameter("branchAddress");
            String branchPhone = request.getParameter("branchPhone");
            String sql = "UPDATE tbl_hotels SET hotel_name = ?, hotel_addr = ?, hotel_phone = ? WHERE hotel_id = ?";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, branchName);
            pstmt.setString(2, branchAddress);
            pstmt.setString(3, branchPhone);
            pstmt.setInt(4, hotelId);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("branchList.jsp?updateSuccess=true");
            } else {
                response.sendRedirect("editBranch.jsp?hotel_id=" + hotelId + "&updateError=failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("editBranch.jsp?hotel_id=" + request.getParameter("hotelId") + "&updateError=exception");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
} 