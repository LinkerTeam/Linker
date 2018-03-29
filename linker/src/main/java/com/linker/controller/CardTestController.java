package com.linker.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.linker.service.CardlistService;

@Controller
public class CardTestController {
	
	private static final Logger logger = LoggerFactory.getLogger(CardTestController.class);
	
	@Inject
	private CardlistService service;
	
	
	@RequestMapping(value="/cards/cardTest", method=RequestMethod.GET)
	public void ajaxTest() {
		
	};
}
