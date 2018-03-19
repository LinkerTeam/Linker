package com.linker.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.linker.domain.MemberVO;

import com.linker.service.MemberService;

/*
 * memberController와 연결된 view: 멤버 추가(memberAdd).jsp, 이메일 확인(emailConfirm).jsp, 팀 목록 출력(teamList).jsp 출력 
 * teamController와 연결되 DB: team_has_user, user, team
 * 
 * [memberAdd.jsp]
 * 1. user가 멤버 추가 창에서 팀에 초대할 user의 eamil을 입력한다. 단, 초대할 user는 가입된 회원만 가능하다.
 * 2. 초대 버튼을 누른다.
 * 3. DB team_has_user 데이터가 추가 되면서 teamList.jsp로 화면이 전환된다.
 * 	3-1. 아직은 초대받은 user는 팀의 멤버가 아니다.
 * 		초대받은 user가 mail인증을 완료하면 DB team_has_user에 데이터가 입력된다. status : 0
 * 		그 전까지는 초대받은 user는 팀의 멤버가 아니다.
 * 
 * [emailConfirm.jsp]
 * 1. 초대받은 user가 자신의 email로 전송된 메일 인증의 하이퍼링크를 클릭한다.
 * 2. emailConfirm.jsp로 이동한다. DB team_has_user의 status : 1 로 데이터가 수정되면서 멤버초대가 완료됨.
 * 3. 'Linker 사이트 바로가기'버튼을 클릭한다. 로그인 창으로 이동한다.
 * */

@Controller
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	//멤버 추가와 관련된 서비스.
	@Inject
	private MemberService service;

	//로그인과 연결하기 전, 임시로 u_id, t_id를 지정함.
	int u_id=11;//userID
	int t_id=105;//teamID
	
	//멤버 추가(memberAdd).jsp 가져오기 [해설 : memberAdd.jsp 1.]
	@RequestMapping(value="/member/memberAdd", method=RequestMethod.GET)
	public void memberAddGET(MemberVO vo, Model model) throws Exception{
		vo.setU_id(11);
//		logger.info("memberAddGET start.");
		//해당 user가 속한 특정 팀의 정보를 가져온다.
		vo=service.userHasTeamUid(11,t_id); //service의 결과를 vo변수에 넣음
//		logger.info("memberAdd page is open......" + vo.toString());
		model.addAttribute(vo);
		
	}
	
	//멤버 추가(memberAdd).jsp에서 '초대' 버튼을 눌렀을 때, 데이터가 전송되면서 화면 전환 [해설 : memberAdd.jsp 2.]
	@RequestMapping(value="/member/memberAdd", method=RequestMethod.POST)
	public String memberAddPOST(MemberVO vo, Model model,  RedirectAttributes rttr) throws Exception{
//		logger.info("초대유저의 이메일, t_id : " + vo.toString());
		//memberAdd.jsp에 입력된 초대받으려는 user의 정보를 가져온다.
		MemberVO vo2=service.userEmail(vo.getEmail());
		vo2.setT_id(t_id);
		vo2.setEmail(vo.getEmail());
//		logger.info("초대유저 정보 : " + vo2.toString());
		//해당 팀에 이미 초대하려는 user가 있으면 logger를 출력. 없으면 create함수 실행함.
		if(service.userHasTeamEmail(vo2.getEmail(), t_id) == null) {
//			logger.info("해당 유저는 team에 없음.");
			//초대하려는 user에게 인증 메일을 전송. DB team_has_user에 status값이 0인 데이터를 생성 
			service.create(vo2);
			rttr.addFlashAttribute(model);
		}else{
			logger.info("해당 team에 멤버임.");
		}

		return "redirect:/team/teamList";
	}

	//초대받은 user가 메일에서 하이퍼링크를 누르면 뜨는 창(emailConfirm).jsp [해설 : emailConfirm.jsp 1.]
	@RequestMapping(value="/emailConfirm",method=RequestMethod.GET)
	public String emailConfirmGET(String email, MemberVO vo, Model model) throws Exception{
//		logger.info("emailConfirm에 들어온 데이터 vo : " + vo);
		//memberAdd.jsp에 입력된 초대받으려는 user의 정보를 가져온다.
		MemberVO vo2=service.userEmail(vo.getEmail());
		vo2.setT_id(t_id);
		//초대받은 유저의 status 값을 1로 수정.
		service.modifyStatus(vo2.getU_id(), vo2.getT_id());
//		logger.info("service 인증코드 수정 완료." +vo2);
		MemberVO vo3=service.userHasTeamEmail(vo.getEmail(), vo2.getT_id());
//		logger.info("service teamName가져오기." +vo3);
		model.addAttribute("vo3", vo3);
		return "/emailConfirm";
	}

}
