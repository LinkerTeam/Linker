package com.linker.dto;

//회원가입시 화면에서 받아온 정보를 넣음.
public class SignupDTO {
	private String email;
	private String password;
	private String nickname;
	private String profile;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public String toString() {
		return "SignupDTO [email=" + email + ", password=" + password + ", nickname=" + nickname + "]";
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

}
