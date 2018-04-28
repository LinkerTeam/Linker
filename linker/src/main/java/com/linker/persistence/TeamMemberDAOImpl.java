package com.linker.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;

import org.springframework.stereotype.Repository;

import com.linker.domain.TeamMemberVO;
import com.linker.domain.UserVO;

@Repository
public class TeamMemberDAOImpl implements TeamMemberDAO {

   private static String namespace = "com.linker.mapper.teamMemberMapper";

   @Inject
   SqlSession session;

   //회원 체크
   @Override
   public int checkUser(String email) throws Exception{
      return session.selectOne(namespace + ".checkUser", email);
   }
   
   //멤버 메일 인증 상태 중복 체크
   public int checkMemberStatus(String email, int t_id) throws Exception{
      TeamMemberVO vo = new TeamMemberVO();
      vo.setEmail(email);
      vo.setT_id(t_id);
      return session.selectOne(namespace + ".checkMemberStatus", vo);
   }
   
   //멤버 중복 체크
   @Override
   public int checkMember(String email, int t_id) throws Exception{
      TeamMemberVO vo = new TeamMemberVO();
      vo.setEmail(email);
      vo.setT_id(t_id);
      return session.selectOne(namespace + ".checkMember", vo);
   }
  
   // 멤버생성
   @Override
   public int createMember(int u_id, int t_id) throws Exception {
      TeamMemberVO vo= new TeamMemberVO();
      vo.setU_id(u_id);
      vo.setT_id(t_id);
      return session.insert(namespace + ".createMember", vo);
   }
   
   // 멤버추가
   @Override
   public int connectTeamMember(int u_id, int t_id) throws Exception {
      TeamMemberVO vo= new TeamMemberVO();
      vo.setU_id(u_id);
      vo.setT_id(t_id);
      return session.insert(namespace + ".connectTeamMember",vo);
   }
   
   //팀에 속한 멤버 리스트 출력(t_id)
   @Override
   public List<TeamMemberVO> TeamHasUsers(int u_id) throws Exception{
      return session.selectList(namespace+".TeamHasUsers", u_id);
   }

   //멤버출력
   @Override
   public TeamMemberVO userHasTeamUid(int u_id, int t_id) throws Exception{
      TeamMemberVO vo = new TeamMemberVO();
      vo.setU_id(u_id);   
      vo.setT_id(t_id);
      return session.selectOne(namespace + ".userHasTeamUid", vo);
   }

   //멤버출력
   @Override
   public TeamMemberVO userHasTeamEmail(String email, int t_id) throws Exception{
      TeamMemberVO vo = new TeamMemberVO();
      vo.setEmail(email);
      vo.setT_id(t_id);
      return session.selectOne(namespace + ".userHasTeamEmail", vo);
   }

   //멤버출력
   @Override
   public TeamMemberVO userEmail(String email) throws Exception{
      TeamMemberVO vo = new TeamMemberVO();
      vo.setEmail(email);
      return session.selectOne(namespace + ".userEmail", vo);
   }

   // 소유자수정
   @Override
   public int transferMemberAuth(TeamMemberVO vo) throws Exception {
      return session.update(namespace + ".modifyMemberAuth", vo);
   }
      
   // 멤버상태코드수정
   @Override
   public int modifyMemberStatus(int u_id, int t_id) throws Exception {
      TeamMemberVO vo = new TeamMemberVO();
      vo.setU_id(u_id);
      vo.setT_id(t_id);
      return session.update(namespace + ".modifyMemberStatus", vo);
   }

   // 멤버권한수정
   @Override
   public int modifyMemberAuth(TeamMemberVO vo) throws Exception {
      return session.update(namespace + ".modifyMemberAuth", vo);
   }
   
   // 멤버삭제
   @Override
   public int deleteMember(int u_id, int t_id) throws Exception {
      TeamMemberVO vo = new TeamMemberVO();
      vo.setU_id(u_id);
      vo.setT_id(t_id);
      return session.delete(namespace + ".deleteMember", vo);
   }

   // 팀 멤버 프로필 가져오기
   @Override
   public List<UserVO> hasTeamProfile(int t_id) throws Exception {
	  return   session.selectList(namespace+".hasTeamProfile", t_id);
   }

}