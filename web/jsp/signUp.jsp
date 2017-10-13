<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: HuShengxiang
  Date: 11/10/2017
  Time: 00:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="connector" class="dao.Connector"/>
<%

    String name = request.getParameter("userNameS");
    String psw = request.getParameter("pswS");
    int id = 0;
    try {
        connector.connect();
        Connection conn = connector.getConn();
//        查找当前数据库中已有的最大用户id，id+1 即为新用户id
        String sql = "select MAX(id) from customer;";
        ResultSet rs = connector.query(sql);
        if (rs.next()){
            id = rs.getInt(1) + 1;
            String update = "insert into customer values (?,?,?,'false');";
            PreparedStatement ps = conn.prepareStatement(update);
            ps.setInt(1, id);
            ps.setString(2, name);
            ps.setString(3, psw);
            ps.executeUpdate();
//            返回json
            response.getWriter().write("{id: " + id + ",isAdmin: 'false'}");
        }else {
//            返回数据库错误，之后在做，我相信数据库是不可能有错的
            response.getWriter().write("服务器异常，请重试。");
        }
        rs.close();
        connector.closeConn();
    }catch (Exception e){
        System.out.print(e.getMessage());
        e.printStackTrace();
    }
%>