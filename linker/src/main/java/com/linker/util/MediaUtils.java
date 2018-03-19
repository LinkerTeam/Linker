package com.linker.util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;


// 확장자를 가지고 이미지 타입인지 판단해주는 역할 클래스
//브라우저에서 파일을 다운로드할것인지 보여줄것인지 결정함
public class MediaUtils {

	private static Map<String,MediaType> mediaMap;
	
	static {
		mediaMap = new HashMap<String,MediaType>();
		mediaMap.put("JPG",MediaType.IMAGE_JPEG);
		mediaMap.put("GIF", MediaType.IMAGE_GIF);
		mediaMap.put("PNG", MediaType.IMAGE_PNG);
	}
	public static MediaType getMediaType(String type) {
		return mediaMap.get(type.toUpperCase());
	}
}
