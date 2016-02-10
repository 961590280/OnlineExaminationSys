package com.cw.oes.security;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordMD5 {
	public static String passwordEncrypt(String password) {  
       
        return MD5.getMD5Str(password);  
    }  
	
  
    public static void main(String[] args) {  
        System.out.println(PasswordMD5.passwordEncrypt("cw123456"));  
    }  
}
