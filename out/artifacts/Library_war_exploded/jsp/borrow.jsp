<%@ page import="dao.Connector" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.net.URLDecoder" %><%--
  Created by IntelliJ IDEA.
  User: HuShengxiang
  Date: 14/10/2017
  Time: 03:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%
//    System.out.print(request.getParameter("bookId"));
    int id = Integer.parseInt(request.getParameter("bookId")),
            userId = Integer.parseInt(request.getParameter("userId")),
            amount = Integer.parseInt(request.getParameter("amount"));
    String initDate = request.getParameter("initDate"),
            deadline = request.getParameter("deadline"),
            name = URLDecoder.decode(URLDecoder.decode(request.getParameter("name"), "utf-8"), "utf-8");
    Connector connector = new Connector();
    connector.connect();
    Connection conn = connector.getConn();
    try {
//    查询books_lent表，若该用户已借阅该书则不能再次借阅
        ResultSet rs1 = connector.query("select * from books_lent where id=" + id + " and owner_id=" + userId + ";");
        if(rs1.next()){
            response.getWriter().write("{\"message\":\"已借阅此书，请不要重复借阅！\", \"status\": false}");
        }else {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO books_lent VALUES (?, ?, ?, ?, ?, 'false');");
            ps.setInt(1, id);
            ps.setString(2, name);
            ps.setInt(3, userId);
            ps.setString(4, initDate);
            ps.setString(5, deadline);
            ps.executeUpdate();
            Statement st = conn.createStatement();
            st.executeUpdate("UPDATE books SET isAvailable=" + amount + " where id=" + id + ";");
            response.getWriter().write("{\"message\": \"借阅成功，请前往个人中心查看！\", \"status\": true}");
        }
        rs1.close();
        connector.closeConn();
    }catch (Exception e){
        e.printStackTrace();
    }

%>