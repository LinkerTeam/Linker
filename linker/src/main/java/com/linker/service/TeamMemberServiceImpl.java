package com.linker.service;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.inject.Inject;
import javax.mail.MessagingException;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.linker.domain.TeamMemberVO;
import com.linker.domain.TeamVO;
import com.linker.domain.UserVO;
import com.linker.domain.HistoryVO;
import com.linker.dto.TeamMemberDTO;
import com.linker.persistence.TeamDAO;
import com.linker.persistence.TeamMemberDAO;
import com.linker.persistence.HistoryDAO;
import com.linker.util.MailHandler;

@Service
public class TeamMemberServiceImpl implements TeamMemberService{

   @Inject
   TeamMemberDAO tmdao;
   
   @Inject
   TeamDAO tdao;
   
   @Inject
   HistoryDAO hdao;

   @Inject
   private JavaMailSender mailSender;

   //회원, 멤버 체크 
   @Override
   public int checkMember(String email, int t_id) throws Exception{
      int result = 0;
      //회원인지 체크
      if(tmdao.checkUser(email)== 1) {
         //팀원인지 체크
         if(tmdao.checkMember(email, t_id) == 0) {
            result =  1;
         }else if(tmdao.checkMember(email, t_id) == 1){
            result = 0;
         }
      }else{
         result = -1;
      }
      return result;
   }
      
   //멤버추가 + 멤버추가인증
   @Transactional
   @Override
   public void create(String email,int t_id) throws Exception, MessagingException, UnsupportedEncodingException {
      TeamMemberVO inviteMemberVO =tmdao.userEmail(email); //입력한 이메일의 user정보를 가져옴.
      TeamVO teamVO = tdao.infoTeam(t_id);//t_id정보를 가져옴
      
      //테이블에 메일인증상태가 0인 회원으로 이미 들어가 있으면 생략하고 없으면 추가함
      if(tmdao.checkMemberStatus(email, t_id) == 0) {
         tmdao.createMember(inviteMemberVO.getU_id(), teamVO.getId()); //멤버 추가
      }
      
      MailHandler sendMail = new MailHandler(mailSender);
      sendMail.setSubject("Linker Service Email 인증");
      sendMail.setText(
            new StringBuffer().append("<h1>메일인증</h1><br>" + 
                  "   <strong><a href='javascript:void(0)'>")
            .append(inviteMemberVO.getEmail())
            .append("</a>님</strong><strong>")
            .append(teamVO.getName())
            .append("</strong>에 초대되셨습니다.<br>" + 
                  "   초대에 응하시려면 버튼을 클릭하여 Linker에 다시 들어가서 로그인 해주시기 바랍니다.<br>" + 
                  "   <button>")
            .append("<a href='http://localhost:9090/team/emailConfirm?email=")
            .append(inviteMemberVO.getEmail())
            .append("&t_id=")
            .append(teamVO.getId())
            .append("' target='_blenk'>초대받기</a></button>")
            .toString()   
            );
      sendMail.setForm("linkers104@gmail.com", "Linker");
      sendMail.setTo(inviteMemberVO.getEmail());
      sendMail.send();
   }
   
   //멤버 추가
   @Transactional
   @Override
   public HistoryVO connectTeamMember(int u_id, int t_id, String after) throws Exception{
	  hdao.historyInsertTeamAdd(u_id, t_id, after);//t_id == data_id
      tmdao.connectTeamMember(u_id, t_id);
      return hdao.historySelectTeamAdd(u_id, t_id);
   }

   //멤버 출력(u_id)
   public TeamMemberVO userHasTeamUid(int u_id, int t_id) throws Exception{
      return tmdao.userHasTeamUid(u_id, t_id);
   }

   //멤버 출력(email)
   public TeamMemberVO userHasTeamEmail(String email, int t_id) throws Exception{
      return tmdao.userHasTeamEmail(email, t_id);
   }
   
   //팀에 속한 멤버리스트 출력(t_id)
   public List<TeamMemberVO> TeamHasUsers(int u_id) throws Exception{
      return tmdao.TeamHasUsers(u_id);
   }

   //멤버 정보 출력(u_id, email, nickname)
   public TeamMemberVO userEmail(String email) throws Exception{
      return tmdao.userEmail(email);
   }

   //소유자 수정
   @Transactional
   @Override
   public void TransferAuth(TeamMemberDTO dto) throws Exception {
      tmdao.deleteMember(dto.getDeleteU_id(), dto.getDeleteT_id());
      TeamMemberVO vo = new TeamMemberVO();
      vo.setT_id(dto.getTransferT_id());
      vo.setU_id(dto.getTransferU_id());
      vo.setAuth(0);
      tmdao.transferMemberAuth(vo);
   }
      
   //멤버 권한 수정
   @Override
   public int modifyAuth(TeamMemberVO vo) throws Exception {
      return tmdao.modifyMemberAuth(vo);
   }

   //멤버 인증상태코드 수정
   @Override
   public void modifyStatus(int u_id, int t_id) throws Exception {
      tmdao.modifyMemberStatus(u_id, t_id);
   }

   //멤버 삭제
   @Override
   public void deleteMember(int u_id, int t_id) throws Exception {
      tmdao.deleteMember(u_id, t_id);
   }

   //팀멤버 프로필 사진 가져오기
   @Override
   public List<UserVO> hasTeamProfile(int t_id) throws Exception {
	  return tmdao.hasTeamProfile(t_id);
   }
   
}