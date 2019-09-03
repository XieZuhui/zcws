package cn.zcw.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class StringUtil {

	public static boolean isEmpty( String content ) {
		return content == null || "".equals(content.trim());
	}
	
	public static boolean isNotEmpty( String content ) {
		return !isEmpty(content);
	}

	 /* @param date 日期对象
	 * @param format 字符格式
	 * @return 转换后的字符串
	 */
	public static String format(Date date, String format) {
		SimpleDateFormat sdf  = new SimpleDateFormat(format);
		return sdf.format(date);
	}
	/**
	 * 返回相同当前时间
	 * @return 返回的字符串格式是 yyyy-MM-dd HH:mm:ss
	 */
	public static String getSystemTime() {
		return format(new Date(),"yyyy-MM-dd HH:mm:ss");
	}
}
