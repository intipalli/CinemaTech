package com.uga.mbs;
import java.security.MessageDigest;
import java.util.Arrays;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class Security {
	private  byte[] key;

		
	private  SecretKeySpec sk;

	  public  void setKey(String k) {
	    MessageDigest sh = null;
	    try {
	      key = k.getBytes("UTF-8");
	      sh = MessageDigest.getInstance("SHA-1");
	      key = sh.digest(key);
	      key = Arrays.copyOf(key, 16);
	      sk = new SecretKeySpec(key, "AES");
	    } catch (Exception e) {
	    	System.out.println(e.getMessage());
	    }
	  }
	  
	  public String decrypt( String str,  String sec) {
		    try {
		      setKey(sec);
		      Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5PADDING");
		      cipher.init(Cipher.DECRYPT_MODE, sk);
		      return new String(cipher.doFinal(Base64.getDecoder()
		        .decode(str)));
		    } catch (Exception e) {
		      System.out.println("decrypt error: " + e.getMessage());
		    }
		    return null;
		  }

	  public String encrypt( String str,  String sec) {
	    try {
	      setKey(sec);
	      Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
	      cipher.init(Cipher.ENCRYPT_MODE, sk);
	      return Base64.getEncoder()
	        .encodeToString(cipher.doFinal(str.getBytes("UTF-8")));
	    } catch (Exception e) {
	      System.out.println("encrypt error: " + e.getMessage());
	    }
	    return null;
	  }

	 
}
