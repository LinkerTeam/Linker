package com.linker.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/*
 * 회원의 정보를 다루는 모든 URI는 AuthController로 들어오도록한다. 
 * 회원가입(로컬, 소셜), 회원정보관리(닉네임, 프로필, 비밀번호), 회원탈퇴
 * */

@Controller
@RequestMapping("/auth")
public class AuthController {

}
