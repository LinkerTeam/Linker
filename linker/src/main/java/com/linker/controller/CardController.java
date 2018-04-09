package com.linker.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.linker.domain.CardVO;
import com.linker.service.CardService;

@RestController
@RequestMapping("/board")
public class CardController{
	
	@Inject
	private CardService service;

	
	//카드 등록 처리
	@RequestMapping(value = "/{p_id}/card", method = RequestMethod.POST)
	public ResponseEntity<Integer> createCard(@RequestBody CardVO vo){
		
		//새로운 카드 등록하는 데에 실패하면 예외 원인 메시지 전송,
		//사용자에게 BAD_REQUEST(400) 전송하도록.
		ResponseEntity<Integer> entity = null;
		try {
			service.createCard(vo);
			
			entity = new ResponseEntity<Integer>(vo.getId(), HttpStatus.OK); //성공하면 id값을 던져준다.
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	//카드 수정 처리 (제목, 내용)
	@RequestMapping(value="/{p_id}/card/{id}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> updateCard(@PathVariable("id") Integer id, @RequestBody CardVO vo){
		ResponseEntity<String> entity = null;
		try {
			vo.setId(id);
			service.updateCard(vo);
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	//카드 수정 처리 (상태)
	@RequestMapping(value="/{p_id}/cardStatus/{id}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<CardVO> updateCardStatus(@PathVariable("p_id") Integer p_id, @PathVariable("id") Integer id, @RequestBody CardVO vo){
		ResponseEntity<CardVO> entity = null;
		try {
			service.readPopcard(vo);
			System.out.println("read : " + vo);
			vo.setP_id(p_id);
			vo.setId(id);
			service.updateCardStatus(vo);
			
			System.out.println("updata : " + vo);
			
			entity = new ResponseEntity<CardVO>(vo, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	//상태값에 따른 카드 조회 (보관, 가리기 탭에서 조회하는 카드 목록)
	@RequestMapping(value="/{p_id}/cards/{ps_id}", method = RequestMethod.GET)
	public ResponseEntity<List<CardVO>> listCard(@PathVariable("p_id") int p_id, @PathVariable("ps_id") int ps_id){
		ResponseEntity<List<CardVO>> entity = null;
		
		CardVO vo = new CardVO();
		vo.setP_id(p_id);
		vo.setPs_id(ps_id);
		
		try { 
			entity = new ResponseEntity<>(service.listCard(vo), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	//팝업 카드 조회 - 카드를 클릭하면 뜨는 팝업창에서 카드의 정보를 띄움.
	@RequestMapping(value = "/{p_id}/card/{id}", method = RequestMethod.GET)
	public ResponseEntity<CardVO> readPopcard(@PathVariable("p_id") int p_id, @PathVariable("id") int id){
		ResponseEntity<CardVO> entity = null;
		
		CardVO vo = new CardVO();
		vo.setP_id(p_id);
		vo.setId(id);
		
		try { 
			entity = new ResponseEntity<>(service.readPopcard(vo), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
}