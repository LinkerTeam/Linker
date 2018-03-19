package com.linker.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;

//파일 저장경로를 도와주는 클래스
public class UploadFileUtils {
	//static기능을 호출해서 파일을 업로드할수있게 한다.
    //별도의 데이터를 보관할필요가 없어서 static으로 선언
	// uploadPath는 저장경로 originalName은 파일명 filedata 파일 data
	public static String uploadFile(String uploadPath,String originalName,byte[] fileData) throws Exception{
      
		//이름앞에 붙일 랜덤의 이름을 만듬
	  UUID uid =UUID.randomUUID();
   	  
	  //파일명과 임의의 글자를 더해서 savedName으로 유니크한 파일명을 만듬.
   	  String savedName =uid.toString()+"_"+originalName;
   	  System.out.println("1:"+savedName);
   	  //저장될 경로 지정
   	  String savedPath=calcPath(uploadPath);
   	 System.out.println("2:"+savedPath);
   	  //내가 지정한 경로를 넣고 이름을 넣어서 새로운 File타입 객체를 만듬 이걸 copy()에 넣을 예정
   	  File target = new File(uploadPath+savedPath,savedName);
   	 System.out.println("3:"+target);
   	  //임시디렉토리에 저장된 파일을 내가 지정한 경로로 복사 것
   	  //Filecopytils은 STS에서 지원하는 클래스 copy는 static매소드 fileData는 임시디렉토리고 target은 내가 지정한 경로로 복사
   	  FileCopyUtils.copy(fileData, target);
   	  //fromatName은 원본파일의 확장자를 의미함. 이를 이용해서 MediaUtils 클래스의 getMediaType()을 이용해 이미지와 아닌 파일을 판별
   	  String formatName= originalName.substring(originalName.lastIndexOf(".")+1);
   	System.out.println("4:"+formatName);
   	  String uploadedFileName =null;
   	  
   	  //이미지파일인경우 썸네일 생성하는 그렇지않은경우는 makeIcon은통해 경ㄹ과를 만들어냄 
   	  if(MediaUtils.getMediaType(formatName)!=null) {
   		  uploadedFileName =makeThumbnail(uploadPath, savedPath, savedName);
   		  System.out.println("5:"+uploadedFileName);
   	  } else {
   		  uploadedFileName=makeIcon(uploadPath,savedPath,savedName);
   		  System.out.println("6:"+uploadedFileName);
   	  }
   	  
   	  
   	  
   	  return uploadedFileName;
		
	
	}
	//글자 잘라내는 매서드
	private static String makeIcon(String uploadPath,String path,String fileName) {
  	  String iconName= uploadPath+path+File.separator+fileName;
  	  
  	  return iconName.substring(uploadPath.length()).replace(File.separatorChar,'/');
    }
    
    //파일 설정 시간설정폴더 메서드 폴더를 반환함 
    public static String calcPath(String uploadPath) {
  	  Calendar cal = Calendar.getInstance();
  	  
  	  String yearPath = File.separator+cal.get(Calendar.YEAR);
  	    
  	  String monthPath = yearPath+File.separator+new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
  	  
  	  String datePath= monthPath+ File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
  	  
  	  makeDir(uploadPath,yearPath,monthPath,datePath);
  	  
  	 
  	  
  	  return datePath;
    }
    
    //이미지 파일이 아닌경우 파일을 처리하는 문자열
    public static void makeDir(String uploadPath,String... paths) {
  	  
  	  if(new File(uploadPath+ paths[paths.length-1]).exists()) {
  		  return ; 
  	  	}
  	  for(String path:paths) {
  		  File dirPath = new File(uploadPath,path);
  		  
  		  if(! dirPath.exists()) {
  			  dirPath.mkdirs();
  		  }
  	  }
    }
    
    //썸네일 이미지 생성하기 코드
    private static String makeThumbnail(String uploadPath,String path,String fileName)throws Exception{
  	  
  	  //BufferedImage는 실제 이미지가 아닌 메모리상의 이미지를 의미하는 객체
  	  //원본 파일을 메모리상으로 로딩하고 정해진 크기에 맞게 작은 이지지 파일에 원복이미지를 복사
  	  
  	  BufferedImage sourceImg= ImageIO.read(new File(uploadPath+path,fileName));
  	  //FIT_TO_HEIGHT,100은 썸네일 이미지 파일의 높이를 뒤에 지정된 100px로 동일하게 만들어주는 역할
  	  BufferedImage destImg=Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT,200);
  	  
  	  //썸네일 파일명에는 원본파일 이름에 's_'로 저장하도록 함
  	  String thumbnailName= uploadPath+path+File.separator+"s_"+fileName;
  	  
  	  File newFile = new File(thumbnailName);
  	    // 파일명확장자를 체크함 이미지타입인경우 썸네일생성
  	  String formatName= fileName.substring(fileName.lastIndexOf(".")+1);
  	   
  	  ImageIO.write(destImg, formatName.toUpperCase(),newFile);
  	  //메소드 리턴시 문자열을 치환하는 이유는 브라우저에서 윈도우의경로로 사용하는 \문자가 정상적인 경로로인식되지않기때문에 '/'로 치환해줌
  	  return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar,'/');
    }
	
	
}
