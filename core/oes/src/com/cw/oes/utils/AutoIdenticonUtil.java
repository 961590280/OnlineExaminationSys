package com.cw.oes.utils;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;

import javax.imageio.ImageIO;

import com.cw.oes.security.MD5;
import com.cw.oes.security.PasswordMD5;
import com.cw.oes.utils.identicon.Identicon;

/**
 * 根据邮箱自动生成用户头像
 * @author CW
 *
 */
public class AutoIdenticonUtil {
	/**
	 * 生成并保存头像
	 * @param email
	 * @return
	 */
	public  boolean createAndSave(String email,String fileName){
		
		try {
			Identicon iden = new Identicon();
			String hash = MD5.getMD5Str(email);
			String filePath = this.getClass().getResource("").toURI().getPath();
			System.out.println(filePath);
			filePath = filePath.substring(0, filePath.indexOf("classes"))+"/res/personal-img/";
			System.out.println(filePath);
			
			BufferedImage img =  iden.create(hash, 256);
			ImageIO.write(img, "png", new File(filePath+fileName));
		}  catch (URISyntaxException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}  
		return true;
	}
	public static void main(String[] args) {
		AutoIdenticonUtil iden = new AutoIdenticonUtil();
		iden.createAndSave("961590280", "961590280");
	}
}
