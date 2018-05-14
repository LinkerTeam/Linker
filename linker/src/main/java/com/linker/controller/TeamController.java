
package com.linker.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

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
import com.linker.domain.TeamVO;
import com.linker.domain.UserVO;
import com.linker.domain.HistoryVO;
import com.linker.dto.TeamMemberDTO;
import com.linker.service.TeamMemberService;
import com.linker.service.TeamService;

/*  작성자 : 김소영
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

	//teamList.jsp 열기
	  @RequestMapping(value="/team", method=RequestMethod.GET)
	  public String teamListGET(Model model,HttpSession session) throws Exception{
	    UserVO vo = (UserVO) session.getAttribute("login");
	    model.addAttribute("u_id", vo.getId());
	    model.addAttribute("email", vo.getEmail());
	    model.addAttribute("nickname", vo.getNickname());
		return "team/teamList";
	}
	
	 //멤버목록 동적생성
	 @ResponseBody
	 @RequestMapping(value="/member/{u_id}", method=RequestMethod.GET)
	 public ResponseEntity<List<TeamMemberVO>> allMemberGET(@PathVariable("u_id") int u_id, @RequestParam int t_id, HttpSession session){
	    ResponseEntity<List<TeamMemberVO>> entity = null;
	    try { 
	       entity = new ResponseEntity<List<TeamMemberVO>>(memberService.TeamHasUsers(t_id), HttpStatus.OK);
	    } catch (Exception e) {
	       e.printStackTrace();
	       entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }
	    return entity;
	 }
	  
	//팀목록 동적생성
	 @ResponseBody
	 @RequestMapping(value="/team/{u_id}", method=RequestMethod.GET)
	 public ResponseEntity<List<TeamVO>> allTeamGET(@PathVariable("u_id") int u_id,HttpSession session){
	    ResponseEntity<List<TeamVO>> entity = null;
	    try { 
	       entity = new ResponseEntity<List<TeamVO>>(teamService.listTeam(u_id), HttpStatus.OK);
	    } catch (Exception e) {
	       e.printStackTrace();
	       entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }
	    return entity;
	 }
	
	 //팀목록에서 팀 추가
	 @ResponseBody
	 @RequestMapping(value="/team", method=RequestMethod.POST)
	 public ResponseEntity<HistoryVO> teamLsitPOST(@RequestBody TeamVO tvo,HttpSession session) throws Exception{
	 	UserVO vo = (UserVO) session.getAttribute("login");
	 	ResponseEntity<HistoryVO> entity = null;
	 	try {
	 		teamService.createTeam(tvo);//DB에 팀을 만들어 준다(사용자와 팀을 연결시켜주지 x).team		
	 		int t_id=tvo.getId();
	 		HistoryVO hvo = memberService.connectTeamMember(vo.getId(), t_id, tvo.getName());//해당 팀에 사용자와 팀을 연결시켜준다.team_has_user
	 		entity = new ResponseEntity<HistoryVO>(hvo, HttpStatus.OK);
	 	}catch(Exception e) {
	 		entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	 	}
	 	return entity;
	 }
	 
	 //프로젝트에서 팀 추가 
	 @RequestMapping(value="/teamcreate", method=RequestMethod.POST)
	 public String createTeam(TeamVO tvo,HttpSession session)throws Exception{
		 UserVO vo = (UserVO) session.getAttribute("login");
		 teamService.createTeam(tvo);//DB에 팀을 만들어 준다(사용자와 팀을 연결시켜주지 x).team		
		 int t_id=tvo.getId();
		 memberService.connectTeamMember(vo.getId(), t_id, tvo.getName());//해당 팀에 사용자와 팀을 연결시켜준다.team_has_user
		 return "redirect:/main";
	 }
	 

	 //팀 목록(teamList.jsp)에서 팀 이름 수정.
	@RequestMapping(value="/team/update/{t_id}", method=RequestMethod.PUT)
	public ResponseEntity<HistoryVO> teamListModifyUPDATE(@PathVariable("t_id") int t_id, @RequestBody TeamVO tvo) throws Exception{
		ResponseEntity<HistoryVO> entity = null;
		try {
			tvo.setT_id(t_id);
			HistoryVO hvo = teamService.modifyTeam(tvo);
			entity=new ResponseEntity<HistoryVO>(hvo, HttpStatus.OK);
		}catch(Exception e) {	
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}


	//팀 목록(teamList.jsp)에서 팀 삭제.
	@RequestMapping(value="/team/delete/{t_id}", method=RequestMethod.PUT)
	public ResponseEntity<HistoryVO> teamListRemoveDELETE(@PathVariable("t_id") int t_id, @RequestBody TeamVO tvo) throws Exception{
		ResponseEntity<HistoryVO> entity = null;
		try {
			tvo.setT_id(t_id);
			HistoryVO hvo = teamService.deleteTeam(tvo);
			entity=new ResponseEntity<HistoryVO>(hvo, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
 	//소유자 수정
	@ResponseBody
	@RequestMapping(value="/team/{t_id}/{u_id}", method=RequestMethod.PUT)
	public ResponseEntity<Boolean> memberListTransferUPDATE(@PathVariable int t_id, @PathVariable int u_id, @RequestBody TeamMemberDTO dto) throws Exception{
		ResponseEntity<Boolean> entity = null;
		try {
			memberService.TransferAuth(dto);
			entity=new ResponseEntity<Boolean>(true, HttpStatus.OK);
 		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	//멤버 자진 탈퇴 
	@RequestMapping(value="/team/delete/volunteer/{t_id}/{u_id}", method=RequestMethod.DELETE)
	public @ResponseBody ResponseEntity<Boolean> memberListRemoveVolunteerDELETE(@PathVariable("t_id") int t_id, @PathVariable("u_id") int u_id, @RequestBody TeamMemberVO mvo,HttpSession session) throws Exception{
		ResponseEntity<Boolean> entity = null;
		try {
			memberService.deleteMember(u_id,t_id);
			entity=new ResponseEntity<Boolean>(true, HttpStatus.OK);
 		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//멤버 강제 탈퇴
	@RequestMapping(value="/team/delete/forced/{t_id}/{u_id}", method=RequestMethod.DELETE)
	public @ResponseBody ResponseEntity<Boolean> memberListRemoveForcedDELETE(@PathVariable("t_id") int t_id, @PathVariable("u_id") int u_id, @RequestBody TeamMemberVO mvo,HttpSession session) throws Exception{
		ResponseEntity<Boolean> entity = null;
		try {
			memberService.deleteMember(u_id,t_id);
			entity=new ResponseEntity<Boolean>(true, HttpStatus.OK);
 		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}