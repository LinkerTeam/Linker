package com.linker.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.linker.domain.CardVO;
import com.linker.dto.CardDTO;
import com.linker.service.CardService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class CardListTestController {
	
	private static final Logger logger = LoggerFactory.getLogger(CardListTestController.class);
	
	@Inject
	private CardService service;
	
	
	@RequestMapping(value="/cardHeader", method=RequestMethod.GET)
	public void ajaxTest() {
		
	};
}