package cn.zcw.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
/**
 * 文件上传工具类
 * @author fujiansheng
 */
public class UploadUtil {

    /**
     * 文件上传工具方法
     * @param request
     * @return
     */
    public static boolean upload(HttpServletRequest request) {
        String fileName ="";
        String path ="";
        String fileType ="";
        long size =0;
        try {
            request.setCharacterEncoding("UTf-8");
            // 获取项目的路径
            path =request.getContextPath();
            // 第一步声明diskfileitemfactory工厂类，用于在指的磁盘上设置一个临时目录
            DiskFileItemFactory disk = new DiskFileItemFactory(1024 * 10, new File("D:/temp"));
            // 第二步：声明ServletFileUpoload，接收上面的临时目录
            ServletFileUpload up = new ServletFileUpload(disk);
            // 第三步：解析request
            List<FileItem> list = up.parseRequest(request);
            for (int i = 0; i < list.size(); i++) {
                FileItem fileItem = list.get(i);
                if(!fileItem.isFormField()) {
                    // 如果就一个文件
                    FileItem file = list.get(i);
                    // 获取文件名,带路径
                    fileName = file.getName();
                    fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
                    //文件重命名 和 文件路径按hash算法拆分 调用工具类
                    String fileUUIDName = FileUtils.makeFileName(fileName);
                    String saveDir = FileUtils.fileSave(fileUUIDName, path);
                    // 获取文件的类型
                    fileType = file.getContentType();
                    // 获取文件的字节码
                    InputStream in = file.getInputStream();
                    // 声明输出字节流
                    OutputStream out = new FileOutputStream(saveDir+ "/" + fileName);
                    // 文件copy
                    byte[] b = new byte[1024];
                    int len = 0;
                    while ((len = in.read(b)) != -1) {
                        out.write(b, 0, len);
                    }
                    out.close();
                    size = file.getInputStream().available();
                    // 删除上传的临时文件
                    file.delete();
                }
            }
            // 显示数据
            //response.setContentType("text/html;charset=UTf-8");
            //PrintWriter op = response.getWriter();
            System.out.println("文件上传成功<br/>文件名:" + fileName);
            System.out.println("<br/>文件类型:" + fileType);
            System.out.println("<br/>文件大小（bytes）" + size);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("文件上传失败！<br/>文件名:" + fileName);
        }
        return false;
    }


    /**
     * 文件上传工具方法
     * @param request
     * @return
     */
    public static Map<String, String> upload2(HttpServletRequest request) {
        String fileName ="";
        String path ="";
        String fileType ="";
        long size =0;
        Map<String, String> map = new HashMap<String, String>();
        try {
            request.setCharacterEncoding("UTf-8");
            // 获取项目的路径
            path =request.getSession().getServletContext().getRealPath("/upload");
            // 第一步声明diskfileitemfactory工厂类，用于在指的磁盘上设置一个临时目录
            DiskFileItemFactory disk = new DiskFileItemFactory(1024 * 10, new File("F:/javaIO"));
            // 第二步：声明ServletFileUpoload，接收上面的临时目录
            ServletFileUpload up = new ServletFileUpload(disk);
            // 第三步：解析request
            //Map map1 = request.getParameterMap();
            List<FileItem> list = up.parseRequest(request);
            System.out.println("List<FileItem> list:"+list.size());
            for (int i = 0; i < list.size(); i++) {
                FileItem fileItem = list.get(i);
                if(fileItem.isFormField()){
                    String key = fileItem.getFieldName();
                    String value = fileItem.getString();
                    value = new String(value.getBytes("iso-8859-1"),"Utf-8");

                    System.out.println(key+":"+value);
                    map.put(key, value);
                }else {
                    // 如果就一个文件
                    FileItem file = list.get(i);
                    // 获取文件名,带路径
                    fileName = file.getName();
                    fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
                    //文件重命名 和 文件路径按hash算法拆分 调用工具类
                    String fileUUIDName = FileUtils.makeFileName(fileName);
                    String saveDir = FileUtils.fileSave(fileUUIDName, path);
                    // 获取文件的类型
                    fileType = file.getContentType();
                    // 获取文件的字节码
                    InputStream in = file.getInputStream();
                    // 声明输出字节流
                    OutputStream out = new FileOutputStream(saveDir + "/" + fileName);     // 保存上传提交的文件地址
                    String key = fileItem.getFieldName();
                    String s = saveDir + "/" + fileName;
                    int begin=s.indexOf("\\upload");
                    int last=s.length();
                    System.out.println("=========================\n"+s.substring(begin,last));
                    StringBuilder saveValue = new StringBuilder("..");
                    saveValue.append(s.substring(begin,last));
                    String value = saveValue.toString();
                    value.replaceAll("\\\\","/");
                    value = new String(value.getBytes("iso-8859-1"),"Utf-8");

                    map.put(key, value);
                    // 文件copy
                    byte[] b = new byte[1024];
                    int len = 0;
                    while ((len = in.read(b)) != -1) {
                        out.write(b, 0, len);
                    }
                    out.close();
                    size = file.getInputStream().available();
                    // 删除上传的临时文件
                    file.delete();
                }
            }
            // 显示数据
            //response.setContentType("text/html;charset=UTf-8");
            //PrintWriter op = response.getWriter();
            System.out.println("文件上传成功<br/>文件名:" + fileName);
            System.out.println("<br/>文件类型:" + fileType);
            System.out.println("<br/>文件大小（bytes）" + size);
            map.put("isUpload", "true");
            return map;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("文件上传失败！<br/>文件名:" + fileName);
        }
        return null;
    }
}