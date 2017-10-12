<%--
  Created by IntelliJ IDEA.
  User: HuShengxiang
  Date: 08/10/2017
  Time: 00:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<jsp:useBean id="connector" class="dao.Connector">

</jsp:useBean>>
    <%
        connector.connect();
        String sql = "select * from admin";
        ResultSet rs = connector.query(sql);
        while(rs.next()){

        }

    %>
</body>
</html>
