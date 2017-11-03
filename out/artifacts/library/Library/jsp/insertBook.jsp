<%@ page import="dao.Connector" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.net.URLDecoder" %><%--
  Created by IntelliJ IDEA.
  User: HuShengxiang
  Date: 24/10/2017
  Time: 19:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="utf-8" %>
<%
    String cover = request.getParameter("cover");
    String name = URLDecoder.decode(URLDecoder.decode(request.getParameter("name"), "utf-8"), "utf-8");
    String edition = URLDecoder.decode(URLDecoder.decode(request.getParameter("edition"), "utf-8"), "utf-8");
    String author = URLDecoder.decode(URLDecoder.decode(request.getParameter("author"), "utf-8"), "utf-8");
    System.out.println(URLDecoder.decode(URLDecoder.decode(request.getParameter("name"), "utf-8"), "utf-8"));
    int amount = Integer.parseInt(request.getParameter("amount"));
    int total = Integer.parseInt(request.getParameter("total"));
    int type = Integer.parseInt(request.getParameter("type"));
    int id = 0;
    ResultSet rs;
    Connector connector = new Connector();
    connector.connect();
    Connection conn = connector.getConn();
    try {
        rs = connector.query("select MAX(id) from books");
        if(rs.next()){
            id = rs.getInt(1) + 1;
        };
        PreparedStatement ps = conn.prepareStatement("INSERT INTO books values(?, ?, ?, ?, ?, ?, ?, ?)");
        ps.setInt(1, id);
        ps.setString(2, name);
        ps.setInt(3, type);
        ps.setString(4, edition);
        ps.setString(5, author);
        ps.setInt(6, amount);
        ps.setInt(7, total);
        ps.setString(8, cover);
        ps.executeUpdate();
        response.getWriter().write("true");
    }catch (Exception e){
        System.out.println(e.getMessage());
        response.getWriter().write("false");
        e.printStackTrace();
    }
%>