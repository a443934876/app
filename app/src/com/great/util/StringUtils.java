package com.great.util;

public class StringUtils {

	
	public static boolean isEmpty(Object obj){
		if(obj==null){
			return true;
		}
		if(obj instanceof String){
			return (((String) obj).length() == 0);
		}
		return true;
	}
	
	public static boolean isNotEmpty(Object object){
		return !isEmpty(object);
	}
}
