package dao;

import java.io.InputStream;
import java.security.spec.ECField;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Created by HuShengxiang on 08/10/2017.
 */
public class ImageDemo {
    //¶ÁÈ¡Êý¾Ý¿âÍ¼Æ¬
    public static void readBin2Image(){
        String targetPath = "/Users/HuShengxiang/Documents/GitHub/WebProject/Library/web/images/Bhaktapur_Bells2.jpg";
        Connector connector = new Connector();
        connector.connect();
        try {
            Connection conn = connector.getConn();
            String sql = "select cover from books where id=5";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                InputStream in = rs.getBinaryStream("cover");
                ImageUtil.readBin2Image(in, targetPath);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public static void main(String[] args){
        readBin2Image();
    }
}
