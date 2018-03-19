package com.linker.controller;

import java.util.ArrayList;
import java.util.List;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.linker.domain.MemberVO;
import com.linker.domain.TeamVO;
import com.linker.service.MemberService;
import com.linker.service.TeamService;

/*
 * TeamController와 연결된 view: 팀 추가(teamAdd).jsp, 팀 목록 출력(teamList).jsp 출력
 * TeamController와 연결된 DB: team, team_has_user, user
 * 
 * [teamAdd.jsp]
 * 1. user가 팀 추가 창에서 새로 생성할 팀 이름을 입력한다.
 * 2. 입력 버튼을 누른다.
 * 3. DB team과 DB team_has_user 데이터가 추가 되면서 teamList.jsp로 화면이 전환된다.
 * 
 * [teamList.jsp]
 * 1. user가 속한 팀 목록이 출력된다. user의 해당 팀 권한이 0이라면,
 * 	팀 목록 옆에 '이름수정', '삭제', '멤버보기' 버튼이 보이고,
 * 	권한이 0이 아니라면 팀 목록 옆에 '멤버보기' 버튼이 보인다.
 * 2. 팀 목록 버튼의 기능
 * 	2-1.'이름수정'버튼을 누른 경우, 팀 이름이 수정된다.
 * 		2-1-1.'이름수정' 버튼을 누른다. 
 * 		2-1-2. 모달 창이 나타난다. 입력하는 텍스트와 '수정'버튼과 '취소'버튼이 있다. 수정할 이름을 입력한다.
 * 		2-1-3. '수정'버튼을 누른 경우, DB team(name)데이터가 수정되면서 리스트가 갱신된다.
 * 		2-1-4. '취소'버튼을 누른 경우, 모달 창은 사라진다.
 * 	2-2.'삭제'버튼을 누른 경우,팀원을 포함한 팀이 삭제된다.
 * 		2-2-1. '삭제' 버튼을 누른다.
 * 		2-2-2. 모달 창이 나타난다. '삭제'버튼과 '취소'버튼이 있다.
 * 		2-2-3. '삭제'버튼을 누른 경우, DB team 데이터가 삭제된다.
 * 		2-2-4. '취소 버튼을 누른 경우, 2-1-4 항과 같다.
 * 	2-3.'멤버보기'버튼을 누른 경우, 팀원 목록이 나타난다.
 * 		2-3-1. 선택한 팀의 밑 행에 팀에 속한 팀원들의 목록들이 나타난다. DB user의 해당 팀 권한이 0 또는 1이라면,
 * 				팀원 목록 옆에 '권한수정', '삭제' 버튼이 보이고,
 * 				궈한이 2라면 버튼이 없다.
 * 3. 멤버 목록 버튼의 기능
 * 	3-1. '권한수정' 버튼을 누른 경우, 팀원의 권한이 수정된다.
 * 		3-1-1. '권한수정' 버튼을 누른다.
 * 		3-1-2. 모달 창이 나타난다. '팀원'버튼과 '관리자'버튼과 '취소'버튼이 있다.
 * 		3-1-3. '팀원'버튼을 누른 경우, DB team_has_user(auth)데이터가 수정되면서 리스트가 갱신되다.
 * 		3-1-4. '관리자'버튼을 누른 경우, DB team_has_user(auth)데이터가 수정되면서 리스트가 갱신된다.
 * 		3-1-5. '취소'버튼을 누른경우, 2-1-4 항과 같다.
 * 	3-2. '삭제' 버튼을 누른경우, 팀원이 삭제된다.
 * 		3-2-1. '삭제'버튼을 누른다.
 * 		3-2-2. 모달 창이 나타난다. '삭제'버튼과 '취소'버튼이 있다.
 * 		3-2-3. '삭제'버튼을 누른 경우, DB team_has_user 데이터가 삭제된다.
 * 		3-2-4. '취소'버튼을 누른경우, 2-1-4 항과 같다.
 * */

@Controller
@RequestMapping("/team")
public class TeamController {

	private static final Logger logger = LoggerFactory.getLogger(TeamController.class);

	//팀 목록과 관련된 서비스.
	@Inject
	private TeamService teamService;
	
	//팀원 목록과 관련된 서비스.
	@Inject
	private MemberService memberService;

	//로그인과 연결하기 전, 임시로 u_id를 지정함.
	int u_id=11;//userID
	
	//팀 추가(teamAdd).jsp 가져오기. [해설 : teamAdd.jsp 1.]
	@RequestMapping(value="/teamAdd", method= RequestMethod.GET)
	public void teamAddGET(TeamVO tvo, Model model) throws Exception{
		tvo.setU_id(u_id);
//		logger.info("who is it? " + tvo.toString());
//		logger.info("teamAdd page is open...................");	
		model.addAttribute(tvo);
		
	}

	//팀 추가(teamAdd).jsp에서 '입력'버튼을 눌렀을 때, 데이터가 전송되면서 화면 전환. [해설 : teamAdd.jsp 2.]
	@RequestMapping(value="/teamAdd", method=RequestMethod.POST)
	public String teamAddPOST(TeamVO tvo, MemberVO mvo, RedirectAttributes rttr) throws Exception{
		mvo.setU_id(u_id);
//		logger.info("step1" + tvo.toString());
		//DB team 데이터 생성.
		teamService.createTeam(tvo);
		//teamAdd.jsp에서 입력한 DB team(name) 가지고 DB team(t_id) 데이터를 가져온다. 
		int t_id=teamService.selectTeam(tvo.getName());
//		System.out.println("serviceImpl - createTeam 완료");
//		logger.info("step1-1 : " + mvo);
//		logger.info("step1-2 : " + tvo);
		//team_has_user에 데이터 생성.
		memberService.connectTeamMember(mvo.getU_id(),t_id);
//		logger.info("step2");
		rttr.addFlashAttribute(tvo);
		rttr.addFlashAttribute(mvo);
//		logger.info("step3");
//		logger.info("step4" + rttr);
		return "redirect:/team/teamList";
	}

	//팀 목록(teamList).jsp 가져오기
	@RequestMapping(value="/teamList", method=RequestMethod.GET)
	public void teamLsitGET(TeamVO tvo, Model model) throws Exception{
//		logger.info("listTeam 함수실행 : " + teamService.listTeam(u_id));
		//user가 속한 팀 목록을 조회하는 함수를 'teamList'이름으로 정하고 teamList.jsp로 넘김.
		model.addAttribute("teamList",teamService.listTeam(u_id));
		
		//user가 속한 모든 팀의 멤버들을 조회하는 함수를 'memberList'이름으로 정하고 teamList.jsp로 넘김
		model.addAttribute("memberList", memberService.TeamHasUsers(u_id));
		
	}

	//팀 목록(teamList).jsp에서 팀 이름 수정.
	@RequestMapping(value="/teamList", method=RequestMethod.PUT)
	public ResponseEntity<List<TeamVO>> teamListModifyUPDATE(@RequestBody TeamVO tvo) throws Exception{
//		logger.info("teamListUPDATE");
		
		ResponseEntity<List<TeamVO>> entity = null;
//		logger.info("teamListUPDATE : " + tvo);
		try {
//			logger.info("teamListUPDATE2");
			//팀 이름을 수정하는 함수.
			teamService.modifyTeam(tvo);
//			logger.info("teamListUPDATE3");
			//DB team_has_user(u_id)를 사용하여 user가 속한 팀 목록을 조회.
			List<TeamVO> teamList=teamService.listTeam(tvo.getU_id());
//			logger.info("teamListUPDATE3-1 ListTeam : " + teamList);
//			logger.info("teamList size : " + teamList.size());
			//성공할 경우
			entity=new ResponseEntity<List<TeamVO>>(teamList, HttpStatus.OK);
//			logger.info("teamListUPDATE4");
//			logger.info("teamListUPDATE3-2 ListTeam : " + teamList);
			
		}catch(Exception e) {
			//실패할 경우
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	//팀 목록(teamList).jsp에서 팀 삭제.
	@RequestMapping(value="/teamList", method=RequestMethod.DELETE)
	public ResponseEntity<List<TeamVO>> teamListRemoveDELETE(@RequestBody TeamVO tvo) throws Exception{
//		logger.info("teamListDELETE");
		
		ResponseEntity<List<TeamVO>> entity = null;
//		logger.info("teamListDELETE : " + tvo);
		try {
//			logger.info("teamListDELETE2");
//			logger.info("teamListDELETE : " + tvo.getT_id());
			//팀을 삭제하는 함수.
			teamService.deleteTeam(tvo.getT_id());
//			logger.info("teamListDELETE3");
			//DB team_has_user(u_id)를 사용하여 user가 속한 팀 목록을 조회.
			List<TeamVO> teamList=teamService.listTeam(tvo.getU_id());
//			logger.info("teamListDELETE3-1 ListTeam : " + teamList);
//			logger.info("teamList size : " + teamList.size());
			//성공할 경우
			entity=new ResponseEntity<List<TeamVO>>(teamList, HttpStatus.OK);
//			logger.info("teamListDELETE4");

		}catch(Exception e) {
			//실패할 경우
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
	
	//멤버 수정
		@RequestMapping(value="/teamList/{t_id}", method=RequestMethod.PUT)
		public @ResponseBody ResponseEntity<List<MemberVO>> memberListModifyUPDATE(@PathVariable int t_id, @RequestBody MemberVO mvo) throws Exception{
			logger.info("memberListUPDATE");
			
			ResponseEntity<List<MemberVO>> entity = null;
			logger.info("memberListUPDATE : " + mvo);
			try {
				logger.info("memberListUPDATE2");
				memberService.modifyAuth(mvo);
				logger.info("memberListUPDATE3");
				List<MemberVO> memberList= memberService.TeamHasUsers(u_id);
				logger.info("memberListUPDATE3-1 ListTeam : " + memberList);
				logger.info("memberList size : " + memberList.size());
				entity=new ResponseEntity<List<MemberVO>>(memberList, HttpStatus.OK);
				logger.info("memberListUPDATE4");
				logger.info("memberListUPDATE3-2 ListTeam : " + memberList);
				
			}catch(Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}

			return entity;
		}
		
		//멤버 삭제
			@RequestMapping(value="/teamList/{t_id}", method=RequestMethod.DELETE)
			public @ResponseBody ResponseEntity<List<MemberVO>> memberListRemoveDELETE(@PathVariable int t_id, @RequestBody MemberVO mvo) throws Exception{
				logger.info("memberListDELETE");
				logger.info("t_id, u_id : " + t_id + "," + mvo.getU_id()); //ajax에 보내진 데이터들은 @requestBody mvo에 자동 저장된다.
				ResponseEntity<List<MemberVO>> entity = null;
				logger.info("memberListDELETE : " + mvo);
				try {
					logger.info("memberListDELETE2");
					logger.info("memberListDELETE : " + t_id);/*mvo.getT_id()*/
					memberService.deleteMember(mvo.getU_id(),t_id);/*mvo.getU_id()*/
					logger.info("memberListDELETE3");
					List<MemberVO> memberList= memberService.TeamHasUsers(u_id);
					logger.info("memberListDELETE3-1 ListTeam : " + memberList);
					logger.info("memberList size : " + memberList.size());
					entity=new ResponseEntity<List<MemberVO>>(memberList, HttpStatus.OK);
					logger.info("memberListDELETE4");

				}catch(Exception e) {
					e.printStackTrace();
					entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
				}

				return entity;
			}

}
