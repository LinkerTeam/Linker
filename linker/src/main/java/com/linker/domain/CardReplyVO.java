package com.linker.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class CardReplyVO {

	private Integer id;		//댓글 아이디
	private Integer u_id;	//작성자
	private Integer c_id;	//소속된 카드
	private String content;	//댓글 내용
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy.mm.dd a h:mm")
	private Date cdate;		//작성일
	private Date udate;		//수정일
	
	private String profile; //작성자 프로필
	private String nickname; //작성자 닉네임
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getU_id() {
		return u_id;
	}
	public void setU_id(Integer u_id) {
		this.u_id = u_id;
	}
	public Integer getC_id() {
		return c_id;
	}
	public void setC_id(Integer c_id) {
		this.c_id = c_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	
	@Override
	public String toString() {
		return "CardReplyVO [id=" + id + ", u_id=" + u_id + ", c_id=" + c_id + ", content=" + content + ", cdate="
				+ cdate + ", udate=" + udate + ", profile=" + profile + ", nickname=" + nickname + "]";
	}
}
