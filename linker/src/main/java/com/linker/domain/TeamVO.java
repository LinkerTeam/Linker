package com.linker.domain;

import java.util.Date;

public class TeamVO {
	private int t_id; //팀아이디
	private String name; //팀이름
	private int u_id; //회원아이디
	private Date date; //날짜(수정날짜, 삭제날짜)
	private int auth; //그 팀에 대한 회원의 권한
	private Date cdate; //생성 날짜
	
	public int getT_id() {
		return t_id;
	}
	public void setT_id(int t_id) {
		this.t_id = t_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getU_id() {
		return u_id;
	}
	public void setU_id(int u_id) {
		this.u_id = u_id;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getAuth() {
		return auth;
	}
	public void setAuth(int auth) {
		this.auth = auth;
	}
	public Date getCdate() {
		return cdate;
	}
	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}
	@Override
	public String toString() {
		return "TeamVO [t_id=" + t_id + ", name=" + name + ", u_id=" + u_id + ", date=" + date + ", auth=" + auth
				+ ", cdate=" + cdate + "]";
	}
	
	
	
}
