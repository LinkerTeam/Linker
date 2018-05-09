package com.linker.dto;

import java.util.Date;

public class AdminUserDTO {
	private int id; //회원 고유id(PK)
	private String email; //이메일
	private String password; //패스워드
	private String nickname; //닉네임
	private String profile; //프로필사진(경로+파일명)
	private String google; //소셜가입 여부
	private Date cdate; //가입날짜
	private Date udate; //마지막 정보수정날짜
	private Date ddate; //탈퇴날짜
	private int status; //인증/탈퇴 여부
	
	private String viewStatus; //상태값 한글로 표시
	private String profileName; //프로필사진(파일명만)
	

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getGoogle() {
		return google;
	}
	public void setGoogle(String google) {
		this.google = google;
	}
	public Date getCdate() {
		return cdate;
	}
	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}
	public Date getUdate() {
		return udate;
	}
	public void setUdate(Date udate) {
		this.udate = udate;
	}
	public Date getDdate() {
		return ddate;
	}
	public void setDdate(Date ddate) {
		this.ddate = ddate;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getViewStatus() {
		return viewStatus;
	}
	public void setViewStatus(String viewStatus) {
		this.viewStatus = viewStatus;
	}
	public String getProfileName() {
		return profileName;
	}
	public void setProfileName(String profileName) {
		this.profileName = profileName;
	}	

	@Override
	public String toString() {
		return "AdminUserDTO [id=" + id + ", email=" + email + ", password=" + password + ", nickname=" + nickname
				+ ", profile=" + profile + ", google=" + google + ", cdate=" + cdate + ", udate=" + udate + ", ddate="
				+ ddate + ", status=" + status + ", viewStatus=" + viewStatus + ", profileName=" + profileName + "]";
	}
	
}
