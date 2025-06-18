 package syh;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

public class BranchListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = "jdbc:mysql://localhost:3306/hotel?serverTimezone=Asia/Shanghai";
        String user = "root";
        String password = "syh2031.";
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        List<Map<String, Object>> branchList = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, user, password);
            statement = connection.createStatement();
            String sql = "SELECT hotel_id, hotel_name, hotel_addr, hotel_phone FROM tbl_hotels ORDER BY hotel_id";
            resultSet = statement.executeQuery(sql);
            while (resultSet.next()) {
                Map<String, Object> branch = new HashMap<>();
                branch.put("hotel_id", resultSet.getInt("hotel_id"));
                branch.put("hotel_name", resultSet.getString("hotel_name"));
                branch.put("hotel_addr", resultSet.getString("hotel_addr"));
                branch.put("hotel_phone", resultSet.getString("hotel_phone"));
                branchList.add(branch);
            }
            request.setAttribute("branchList", branchList);
            RequestDispatcher dispatcher = request.getRequestDispatcher("branchList.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("branchList.jsp?error=true");
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (statement != null) try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}