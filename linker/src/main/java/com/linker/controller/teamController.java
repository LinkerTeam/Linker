package com.linker.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

public class teamController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	
	@RequestMapping(value="/teamAdd", method=RequestMethod.GET)
	public String teamAdd(@ModelAttribute("model") Model model) {
		logger.info("teamAdd");
//		model.addAttribute(name);
		return "teamList";
	}
}
