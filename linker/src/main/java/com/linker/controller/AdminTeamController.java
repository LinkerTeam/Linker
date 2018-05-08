package com.linker.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.linker.service.AdminTeamService;

@Controller
@RequestMapping("/admin")
public class AdminTeamController {

	private static final Logger logger = LoggerFactory.getLogger(AdminUserController.class);
	
	@Inject
	private AdminTeamService adminService;
	
	//모든 팀 조회
	@RequestMapping(value = "/teamList", method = RequestMethod.GET)
	public void allTeamList(Model model) throws Exception {
		model.addAttribute("allTeamList", adminService.allTeamList());
	}
}
