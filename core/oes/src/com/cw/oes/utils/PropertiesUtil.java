package com.cw.oes.utils;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;

public class PropertiesUtil {
	public static Map parseToMap(String url){
		Properties properties = new Properties();
		FileInputStream fileInputStream = null;
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		try {
			fileInputStream = new FileInputStream(url);
			properties.load(fileInputStream);
			Iterator iterator = properties.entrySet().iterator();
			
			
			while(iterator.hasNext()){
				Entry entry =  (Entry) iterator.next();
				map.put(entry.getKey().toString(), entry.getValue());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				fileInputStream.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		
		return map;
	}
}
