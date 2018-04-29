package com.linker.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.linker.dto.AdminUserDTO;
import com.linker.service.AdminUserService;
import com.linker.service.UserService;
import com.linker.util.S3Util;
import com.linker.util.UploadFileUtils;

@Controller
@RequestMapping("/admin")
public class AdminUserController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminUserController.class);
	
	@Inject
	private AdminUserService adminService;
	@Inject
	private UserService userService;
	@Inject
	private BCryptPasswordEncoder pwdEncoder; //스프링 시큐리티 암호화
	
	
	//모든 유저 조회
	@RequestMapping(value = "/userList", method = RequestMethod.GET)
	public void userListAll(Model model) throws Exception {
		model.addAttribute("userList", adminService.userListAll());
	}
	//한 유저의 정보 조회
	@RequestMapping(value = "/readUser", method = RequestMethod.GET)
	public void readUser(@RequestParam("id") int id, Model model) throws Exception {
		model.addAttribute(adminService.readUser(id));
	}
	
	//회원 정보 수정
	@RequestMapping(value = "/readUser", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8") //produces: 한국어로 전송하기 위한 설정
	public String userModify(@RequestParam("id") int id, MultipartFile file, AdminUserDTO dto, RedirectAttributes rttr) throws Exception {
		S3Util s3 = new S3Util();
		String bucketName = "linkers104";
		String uploadpath = "linker/certificate";
		
		//확장자 추출
		String imageType = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1);
		
		//확장자가 null이 아닐 때에만 로직 실행, null일 경우에는 프로필 사진은 변경되지 않는다.
		if (!(imageType.equals(""))) {
			String imageFilePath = UploadFileUtils.uploadFile(uploadpath, file.getOriginalFilename(), file.getBytes());
			
			String oldFilename = adminService.readUser(id).getProfileName(); //기존 프로필사진 파일 이름
			dto.setProfile(imageFilePath); //새로 올린 파일이름 setting
			
			//기존 프로필사진 파일 이름이 /default.gif가 아니면 S3에서 기존 프로필 삭제하기
			if(!(oldFilename.equals("/default.gif"))) 
				s3.fileDelete(bucketName, uploadpath + oldFilename);
		}
		
		adminService.updateUser(dto);
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/admin/readUser?id=" + id;
	}
	
	
	// 닉네임 중복 검사
	@ResponseBody
	@RequestMapping(value = "/nicknameCheck", method = RequestMethod.POST)
	public int nicknameCheck(@RequestParam("id") int id, HttpServletRequest request) throws Exception {
		AdminUserDTO dto = adminService.readUser(id);
		String oldNickname = dto.getNickname(); //기존 닉네임
		String newNickname = request.getParameter("nickname"); //input form에서 받아온 닉네임
		
		//기존 닉네임과 새로 입력한 닉네임이 같을 경우 중복으로 표시하지 않기 위해 0 반환
		if(oldNickname.equals(newNickname)) {
			return 0;
		}
		return userService.checkSignup(newNickname); //중복된 값의 개수
	}
}
