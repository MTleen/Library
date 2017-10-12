package dao;

import java.io.Serializable;
import java.sql.*;

/**
 * Created by HuShengxiang on 08/10/2017.
 */
public class Connector implements Serializable{
    private Connection conn;
    private PreparedStatement ptmt;
    public Connection getConn(){
        return conn;
    }
    public void connect(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Library?user=root&password=123&useUnicode=true&characterEncoding=UTF8");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public ResultSet query(String sql){
        try {
            ptmt = conn.prepareStatement(sql);
            return ptmt.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public void closeConn(){
        try {
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public static void main(String[] args){
        Connector connector = new Connector();
        connector.connect();
        ResultSet rs = connector.query("select writer from books");
        try {
            if(rs.next()){
                String str = rs.getString(1);
                System.out.print(str);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
