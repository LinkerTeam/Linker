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
import com.linker.dto.TeamMemberDTO;
import com.linker.persistence.TeamDAO;
import com.linker.persistence.TeamMemberDAO;
import com.linker.util.MailHandler;

@Service
public class TeamMemberServiceImpl implements TeamMemberService{

   @Inject
   TeamMemberDAO tmdao;
   
   @Inject
   TeamDAO tdao;

   @Inject
   private JavaMailSender mailSender;

   //회원, 멤버 체크 
   @Override
   public int checkMember(String email, int t_id) throws Exception{
      int result = 0;
      //System.out.println("member serivce implements stardt. - check Member");
      //회원인지 체크
      if(tmdao.checkUser(email)==1) {
         //System.out.println("checkUser dao success. result:회원0");
         //팀원인지 체크
         if(tmdao.checkMember(email, t_id) == 0) {
            //System.out.println("checkMember dao success. result:중복x");
            result =  1;
         }else if(tmdao.checkMember(email, t_id) == 1){
            //System.out.println("checkMember dao success. result:중복0");
            result = 0;
         }
      }else{
         //System.out.println("checkUser dao success. result:회원x");
         result = -1;
      }
      
      return result;
   }
      
   //멤버추가 + 멤버추가인증
   @Transactional
   @Override
   public void create(String email,int t_id) throws Exception, MessagingException, UnsupportedEncodingException {
      //System.out.println("create service start");
      TeamMemberVO inviteMemberVO =tmdao.userEmail(email); //입력한 이메일의 user정보를 가져옴.
      //System.out.println("create service : " + inviteMemberVO.toString());
      TeamVO teamVO = tdao.infoTeam(t_id);//t_id정보를 가져옴
      //System.out.println("infoTeam vo : " + teamVO.toString());
      
      //테이블에 메일인증상태가 0인 회원으로 이미 들어가 있으면 생략하고 없으면 추가함
      if(tmdao.checkMemberStatus(email, t_id) == 0) {
         tmdao.createMember(inviteMemberVO.getU_id(), teamVO.getId()); //멤버 추가
      }
      
      //System.out.println("dao.createMember() success");
      MailHandler sendMail = new MailHandler(mailSender);
      //System.out.println("sendMail start1....");
      sendMail.setSubject("Linker Service Email 인증");
      //System.out.println("sendMail start2....");
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
      //System.out.println("sendMail start3....");
      sendMail.setForm("linkers104@gmail.com", "Linker");
      //System.out.println("sendMail start4....");
      sendMail.setTo(inviteMemberVO.getEmail());
      //System.out.println("sendMail start5....");
      sendMail.send();
   }
   
   //멤버 추가
   @Override
   public int connectTeamMember(int u_id, int t_id) throws Exception{
      //System.out.println("serviceImpl 시작");
      tmdao.connectTeamMember(u_id, t_id);
      //System.out.println("serviceImpl - connectTeamMember 완료");
      return 0;
   }

   //멤버 출력(u_id)
   public TeamMemberVO userHasTeamUid(int u_id, int t_id) throws Exception{
      //System.out.println("service implemet start....");
      return tmdao.userHasTeamUid(u_id, t_id);
   }

   //멤버 출력(email)
   public TeamMemberVO userHasTeamEmail(String email, int t_id) throws Exception{
      //System.out.println("serviceImpl : " + email + ", " + t_id);
      return tmdao.userHasTeamEmail(email, t_id);
   }
   
   //팀에 속한 멤버리스트 출력(t_id)
   public List<TeamMemberVO> TeamHasUsers(int u_id) throws Exception{
      //System.out.println("service implement start....");
      return tmdao.TeamHasUsers(u_id);
   }

   //멤버 정보 출력(u_id, email, nickname)
   public TeamMemberVO userEmail(String email) throws Exception{
      //System.out.println("service implemet start....");
      return tmdao.userEmail(email);
   }

   //소유자 수정
   @Transactional
   @Override
   public void TransferAuth(TeamMemberDTO dto) throws Exception {
      //System.out.println("transferAuth service start..");
      tmdao.deleteMember(dto.getDeleteU_id(), dto.getDeleteT_id());
      //System.out.println("deleteMember success..");
      TeamMemberVO vo = new TeamMemberVO();
      vo.setT_id(dto.getTransferT_id());
      vo.setU_id(dto.getTransferU_id());
      vo.setAuth(0);
      tmdao.transferMemberAuth(vo);
      //System.out.println("transferMember success..");   
   }
      
   //멤버 권한 수정
   @Override
   public int modifyAuth(TeamMemberVO vo) throws Exception {
      return tmdao.modifyMemberAuth(vo);
   }

   //멤버 인증상태코드 수정
   @Override
   public void modifyStatus(int u_id, int t_id) throws Exception {
      //System.out.println("인증상태 1로 변환합니다.");
      tmdao.modifyMemberStatus(u_id, t_id);
   }

   //멤버 삭제
   @Override
   public void deleteMember(int u_id, int t_id) throws Exception {
      tmdao.deleteMember(u_id, t_id);
   }

}