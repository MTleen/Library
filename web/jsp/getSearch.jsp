<%@ page import="dao.Connector" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.BookModel" %><%--
  Created by IntelliJ IDEA.
  User: HuShengxiang
  Date: 13/10/2017
  Time: 15:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%
    String text = request.getParameter("text");
    ArrayList al = new ArrayList();
    try {
        Connector connector = new Connector();
        connector.connect();
        Connection conn = connector.getConn();
        ResultSet rs;
        String sql = "select * from books where name='" + text + "' or writer='" + text + "';";
        rs = connector.query(sql);
        while (rs.next()){
            BookModel bookModel = new BookModel();
            bookModel
        }
    }catch (Exception e){
        e.printStackTrace();
    }

%>