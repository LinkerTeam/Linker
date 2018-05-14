package com.linker.service;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.linker.domain.UserVO;
import com.linker.persistence.SignupDAO;
import com.linker.util.MailHandler;
import com.linker.util.TempKey;

//@Serviec는 애노테이션은 이클래스가 service클래스라는것 명시해주는것 component에서 읽을수있다 지정해줘야
@Service
public class SignupServiceImpl implements SignupService{
	@Inject
	SignupDAO dao;
    
	//메일날리는 객체 주입해줌
	@Inject
	private JavaMailSender mailSender;
	
	//비밀번호를 암호화시켜주는 것을 엔코딩화 해주는 객체를 주입해줌
	@Inject
	private BCryptPasswordEncoder passwordEncoder;
	
	private Logger logger;

	//회원가입 트랜젝션 처리
    @Transactional
	@Override
	public void insertMember(UserVO vo) throws Exception {

    	  //비밀번호를 엔코딩해서  암화 시키는 과정  암호가 1111이면 !@#!@#@!231이렇게 변환시켜줌
		  String encPassword =  passwordEncoder.encode(vo.getPassword());
		  //변환된 값을 다시 저장한다.
    	  vo.setPassword(encPassword);
    	  
    	  dao.insertMember(vo);
		  
    	  String key = new TempKey().getKey(50, false); // 인증키 생성

		   dao.createAuthKey(vo.getEmail(), key); // 인증키 DB저장

		   MailHandler sendMail = new MailHandler(mailSender);
		   sendMail.setSubject("[Linker 회원가입 서비스 이메일 인증]");
		   sendMail.setText(
		   		new StringBuffer().append("<h1>메일인증</h1>").append("<a href='http://localhost:9090/user/emailConfirm?email=").append(vo.getEmail()).append("&key=").append(key).append("' target='_blenk'>이메일 인증 확인</a>").toString());
		   sendMail.setForm("intosy227@gmail.com", "Linker");
		   sendMail.setTo(vo.getEmail());
		   sendMail.send();
	}
    
    //해당 이메일 stauts체크
    @Override
    public void status(String email) throws Exception {
		dao.status(email);		
	}
	//구글 회원 가입
	@Override
	public void insertGoogle(UserVO vo) throws Exception {
		dao.insertGoogle(vo);
	}
	//구글 회원 가입유무 체크
	@Override
	public UserVO serchGoogle(UserVO vo) throws Exception {
		return dao.serchGoogle(vo);
	}
}
