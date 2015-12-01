package com.cw.oes.utils;

import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URISyntaxException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.UUID;

import sun.misc.BASE64Decoder;


public class ImgUtil {
	public String img64BaseSave(String data) throws URISyntaxException, IOException{
		FileOutputStream out = null;
		String fileName = null;
		try{
			String path = this.getClass().getResource("").toURI().getPath();
			path = path.substring(1, path.indexOf("classes"));
			
			
			String suffix = data.substring(data.indexOf("/")+1,data.indexOf(";"));
	
			data = data.split(",")[1];
			BASE64Decoder decoder = new BASE64Decoder();
			byte[] decodedBytes = decoder.decodeBuffer(data); 
			String filePath = path+"/res/personal-img/";
			fileName = UUID.randomUUID()+"."+suffix;
		
			out = new FileOutputStream(filePath+fileName);
			out.write(decodedBytes);
		}finally{
			out.close();
		}
		
		return fileName;
	}
}
