package com.linker.service;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.mail.MessagingException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.linker.domain.MemberVO;
import com.linker.domain.TeamVO;
import com.linker.domain.UserVO;
import com.linker.persistence.MemberDAO;
import com.linker.persistence.TeamDAO;
import com.linker.util.MailHandler;

@Service
public class MemberServiceImpl implements MemberService{

	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);

	@Inject
	MemberDAO dao;

	@Inject
	private JavaMailSender mailSender;

	//멤버추가 + 멤버추가인증
	@Transactional
	@Override
	public int create(MemberVO vo) throws Exception, MessagingException, UnsupportedEncodingException {
		System.out.println("create service start");
		/* 1. 입력한 이메일이 DB user테이블에 있는 지확인한다.
		 * 	1-1. 성공한 경우, email 값을 가지고 2번으로 간다.
		 * 	1-2. 실패한 경우, false 값을 가지고 종료한다.
		 * 2. 입력한 이메일로 인증번호를 전송한다.
		 */

		dao.createMember(vo); //멤버 추가
		System.out.println("dao.createMember() success");
		MailHandler sendMail = new MailHandler(mailSender);
		System.out.println("sendMail start1....");
		sendMail.setSubject("Linker Service Email 인증");
		System.out.println("sendMail start2....");
		sendMail.setText(
				new StringBuffer().append("<h1>메일인증</h1>")
				.append("<a href='http://localhost:8080/emailConfirm?email=")
				.append(vo.getEmail())
				.append("&team=")
				.append(vo.getT_id())
				.append("' target='_blenk'>초대에 응하시겠습니까?</a>")
				.toString()	
				);
		System.out.println("sendMail start3....");
		sendMail.setForm("전체이메일", "Linker");
		System.out.println("sendMail start4....");
		sendMail.setTo(vo.getEmail());
		System.out.println("sendMail start5....");
		sendMail.send();

		return 0 ;
	}
	
	//멤버 추가
	@Override
	public int connectTeamMember(int u_id, int t_id) throws Exception{
		System.out.println("serviceImpl 시작");
		dao.connectTeamMember(u_id, t_id);
		System.out.println("serviceImpl - connectTeamMember 완료");
		return 0;
	}

	//멤버 출력(u_id)
	public MemberVO userHasTeamUid(int u_id, int t_id) throws Exception{
		logger.info("service implemet start....");
		return dao.userHasTeamUid(u_id, t_id);

	}

	//멤버 출력(email)
	public MemberVO userHasTeamEmail(String email, int t_id) throws Exception{
		logger.info("service implemet start....");
		return dao.userHasTeamEmail(email, t_id);

	}
	
	//팀에 속한 멤버리스트 출력(t_id)
	public List<MemberVO> TeamHasUsers(int u_id) throws Exception{
		logger.info("service implement start....");
		return dao.TeamHasUsers(u_id);
	}

	//멤버 출력
	public MemberVO userEmail(String email) throws Exception{
		logger.info("service implemet start....");
		return dao.userEmail(email);

	}

	//멤버 권한 수정
	@Override
	public int modifyAuth(MemberVO vo) throws Exception {
		return dao.modifyMemberAuth(vo);
	}

	//멤버 인증상태코드 수정
	@Override
	public void modifyStatus(int u_id, int t_id) throws Exception {
		System.out.println("인증상태 1로 변환합니다.");
		dao.modifyMemberStatus(u_id, t_id);
	}

	//멤버 삭제
	@Override
	public void deleteMember(int u_id, int t_id) throws Exception {
		dao.deleteMember(u_id, t_id);
	}

}
