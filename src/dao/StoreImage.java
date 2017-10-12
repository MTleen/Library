package dao;

import sun.org.mozilla.javascript.internal.EcmaError;

import java.sql.*;
import java.io.*;
/**
 * Created by HuShengxiang on 08/10/2017.
 */
public class StoreImage {
    public boolean storeImage(Connection conn ,String strFile) throws Exception{
        boolean written = false;
        if(conn == null){
            written = false;
        }else {
            int id = 0;
            File file = new File(strFile);
            System.out.print(file.length());
            FileInputStream fis = new FileInputStream(file);
            //拿到pic的最大的id
            PreparedStatement ps = conn.prepareStatement("SELECT MAX(id) from books");
            ResultSet rs = ps.executeQuery();
            if(rs != null){
                while (rs.next()){
                    id = rs.getInt(1) + 1;
                }
            }else {
                return written;
            }

            ps = conn.prepareStatement("INSERT INTO books (id, cover) VALUES (?,?);");
            ps.setInt(1, id);
            ps.setBinaryStream(2, fis, file.length());
            ps.executeUpdate();

            written = true;
        }
        return written;
    }
    public static void main(String[] args) throws Exception{
        Connector connector = new Connector();
        connector.connect();
        StoreImage si = new StoreImage();

        si.storeImage(connector.getConn(), "/Users/HuShengxiang/Documents/GitHub/WebProject/Library/web/images/Bhaktapur_Bells.jpg");
    }
}
