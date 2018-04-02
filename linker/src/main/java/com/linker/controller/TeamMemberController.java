package com.linker.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.linker.domain.TeamMemberVO;

import com.linker.service.TeamMemberService;
import com.linker.service.TeamService;

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
public class TeamMemberController {

	private static final Logger logger = LoggerFactory.getLogger(TeamMemberController.class);
	
	//멤버 추가와 관련된 서비스.
	@Inject
	private TeamMemberService memberservice;
	
	//팀 목록과 관련된 서비스.
	@Inject
	private TeamService teamService;

	//로그인과 연결하기 전, 임시로 u_id, t_id를 지정함.
	int u_id=2;//userID

	//멤버 중복 체크 + 멤버 추가 + 메일 전송
	@RequestMapping(value="/team/teamList/{t_id}", method=RequestMethod.POST)
	public @ResponseBody ResponseEntity<String> memberAddPOST(@RequestBody TeamMemberVO vo, @PathVariable int t_id , Model model) throws Exception{		
		ResponseEntity<String> entity = null;
		try {
			logger.info("email" + vo.getEmail());
			logger.info("t_id" + t_id);
			logger.info("memberAddPOST start.");
			logger.info("memberAdd post vo 값 : " + vo.toString());
			logger.info("controller : " + vo.getEmail() + ", " + t_id);

			//초대이메일이 이미 팀원에 속해있는지 검사한다.
			int resultNum=memberservice.checkMember(vo.getEmail(), t_id);
			System.out.println("checkMember 결과 값 : " + memberservice.checkMember(vo.getEmail(), t_id));
		
			if(resultNum == 1) {
				//email에 관련된 u_id 정보를 찾아 새로 생성
				logger.info("팀원이 등록되지 않았습니다. 사용이 가능합니다.");
				memberservice.create(vo.getEmail(), t_id);
				
				model.addAttribute("teamList",teamService.listTeam(u_id));
				logger.info("step1");
				//user가 속한 모든 팀의 멤버들을 조회하는 함수를 'memberList'이름으로 정하고 teamList.jsp로 넘김
				model.addAttribute("memberList", memberservice.TeamHasUsers(u_id));
				logger.info("step2");
				entity = new ResponseEntity<String>("true", HttpStatus.OK);
			}else{
				logger.info("해당 이메일은 이미 팀원이 되어 있거나 이미 초대 메일이 발송된 회원입니다. 다시 한번 확인해 주세요.");
				entity = new ResponseEntity<String>("false", HttpStatus.OK);
			}
		}catch(Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//초대받은 user가 메일에서 하이퍼링크를 누르면 뜨는 창(emailConfirm).jsp [해설 : emailConfirm.jsp 1.]
	@RequestMapping(value="/emailConfirm",method=RequestMethod.GET)
	public void emailConfirmGET(String name, TeamMemberVO vo, Model model) throws Exception{
		logger.info("emailConfirm에 들어온 데이터 vo : " + vo);
//		logger.info("t_id : " + name);
		//memberAdd.jsp에 입력된 초대받으려는 user의 정보를 가져온다.
//		TeamMemberVO vo2=memberservice.userEmail(vo.getEmail());
//		logger.info("vo2 xz: " + vo2);
		//vo2.setT_id(t_id);
		
		//초대받은 유저의 status 값을 1로 수정.
//		memberservice.modifyStatus(vo2.getU_id(), vo2.getT_id());
//		//logger.info("service 인증코드 수정 완료." +vo2);
//		TeamMemberVO vo3=memberservice.userHasTeamEmail(vo.getEmail(), vo2.getT_id());
//		logger.info("service teamName가져오기." +vo3);
//		model.addAttribute(vo3);
	}
}