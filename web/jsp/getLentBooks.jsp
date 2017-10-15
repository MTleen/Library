<%@ page import="dao.Connector" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="dao.BookModel" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="net.sf.json.JSONArray" %><%--
  Created by IntelliJ IDEA.
  User: HuShengxiang
  Date: 15/10/2017
  Time: 17:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Connector connector = new Connector();
    connector.connect();
    Connection conn = connector.getConn();
    ResultSet rs, rs2;
    ArrayList bookModels = new ArrayList();
    try {
        rs = connector.query("select * from books_lent where owner_id=" + id);
        while(rs.next()){
            BookModel bm = new BookModel();
            int bookId = rs.getInt(1);
            rs2 = connector.query("select type,edition,writer from books where id=" + bookId);
            while (rs2.next()){
                bm.setType(rs2.getInt(1));
                bm.setVersion(rs2.getString(2));
                bm.setAuthor(rs2.getString(3));
            }
            bm.setId(bookId);
            bm.setName(rs.getString(2));
            System.out.print(rs.getString(4));
            bm.setInitTime(rs.getString(4));
            bm.setDeadline(rs.getString(5));
            bookModels.add(bm);
        }
        if(bookModels.size() != 0){
            //将ArrayList对象转化成json数组；
            JSONArray ja = JSONArray.fromObject(bookModels);
//            json数组转换成字符串
            String jas = ja.toString();
            response.getWriter().write(jas);
        }else{
            response.getWriter().write("false");
        }
        rs.close();
        connector.closeConn();
    }catch (Exception e){
        e.printStackTrace();
    }
%>