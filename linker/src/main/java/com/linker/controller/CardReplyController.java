package com.linker.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.linker.domain.CardReplyVO;
import com.linker.service.CardReplyService;

@RestController
@RequestMapping("/board/reply")
public class CardReplyController {

	@Inject
	private CardReplyService service;
	
	//특정 카드의 모든 댓글 조회
	@RequestMapping(value = "/all/{c_id}", method = RequestMethod.GET)
	public ResponseEntity<List<CardReplyVO>> listReply(@PathVariable("c_id") Integer c_id) throws Exception{
		ResponseEntity<List<CardReplyVO>> entity = null;
		
		CardReplyVO vo = new CardReplyVO();
		vo.setC_id(c_id);
		
		try {
			entity = new ResponseEntity<>(service.listReply(c_id), HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//등록
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> addReply(HttpServletRequest request, @RequestBody CardReplyVO vo){
		ResponseEntity<String> entity = null;
		
		try {
			service.addReply(vo);
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//수정
	@RequestMapping(value = "/{id}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> updateReply(@PathVariable("id") Integer id, @RequestBody CardReplyVO vo){
		ResponseEntity<String> entity = null;
		
		try {
			vo.setId(id);
			service.modifyReply(vo);
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//삭제
	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public ResponseEntity<String> removeReply(@PathVariable("id") Integer id){
		ResponseEntity<String> entity = null;
		
		try {
			service.removeReply(id);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
