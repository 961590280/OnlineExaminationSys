package com.cw.oes.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import sun.misc.BASE64Decoder;

/**
 * 考试监考视频流工具类
 * @author CW
 *
 */
public class ExamVideoStreamUtil {
	private static final String PROPERTIES_URL = "conf/path.properties"; //配置文件路径
	public static final String VIDEOS_PATH ;//视频流文件路径
	//从配置文件读取配置的路径赋值给类静态常量
	static{
		String path = ExamVideoStreamUtil.class.getResource("/").getPath();
		String websiteURL = (path.replace("/build/classes", "")
						.replace("%20"," ").replace("classes/", "") + PROPERTIES_URL);
		System.out.println(websiteURL);
		Map map  = PropertiesUtil.parseToMap(websiteURL);
		if(map.get("path.examvideo") == null){
			VIDEOS_PATH = "";
			System.out.println(VIDEOS_PATH);
		}else{
			VIDEOS_PATH = map.get("path.examvideo").toString();
			System.out.println(VIDEOS_PATH);
			File f = new File(VIDEOS_PATH);
			f.mkdirs();
		}
	}
	
	
	//输出数据到文件
	public static void outStream(OutputStream out,String data){
		try {
			out.write(data.getBytes());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public static void stream2Movie(String fileName){
		FileReader fr = null;
		char[] cbuf = new char[1024];	//文件字符数据
		
		int i = 0;
		int splitIndex = 0;
		StringBuffer strBuf = new StringBuffer();
		try {
			fr = new FileReader(fileName);
			
			i = fr.read(cbuf);
			strBuf.append(cbuf, 0, i);
			List<byte[]> list = new ArrayList<byte[]>();
			BASE64Decoder decoder = new BASE64Decoder();
			
			while((i = fr.read(cbuf))!=-1){
				strBuf.append(cbuf);
				splitIndex = strBuf.lastIndexOf("data");
				
				if(splitIndex != -1 && splitIndex != 0){//当存在两个data则把前一个图片的64base数据转为2进制
					String data = strBuf.substring(0, splitIndex);
					/*System.out.println(data);*/
					
					byte[] decodedBytes = decoder.decodeBuffer(data);
					list.add(decodedBytes);
					strBuf.delete(0, splitIndex);
					
				}
			}
			
			if(strBuf.length()>0){
				/*System.out.println("最后");*/
				byte[] decodedBytes = decoder.decodeBuffer(strBuf.toString());
				list.add(decodedBytes);
			}
			
			/*for(byte[] e : list){
				System.out.println("1");
			}*/
			
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				fr.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}
	
	public static void main(String[] args) {
		stream2Movie("E:/oes/examVideo/1/f70df9fb-999f-11e5-9c24-a73720f984a5.oes");
	}
}
