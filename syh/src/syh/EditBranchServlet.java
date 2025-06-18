package syh;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

public class EditBranchServlet extends HttpServlet {
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
            int hotelId = Integer.parseInt(request.getParameter("hotel_id"));
            String sql = "SELECT hotel_id, hotel_name, hotel_addr, hotel_phone FROM tbl_hotels WHERE hotel_id = ?";
            pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1, hotelId);
            resultSet = pstmt.executeQuery();
            Map<String, Object> branch = new HashMap<>();
            if (resultSet.next()) {
                branch.put("hotel_id", resultSet.getInt("hotel_id"));
                branch.put("hotel_name", resultSet.getString("hotel_name"));
                branch.put("hotel_addr", resultSet.getString("hotel_addr"));
                branch.put("hotel_phone", resultSet.getString("hotel_phone"));
            }
            request.setAttribute("branch", branch);
            RequestDispatcher dispatcher = request.getRequestDispatcher("editBranch.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("branchList.jsp?editError=true");
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
} 