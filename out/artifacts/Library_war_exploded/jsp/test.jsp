<%--
  Created by IntelliJ IDEA.
  User: HuShengxiang
  Date: 07/10/2017
  Time: 15:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h2>HTTP 头部请求实例</h2>
    <table width="100%" border="1" align="center">
        <tr bgcolor="#faebd7">
            <th>Header Name</th><th>Header Values</th>
        </tr>
        <%
            Enumeration headerNames = request.getHeaderNames();
            while(headerNames.hasMoreElements()){
                String param = (String)headerNames.nextElement();
                out.print("<tr><td>" + param + "</td>\n");
                String paramV = request.getHeader(param);
                out.print("<td>" + paramV + "</td></tr>\n");
            }
        %>
    </table>

    <h2>自动刷新实例</h2>
    <%
        //设置每个5秒自动刷新
        response.setIntHeader("Refresh", 5);
        //获取当前时间
        Calendar calendar = new GregorianCalendar();
        String am_pm;
        int hour = calendar.get(Calendar.HOUR);
        int minute = calendar.get(Calendar.MINUTE);
        int second = calendar.get(Calendar.SECOND);
        am_pm = (calendar.get(Calendar.AM_PM) == 0) ? "AM" : "PM";
        String CT = hour + ":" + minute + ":" + second + " " + am_pm;
        out.print("当前时间：" + CT);
    %>

    <h2>使用POST提交的数据</h2>
    <%
        //解决中文乱码的问题
        String name = request.getParameter("name");
        String url = request.getParameter("url");
    %>
    <p>Name: <%= name%></p>
    <p>Url: <%= url%></p>

</body>
</html>
