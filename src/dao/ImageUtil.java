package dao;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;

/**
 * Created by HuShengxiang on 08/10/2017.
 */
public class ImageUtil {
    //��ȡ����ͼƬ��ȡ������
    public static FileInputStream readImage(String path) throws Exception{
        return new FileInputStream(new File(path));
    }

    //��ȡ���ݿ����ͼƬ��ȡ�����
    public static void readBin2Image(InputStream in, String targetPath){
        File file = new File(targetPath);
        String path = targetPath.substring(0, targetPath.lastIndexOf("/"));
        if(!file.exists()){
            new File(path).mkdir();
        }
        FileOutputStream fos = null;
        try {
            fos = new FileOutputStream(file);
            int len = 0;
            byte[] buf = new byte[1024*1024*5];
            while ((len = in.read(buf)) != -1) {
                fos.write(buf, 0, len);
            }
            fos.flush();
            fos.close();
        }catch (Exception e){

        }
    }
}
