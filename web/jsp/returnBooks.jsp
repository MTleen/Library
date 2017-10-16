<%@ page import="dao.Connector" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: HuShengxiang
  Date: 16/10/2017
  Time: 00:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%
    int id = Integer.parseInt(request.getParameter("id")),
        userId = Integer.parseInt(request.getParameter("userId"));
    Connector connector = new Connector();
    connector.connect();
    Connection conn = connector.getConn();
    PreparedStatement ps;
    ResultSet rs;
    try {
        ps = conn.prepareStatement("DELETE FROM books_lent WHERE id=" + id + " and owner_id=" + userId);
        ps.executeUpdate();
        rs = connector.query("select isAvailable from books where id=" + id);
        if(rs.next()){
            int amount = rs.getInt(1);
            ps = conn.prepareStatement("UPDATE books SET isAvailable=" + (amount + 1) + " where id=" + id);
            ps.executeUpdate();
        }
        response.getWriter().write("归还成功，欢迎下次借阅！");
    }catch (Exception e){
        e.printStackTrace();
    }
%>