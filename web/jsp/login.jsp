<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: HuShengxiang
  Date: 07/10/2017
  Time: 23:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="connector" class="dao.Connector" />
<%
    try {
        connector.connect();
        String name = request.getParameter("userName");
        String psw = request.getParameter("psw");
        String sql = "select * from customer where name='" + name + "' and password='" + psw + "'";
        String isAdmin = "";
        int id = 0;
        ResultSet rs = connector.query(sql);
        if(rs != null){
            if(rs.next()){
                id = rs.getInt(1);
                isAdmin = rs.getString(4);
                String json = "{id:" + id + ", isAdmin:" + isAdmin + ", isPswCorrect: true}";
                response.getWriter().write(json);
                connector.closeConn();
            }else {
                response.getWriter().write("{isPswCorrect: false}");
            }
        }
    }catch (Exception e){
        e.printStackTrace();
    }
%>