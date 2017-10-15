<%@ page import="dao.Connector" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.net.URL" %><%--
  Created by IntelliJ IDEA.
  User: HuShengxiang
  Date: 15/10/2017
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String name = URLDecoder.decode(URLDecoder.decode(request.getParameter("name"), "utf-8"), "utf-8");
    Connector connector = new Connector();
    connector.connect();
    Connection conn = connector.getConn();
    try {
        PreparedStatement ps = conn.prepareStatement("DELETE FROM books WHERE id=" + id);
        PreparedStatement ps2 = conn.prepareStatement("DELETE FROM books_lent WHERE id=" + id);
        ps.executeUpdate();
        ps2.executeUpdate();
        connector.closeConn();
        response.getWriter().write("《" + name + "》出库成功！");
    }catch (Exception e){
        e.printStackTrace();
    }
%>