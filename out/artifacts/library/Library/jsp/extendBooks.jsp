<%@ page import="dao.Connector" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.net.URLDecoder" %><%--
  Created by IntelliJ IDEA.
  User: HuShengxiang
  Date: 16/10/2017
  Time: 00:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    int userId = Integer.parseInt(request.getParameter("userId"));
    String name = URLDecoder.decode(URLDecoder.decode(request.getParameter("name"), "utf-8"), "utf-8");
    String deadline = request.getParameter("deadline");
    Connector connector = new Connector();
    connector.connect();
    Connection conn = connector.getConn();
    try {
        PreparedStatement ps = conn.prepareStatement("UPDATE books_lent SET deadline='" + deadline + "',isExtended='true' WHERE id=" + id + " and owner_id=" + userId);
        ps.executeUpdate();
        response.getWriter().write("{\"name\": \"" + name + "\", \"date\": \"" + deadline + "\"}");
    }catch (Exception e){
        e.printStackTrace();
    }
%>