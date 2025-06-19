package syh;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;

@MultipartConfig
public class AddBranchServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("addBranch.jsp").forward(request, response);
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
            String branchName = request.getParameter("hotelName");
            System.out.println("hotelName=" + branchName);
            String branchAddress = request.getParameter("hotelAddress");
            String branchPhone = request.getParameter("hotelPhone");
            Part hotelPicPart = request.getPart("hotelPic");
            byte[] hotelPicBytes = null;
            if (hotelPicPart != null && hotelPicPart.getSize() > 0) {
                java.io.InputStream is = hotelPicPart.getInputStream();
                hotelPicBytes = is.readAllBytes();
                is.close();
            }
            String sql = "INSERT INTO tbl_hotels (hotel_name, hotel_addr, hotel_phone, hotel_pic) VALUES (?, ?, ?, ?)";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, branchName);
            pstmt.setString(2, branchAddress);
            pstmt.setString(3, branchPhone);
            if (hotelPicBytes != null) {
                pstmt.setBytes(4, hotelPicBytes);
            } else {
                pstmt.setNull(4, java.sql.Types.BLOB);
            }
            pstmt.executeUpdate();
            response.sendRedirect("branchList?addSuccess=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addBranch?addError=true");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}