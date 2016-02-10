package com.cw.oes.utils.identicon;

import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.math.RoundingMode;

import javax.imageio.ImageIO;

import org.apache.commons.lang.StringUtils;

import com.cw.oes.security.MD5;
import com.cw.oes.security.PasswordMD5;
import com.cw.oes.utils.identicon.generator.IBaseGenartor;
import com.cw.oes.utils.identicon.generator.impl.DefaultGenerator;
import com.google.common.base.Preconditions;
import com.google.common.math.DoubleMath;



/**
 * Author: Bryant Hang
 * Date: 15/1/10
 * Time: 下午2:42
 */
public class Identicon {
    private IBaseGenartor genartor;

    public Identicon() {
        this.genartor = new DefaultGenerator();
    }

    public Identicon(IBaseGenartor genartor) {
        this.genartor = genartor;
    }

    public BufferedImage create(String hash, int size) {
        Preconditions.checkArgument(size > 0 && StringUtils.isNotBlank(hash));

        boolean[][] array = genartor.getBooleanValueArray(hash);


        int ratio = DoubleMath.roundToInt(size / 5.0, RoundingMode.HALF_UP);

        BufferedImage identicon = new BufferedImage(ratio * 5, ratio * 5, BufferedImage.TYPE_INT_ARGB);
        Graphics graphics = identicon.getGraphics();

        graphics.setColor(genartor.getBackgroundColor()); // 背景色
        graphics.fillRect(0, 0, identicon.getWidth(), identicon.getHeight());

        graphics.setColor(genartor.getForegroundColor()); // 图案前景色
        for (int i = 0; i < 6; i++) {
            for (int j = 0; j < 5; j++) {
                if (array[i][j]) {
                    graphics.fillRect(j * ratio, i * ratio, ratio, ratio);
                }
            }
        }
        
        return identicon;
    }
    
    public static void main(String[] args) {
		Identicon iden = new Identicon();
		String hash = MD5.getMD5Str("9615902801@qq.com");
		BufferedImage img =  iden.create(hash, 256);
		try {
			ImageIO.write(img, "png", new File("e:/" + hash + ".png"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
	}
}
