package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by HuShengxiang on 12/10/2017.
 */
public class GetBooks {
    private Connection conn;
    private ResultSet rs;
    private PreparedStatement ps;
    private String sql;
    public void setConn(Connection conn){
        this.conn = conn;
    }
    public ResultSet getBooks(String table, int bookType){
        try {
            ps = conn.prepareStatement("SELECT * FROM " + table + " WHERE type=" + bookType);
            rs = ps.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }
}
