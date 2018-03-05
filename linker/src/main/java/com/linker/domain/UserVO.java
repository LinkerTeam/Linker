package com.linker.domain;

import java.util.Date;

// 세션이 보관되는 장소
public class UserVO {
	private int id;
	private String email;
	private String password;
	private String nickname;
	private Date cdate;
	private String profile;
	private Date udate;
	private String google;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getCdate() {
		return cdate;
	}


	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public Date getUdate() {
		return udate;
	}

	public void setUdate(Date udate) {
		this.udate = udate;
	}

	public String getGoogle() {
		return google;
	}

	public void setGoogle(String google) {
		this.google = google;
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

	private Date ddate;
	private int status;

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

	@Override
	public String toString() {
		return "UserVO [id=" + id + ", email=" + email + ", password=" + password + ", nickname=" + nickname
				+ ", cdate=" + cdate + ", profile=" + profile + ", udate=" + udate + ", google=" + google + ", ddate="
				+ ddate + ", status=" + status + "]";
	}
}
