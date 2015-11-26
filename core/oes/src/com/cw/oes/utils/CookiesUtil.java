package com.cw.oes.utils;

import java.io.UnsupportedEncodingException;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class CookiesUtil {
	/**
	 * 基于base64方法对cookie进行加密
	 * @param userName 
	 * @param password
	 * @return
	 */
	public static String cookieEncryption(String userName,String password){
		
        String str = userName+","+password;
        for(int i = 0;i<10;i++){
        	 str = getBase64(str);
        }
        System.out.println(str);
        return str;  
	}
	/**
	 * 基于base64方法对cookie进行解密
	 * @param s 解密字符串
	 * @return
	 */
	public static String cookieDencryption(String str){
	
	   for(int i = 0;i<10;i++){
        str = getFromBase64(str).trim();
       }
	   System.out.println(str);
        return str;   
	}
	
	// base64方法加密  
    public static String getBase64(String str) {  
        byte[] b = null;  
        String s = null;  
        try {  
            b = str.getBytes("utf-8");  
        } catch (UnsupportedEncodingException e) {  
            e.printStackTrace();  
        }  
        if (b != null) {  
            s = new BASE64Encoder().encode(b);  
        }  
        return s;  
    }  
  
    // base64方法解密  
    public static String getFromBase64(String s) {
    	s = s.replaceAll(" ", "");//	去掉空格
        byte[] b = null;  
        String result = null;  
        if (s != null) {  
            BASE64Decoder decoder = new BASE64Decoder();  
            try {  
                b = decoder.decodeBuffer(s);  
                result = new String(b, "utf-8");  
            } catch (Exception e) {  
                e.printStackTrace();  
            }  
        }  
        return result;  
    }  
	
	public static void main(String[] args) {
		cookieDencryption("Vm0wd2QyVkhVWGhUV0docFVtMW9WRll3Wkc5WFJsbDNXa1JTVjAxWGVGWlZNakExVmpGS2RHVkliRmhoTWsweFZtMTRTMk14V25GVQ0KYkdScFVtdHdTVlpxU2pSWlYwMTVWR3RzYUEwS1VteHdjRll3V2tkTk1WcHlXa1JTVkUxc1NrbFdiWFJyWVVFd1MxVnRNVzlYVmxWMw0KVm10MFUxWnNjSHBXTWpGSFZqQXhWMk5HWkZWV2JGcFlXVlZGZDFNeGNGaGpSVXBRVlZRd09RMEs=");
	}

}
