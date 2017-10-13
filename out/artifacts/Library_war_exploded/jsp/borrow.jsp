<%@ page import="dao.Connector" %><%--
  Created by IntelliJ IDEA.
  User: HuShengxiang
  Date: 14/10/2017
  Time: 03:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%
    Connector connector = new Connector();
    connector.connect();

%>