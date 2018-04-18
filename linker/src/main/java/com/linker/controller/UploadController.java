package com.linker.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.linker.domain.CardAttachVO;
import com.linker.service.CardService;
import com.linker.util.MediaUtils;
import com.linker.util.S3Util;
import com.linker.util.UploadFileUtils;

@RequestMapping("/board")
@Controller
public class UploadController {
	private static final Logger logger = LoggerFactory.getLogger(UploadController.class);
	
	
	@Inject
	CardService service;
	
	//파일 저장 경로 (S3)
	String uploadpath = "linker/uploadFile";
	S3Util s3 = new S3Util();
	String bucketName = "linkers104";
	
	
	//조회
	@ResponseBody
	@RequestMapping(value = "/{p_id}/card/{c_id}/allAttach", method = RequestMethod.GET)
	public ResponseEntity<List<CardAttachVO>> allAttach(@PathVariable("p_id") Integer p_id, @PathVariable("c_id") Integer c_id) throws Exception {
		ResponseEntity<List<CardAttachVO>> entity = null;

		CardAttachVO vo = new CardAttachVO();
		vo.setC_id(c_id);
		
		try {
			entity = new ResponseEntity<>(service.allAttach(c_id), HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	//파일 업로드
	@ResponseBody
	@RequestMapping(value = "/{p_id}/card/{c_id}/addAttach", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8") //produces: 한국어로 전송하기 위한 설정
	public ResponseEntity<String> uploadAjax(@PathVariable("c_id") Integer c_id, MultipartFile file) throws Exception {
		
		String fileName = UploadFileUtils.uploadFile(uploadpath, file.getOriginalFilename(), file.getBytes());
		CardAttachVO vo = new CardAttachVO();
		vo.setC_id(c_id);
		vo.setFile(fileName);
		vo.setSize(file.getSize());
		
		// 등록 요청 결과를 view에 반환해주는 객체
		ResponseEntity<String> entity = null;

		try {
			// 데이터베이스에 첨부파일 등록 요청
			service.addAttach(vo);
			// 등록된 파일명을 반환
			entity = new ResponseEntity<>(fileName, HttpStatus.OK); 
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	//삭제
	@ResponseBody
	@RequestMapping(value = "/deleteAttach", method = RequestMethod.POST)
	public ResponseEntity<String> deleteAttach(String fileName){
		
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
		
		MediaType mType = MediaUtils.getMediaType(formatName);
		
		if(mType != null) {
			String front = fileName.substring(0, 12);
			String end = fileName.substring(14);
			new File(uploadpath + (front + end).replace('/', File.separatorChar)).delete();
		}
		
		new File(uploadpath + fileName.replace('/', File.separatorChar)).delete();
		
		// 삭제 요청 결과를 view에 반환해주는 객체
		ResponseEntity<String> entity = null;

		try {
			// 데이터베이스에 첨부파일 삭제 요청
			service.deleteAttach(fileName);
			entity = new ResponseEntity<>("DELETED", HttpStatus.OK); 
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
}
