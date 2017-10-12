<%@ page import="java.net.URLEncoder" %><%--
  Created by IntelliJ IDEA.
  User: HuShengxiang
  Date: 07/10/2017
  Time: 22:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String str = "sd";
    Cookie name = new Cookie("name", str);
    name.setMaxAge(60*60*24);
    response.addCookie(name);
//    Cookie url = new Cookie("url", request.getParameter("url"));
//    url.setMaxAge(60*60*24);
//    response.addCookie(url);

%>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h3>Cookie</h3>

</body>
</html>
