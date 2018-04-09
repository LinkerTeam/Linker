package com.linker.controller;

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

import com.linker.domain.TeamMemberVO;
import com.linker.domain.TeamVO;
import com.linker.dto.TeamMemberDTO;
import com.linker.service.TeamMemberService;
import com.linker.service.TeamService;

/*
 * TeamController와 연결된 view: 팀 목록 출력(teamList.jsp) 출력
 * TeamController와 연결된 DB: team, team_has_user, user
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
 * 	2-4. '팀 추가'버튼을 누른 경우, 팀 추가 모달 창이 나타난다.
 * 		2-4-1. user가 팀 추가 모달창에서 새로 생성할 팀 이름을 입력한다.
 * 		2-4-2. 입력 버튼을 누른다.
 * 		2-4-3. DB team과 DB team_has_user 데이터가 추가 된다.
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
 * 	3-3. '권한양도' 버튼을 누른경우, 소유자 권한이 양도된다. 단, 팀원이 소유자만 있는 경우, 팀을 삭제하라는 메세지가 뜬다.
 * 		3-3-1. 모달 창이 나타난다. 팀원들의 목록이 select로 보여진다.
 * 		3-3-2. 양도할 팀원을 선택하고 '확인'버튼을 누른 경우, 양도한 소유자는 해당 팀에서 탈퇴하게 된다. 또한 양도 받은 소유자는 권한이 무엇이었든 소유자로 바뀌게 된다.
 * 		3-3-3. '취소'버튼을 누른경우, 2-1-4 항과 같다.
 * */

@Controller
@RequestMapping("/main")
public class TeamController {

	private static final Logger logger = LoggerFactory.getLogger(TeamController.class);

	//팀 목록과 관련된 서비스.
	@Inject
	private TeamService teamService;
	
	//팀원 목록과 관련된 서비스.
	@Inject
	private TeamMemberService memberService;

	//로그인과 연결하기 전, 임시로 u_id를 지정함.
	int u_id=10;//userID
 
	//팀 목록(teamList.jsp)가져오기1
	@RequestMapping(value="/team", method=RequestMethod.GET)
	public String teamListGET(Model model) throws Exception{
//		logger.info("teamAdd page is open..................." + u_id);	
		
		//user가 속한 팀 목록을 조회하는 함수를 'teamList'이름으로 정하고 teamList.jsp로 넘김.
		model.addAttribute("teamList",teamService.listTeam(u_id));
				
		//user가 속한 모든 팀의 멤버들을 조회하는 함수를 'memberList'이름으로 정하고 teamList.jsp로 넘김
		model.addAttribute("memberList", memberService.TeamHasUsers(u_id));
		model.addAttribute(u_id);
		return "team/teamList";
	}
	
	//팀 목록(teamList.jsp) 가져오기2
	@ResponseBody
	@RequestMapping(value="/team", method=RequestMethod.POST)
	public ResponseEntity<String> teamLsitPOST(@RequestBody TeamVO tvo) throws Exception{
		//logger.info("createTeam tvo : " + tvo.toString());
		ResponseEntity<String> entity = null;
		try {
//			logger.info("받은 name : " + tvo.getName());
			teamService.createTeam(tvo);		
//			logger.info("이게 vo : " + tvo.toString());
			int t_id=tvo.getId();
//			logger.info("tvo : " + tvo.getT_id());
//			logger.info("t_id는 : " + t_id);
			memberService.connectTeamMember(u_id, t_id);
			entity = new ResponseEntity<String>("true", HttpStatus.OK);
		}catch(Exception e) {
			entity = new ResponseEntity<String>("false",HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	//팀 목록(teamList.jsp)에서 팀 이름 수정.
	@RequestMapping(value="/team", method=RequestMethod.PUT)
	public ResponseEntity<List<TeamVO>> teamListModifyUPDATE(@RequestBody TeamVO tvo) throws Exception{
		//logger.info("teamListUPDATE");
		
		ResponseEntity<List<TeamVO>> entity = null;
		//logger.info("teamListUPDATE : " + tvo);
		try {
			//logger.info("teamListUPDATE2");
			
			//팀 이름을 수정하는 함수.
			teamService.modifyTeam(tvo);
			//logger.info("teamListUPDATE3");
			//DB team_has_user(u_id)를 사용하여 user가 속한 팀 목록을 조회.
			List<TeamVO> teamList=teamService.listTeam(tvo.getU_id());
			//logger.info("teamListUPDATE3-1 ListTeam : " + teamList);
			//logger.info("teamList size : " + teamList.size());
			
			//성공할 경우
			entity=new ResponseEntity<List<TeamVO>>(teamList, HttpStatus.OK);
			//logger.info("teamListUPDATE4");
			//logger.info("teamListUPDATE3-2 ListTeam : " + teamList);			
		}catch(Exception e) {
			
			//실패할 경우
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	//팀 목록(teamList.jsp)에서 팀 삭제.
	@RequestMapping(value="/team", method=RequestMethod.DELETE)
	public ResponseEntity<List<TeamVO>> teamListRemoveDELETE(@RequestBody TeamVO tvo) throws Exception{
		//logger.info("teamListDELETE");
		
		ResponseEntity<List<TeamVO>> entity = null;
		//logger.info("teamListDELETE : " + tvo);
		try {
			//logger.info("teamListDELETE2");
			//logger.info("teamListDELETE : " + tvo.getT_id());
			
			//팀을 삭제하는 함수.
			teamService.deleteTeam(tvo.getT_id());
			//logger.info("teamListDELETE3");
			//DB team_has_user(u_id)를 사용하여 user가 속한 팀 목록을 조회.
			List<TeamVO> teamList=teamService.listTeam(tvo.getU_id());
			//logger.info("teamListDELETE3-1 ListTeam : " + teamList);
			//logger.info("teamList size : " + teamList.size());
			
			//성공할 경우
			entity=new ResponseEntity<List<TeamVO>>(teamList, HttpStatus.OK);
			//logger.info("teamListDELETE4");
		}catch(Exception e) {
			
			//실패할 경우
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//소유자 수정
	@ResponseBody
	@RequestMapping(value="/team/{t_id}/{u_id}", method=RequestMethod.PUT)
	public ResponseEntity<List<TeamMemberVO>> memberListTransferUPDATE(@PathVariable int t_id, @PathVariable int u_id, @RequestBody TeamMemberDTO dto) throws Exception{
		//logger.info("memberListUPDATE");
		ResponseEntity<List<TeamMemberVO>> entity = null;
		//logger.info("memberListUPDATE : " + dto);
		try {
			//logger.info("memberListUPDATE2");
			memberService.TransferAuth(dto);
			//logger.info("memberListUPDATE3");
			List<TeamMemberVO> memberList= memberService.TeamHasUsers(u_id);
			//logger.info("memberListUPDATE3-1 ListTeam : " + memberList);
			entity=new ResponseEntity<List<TeamMemberVO>>(memberList, HttpStatus.OK);
			//logger.info("memberListUPDATE4");
			
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//멤버 수정
	@RequestMapping(value="/team/{t_id}", method=RequestMethod.PUT)
	public @ResponseBody ResponseEntity<List<TeamMemberVO>> memberListModifyUPDATE(@PathVariable int t_id, @RequestBody TeamMemberVO mvo) throws Exception{
		//logger.info("memberListUPDATE");			
		ResponseEntity<List<TeamMemberVO>> entity = null;
		//logger.info("memberListUPDATE : " + mvo);
			try {
				//logger.info("memberListUPDATE2");
				memberService.modifyAuth(mvo);
				//logger.info("memberListUPDATE3");
				
				List<TeamMemberVO> memberList= memberService.TeamHasUsers(u_id);
				//logger.info("memberListUPDATE3-1 ListTeam : " + memberList);
				//logger.info("memberList size : " + memberList.size());
				entity=new ResponseEntity<List<TeamMemberVO>>(memberList, HttpStatus.OK);
				//logger.info("memberListUPDATE4");
				//logger.info("memberListUPDATE3-2 ListTeam : " + memberList);
				
			}catch(Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}
		return entity;
	}
		
	//멤버 삭제
	@RequestMapping(value="/team/{t_id}", method=RequestMethod.DELETE)
	public @ResponseBody ResponseEntity<List<TeamMemberVO>> memberListRemoveDELETE(@PathVariable int t_id, @RequestBody TeamMemberVO mvo) throws Exception{
		//logger.info("memberListDELETE");
		//logger.info("t_id, u_id : " + t_id + "," + mvo.getU_id()); //ajax에 보내진 데이터들은 @requestBody mvo에 자동 저장된다.
		ResponseEntity<List<TeamMemberVO>> entity = null;
		//logger.info("memberListDELETE : " + mvo);
		try {
			//logger.info("memberListDELETE2");
			//logger.info("memberListDELETE : " + t_id);
			memberService.deleteMember(mvo.getU_id(),t_id);
			//logger.info("memberListDELETE3");
			List<TeamMemberVO> memberList= memberService.TeamHasUsers(u_id);
			//logger.info("memberListDELETE3-1 ListTeam : " + memberList);
			//logger.info("memberList size : " + memberList.size());
			entity=new ResponseEntity<List<TeamMemberVO>>(memberList, HttpStatus.OK);
			//logger.info("memberListDELETE4");
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}