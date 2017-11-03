<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="net.sf.json.*"%>
<%@ page import="dao.BookModel" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="dao.Connector" %>
<%@ page import="dao.GetBooks" %>
<%@ page import="java.util.ArrayList" %>
<%@ page pageEncoding="UTF-8" %>
<%--
  Created by IntelliJ IDEA.
  User: HuShengxiang
  Date: 12/10/2017
  Time: 15:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:useBean id="connector" class="dao.Connector"/>--%>
<%--<jsp:useBean id="getBooks" class="dao.GetBooks" />--%>
<%--<jsp:useBean id="bookModels" class="java.util.ArrayList" />--%>
<%
    Connector connector = new Connector();
    GetBooks getBooks = new GetBooks();
    ArrayList bookModels = new ArrayList();
    response.setContentType("text/html;charset=UTF-8");

    String method = request.getParameter("method"),
            sql = "",
            bookTable = request.getParameter("bookTable");;
    int type = Integer.parseInt(request.getParameter("type"));
    connector.connect();
    Connection conn = connector.getConn();
    ResultSet rs = null;
    getBooks.setConn(conn);

    if(method.equals("getBooks")){
        try {
            rs = getBooks.getBooks(bookTable, type);
        }catch (Exception e){
            e.printStackTrace();
            out.print(e.getMessage());
        }
    }else if(method.equals("getSearch")){
        try {
            String text = URLDecoder.decode(URLDecoder.decode(request.getParameter("text"), "utf-8"), "utf-8");
            sql = "select * from " + bookTable + " where (name like '%" + text + "%' or writer like '%" + text + "%') and type=" + type + " ;";
            rs = connector.query(sql);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    try {
        while(rs.next()){
            BookModel bookModel = new BookModel();
            bookModel.setId(rs.getInt(1));
            bookModel.setName(rs.getString(2));
            bookModel.setType(rs.getInt(3));
            bookModel.setVersion(rs.getString(4));
            bookModel.setAuthor(rs.getString(5));
            bookModel.setAmount(rs.getInt(6));
            bookModel.setTotal(rs.getInt(7));
            bookModel.setCover(rs.getString(8));
            bookModels.add(bookModel);
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

//    System.out.print(type + " " + bookTable);

%>