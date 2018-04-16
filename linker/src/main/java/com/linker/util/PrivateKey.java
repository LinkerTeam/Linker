package com.linker.util;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
//aws s3를 보안하기위해서 만들 클래스
public class PrivateKey{			
	private String accessKey;
	private String secretKey;
	PrivateKey(){
		try{
			String key = readFile("c:\\zzz\\PrivateKey.txt");
			accessKey = key.substring(0, 20);
			secretKey = key.substring(22);
			System.out.println(accessKey);
			System.out.println(secretKey);
		}catch(Exception e){
			e.printStackTrace();
		}		
	}
	
	public String getAccessKey() {
		return accessKey;
	}
	public void setAccessKey(String accessKey) {
		this.accessKey = accessKey;
	}
	public String getSecretKey() {
		return secretKey;
	}
	public void setSecretKey(String secretKey) {
		this.secretKey = secretKey;
	}
	
	@Override
	public String toString() {
		return "PrivateKey [accessKey=" + accessKey + ", secretKey=" + secretKey + "]";
	}
	//텍스트 파일 가져오기
	private String readFile(String file) throws IOException {
	    BufferedReader reader = new BufferedReader(new FileReader (file));
	    String         line = null;
	    StringBuilder  stringBuilder = new StringBuilder();
	    String         ls = System.getProperty("line.separator");

	    try {
	        while((line = reader.readLine()) != null) {
	            stringBuilder.append(line);
	            stringBuilder.append(ls);
	        }

	        return stringBuilder.toString();
	    } finally {
	        reader.close();
	    }
	}
}