package com.linker.domain;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class CardVO {
	
	private int id; 		//카드 아이디
	private int u_id;		//회원 아이디
	private String title;	//카드 제목
	private String content;	//카드 내용
	private String cdate;		//카드 생성날짜
	private Date udate;		//카드 업데이트날짜
	private int ps_id;		//카드 상태값
	
	private int cl_id;		//카드가 속한 카드리스트의 아이디
	private int cl_ps_id;   //카드가 속한 카드리스트의 상태값

	private int p_id;		//카드가 속한 프로젝트의 아이디
	
	private String nickname;//작성자의 닉네임
	private String profile; //작성자의 프로필
	
	
	
	public int getP_id() {
		return p_id;
	}
	public void setP_id(int p_id) {
		this.p_id = p_id;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getU_id() {
		return u_id;
	}
	public void setU_id(int u_id) {
		this.u_id = u_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCdate() {
		return cdate;
	}
	public void setCdate(String cdate) {
		this.cdate = cdate;
	}
	public Date getUdate() {
		return udate;
	}
	public void setUdate(Date udate) {
		this.udate = udate;
	}
	public int getCl_id() {
		return cl_id;
	}
	public void setCl_id(int cl_id) {
		this.cl_id = cl_id;
	}
	public int getPs_id() {
		return ps_id;
	}
	public void setPs_id(int ps_id) {
		this.ps_id = ps_id;
	}
	public int getCl_ps_id() {
		return cl_ps_id;
	}
	public void setCl_ps_id(int cl_ps_id) {
		this.cl_ps_id = cl_ps_id;
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
	
	
	@Override
	public String toString() {
		return "CardVO [id=" + id + ", u_id=" + u_id + ", title=" + title + ", content=" + content + ", cdate=" + cdate
				+ ", udate=" + udate + ", ps_id=" + ps_id + ", cl_id=" + cl_id + ", cl_ps_id=" + cl_ps_id + ", p_id="
				+ p_id + ", nickname=" + nickname + ", profile=" + profile + "]";
	}
	
}
