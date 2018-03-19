package com.linker.dto;

import org.springframework.web.multipart.MultipartFile;

// 회원 수정시 값을 받아올 저장소(컨테이너)
public class UserDTO {

	private String email;
	private String password;
	private String nickname;
	private MultipartFile profileName;
	private String profile;
	
	@Override
	public String toString() {
		return "UserDTO [email=" + email + ", password=" + password + ", nickname=" + nickname + ", profileName="
				+ profileName + ", profile=" + profile + "]";
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public MultipartFile getProfileName() {
		return profileName;
	}
	public void setProfileName(MultipartFile profileName) {
		this.profileName = profileName;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
}


