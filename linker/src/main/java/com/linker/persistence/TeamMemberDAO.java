package com.linker.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.linker.domain.TeamMemberVO;
import com.linker.domain.UserVO;

@Repository
public interface TeamMemberDAO {

   //회원 체크
   public int checkUser(String email) throws Exception;
   //멤버 메일 인증 상태 중복 체크
   public int checkMemberStatus(String email, int t_id) throws Exception;
   //멤버 중복 체크
   public int checkMember(String email, int t_id) throws Exception;
   //멤버생성
   public int createMember(int u_id, int t_id) throws Exception;
   //멤버 추가
   public int connectTeamMember(int u_id, int t_id) throws Exception;
   //팀에 속한 멤버출력(t_id)
   public List<TeamMemberVO> TeamHasUsers(int u_id) throws Exception;
   //팀에 대한 멤버출력(u_id)
   public TeamMemberVO userHasTeamUid(int u_id, int t_id) throws Exception;
   //팀에 대한 멤버출력(email)
   public TeamMemberVO userHasTeamEmail(String email, int t_id) throws Exception;
   //멤버출력
   public TeamMemberVO userEmail(String email) throws Exception;
   //소유자수정(멤버수정과 같은 쿼리)
   public int transferMemberAuth(TeamMemberVO vo) throws Exception;
   //멤버수정(상태코드)
   public int modifyMemberStatus(int u_id, int t_id) throws Exception;
   //멤버수정(권한)
   public int modifyMemberAuth(TeamMemberVO vo) throws Exception;
   //멤버삭제
   public int deleteMember(int u_id, int t_id) throws Exception;
   //해당 팀의 멤버의 닉네임과 프로필사진 가져오기
   public List<UserVO> hasTeamProfile(int t_id) throws Exception;
   

}