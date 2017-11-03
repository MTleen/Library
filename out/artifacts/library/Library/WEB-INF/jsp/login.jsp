<%--
  Created by IntelliJ IDEA.
  User: HuShengxiang
  Date: 10/10/2017
  Time: 01:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userName = request.getParameter("name");

    if(userName!=null){

        userName = new String(userName.getBytes("ISO-8859-1"), "utf-8");//解决乱码的问题

    }

    String returnString = "";

    returnString="你好，" + userName;

    out.print("http://www.baidu.com");
%>