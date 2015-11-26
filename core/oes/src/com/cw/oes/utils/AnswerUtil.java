package com.cw.oes.utils;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import com.baidu.channel.test.temp;

public class AnswerUtil {
	/**
	 * 将字符串转为map
	 * @param answerMap
	 * @return
	 */
	public static String coverIntoString(Map answerMap){
		Set<String> keys = answerMap.keySet();
		StringBuilder answer = new StringBuilder();
		for(String key : keys){
			answer.append(key);	
			answer.append(":");
			answer.append(answerMap.get(key)==null?"null":answerMap.get(key));
			answer.append("|");
			
		}
		answer.deleteCharAt(answer.length()-1);
		
		System.out.println(answer.toString());
		
		return answer.toString();
	}
	/**
	 * 字符串转为map
	 * @param answerStr
	 * @return
	 */
	public static Map coverIntoMap(String answerStr){
		Map answer =new HashMap<String, Object>(); 
		
		String[] strArr = answerStr.split("\\|");
		if(strArr.length<1){
			return null;
		}
		
		
		for(String str : strArr){
			String[] tempArr = str.split(":");
			answer.put(tempArr[0], tempArr[1]);
		}
		
		return answer;
		
	}
	
	public static void main(String[] args) {
//		String str="";
//		String[] strArr =str.split("|");
//		
//		for(String str : strArr){
//			String[] tempArr = str.split(":");
//			answer.put(tempArr[0], tempArr[1]);
//		}
	}

}
