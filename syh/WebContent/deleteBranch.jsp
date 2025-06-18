<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    String hotelIdStr = request.getParameter("hotel_id");
    int hotelId = 0;

    if (hotelIdStr != null && !hotelIdStr.trim().isEmpty()) {
        try {
            hotelId = Integer.parseInt(hotelIdStr);
        } catch (NumberFormatException e) {
            out.println("<script>alert('无效的分店ID！');window.location.href='branchList';</script>");
            return;
        }
    } else {
        out.println("<script>alert('分店ID不能为空！');window.location.href='branchList';</script>");
        return;
    }

    String url = "jdbc:mysql://localhost:3306/hotel?serverTimezone=Asia/Shanghai";
    String user = "root";
    String password = "syh2031.";
    Connection connection = null;
    PreparedStatement statement = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url, user, password);
        String sql = "DELETE FROM tbl_hotels WHERE hotel_id = ?";
        statement = connection.prepareStatement(sql);
        statement.setInt(1, hotelId);
        int rowsAffected = statement.executeUpdate();

        if (rowsAffected > 0) {
            out.println("<script>alert('分店删除成功！');window.location.href='branchList';</script>");
        } else {
            out.println("<script>alert('分店删除失败或分店不存在！');window.location.href='branchList';</script>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('删除过程中发生错误！');window.location.href='branchList';</script>");
    } finally {
        if (statement != null) try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%> 