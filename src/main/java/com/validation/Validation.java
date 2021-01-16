package com.validation;

import java.awt.event.KeyEvent;
import java.util.regex.Matcher;
import java.util.regex.Pattern;



public class Validation {

	
	static boolean flag;
	
	public static boolean validateNull(String st){
		
		flag = false;
		
	
		if(st != null && !st.isEmpty()){
			flag = true;
		}
		else{
			flag = false;
		}
		
		return flag;
	}
	
	public static boolean validateNumber(String num){
		
		flag=false;
		
		 for (int n = num.length(); n > 0; n--) {

	            char c = num.charAt(n - 1);
	            
	            if (Character.isDigit(c)) {
                          flag = true;
	            }else{
	                      flag = false;	               
	            }
	  }
		
	   return flag;
			
	}
	
	
	
	public static boolean validateChar(String st){
		
		flag=false;
		
		 for (int n = st.length(); n > 0; n--) {

	            char c = st.charAt(n - 1);

	            
	            if (Character.isLetter(c) || c == KeyEvent.VK_SPACE) {

	               flag = true;

	            } else {

	                      flag = false;	               
	            }
	  }
		
	   return flag;
			
	}
	
	
	
	
	public static boolean validateEmail(String st){
		
		flag=false;
		
		 Pattern regexPattern = Pattern.compile("^[(a-zA-Z-0-9-\\_\\+\\.)]+@[(a-z-A-z)]+\\.[(a-zA-z)]{2,3}$");
	     Matcher regMatcher   = regexPattern.matcher(st);

	    if(regMatcher.matches()){
	        
	   
	               flag = true;

	            } else {

	                      flag = false;	               
	            }
	
		
	   return flag;
			
	}
	
	
	
	
	
	
	
	
}
