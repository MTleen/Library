<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<html>
<html>
<head>
    <title>页面重定向</title>
</head>
<body>

<h1>页面重定向</h1>

<%
    // 重定向到新地址
    String site = new String("http://www.baidu.com");
//    response.setStatus(response.SC_MOVED_TEMPORARILY);
//    response.setHeader("Location", site);\
    if(request.getParameter("name").equals(new String("true"))){
        out.print(111111);
        response.sendRedirect(site);
    }
    out.print(request.getParameter("name"));
%>

</body>
</html>