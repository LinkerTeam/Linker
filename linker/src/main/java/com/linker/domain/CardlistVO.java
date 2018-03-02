package com.linker.domain;

import java.util.Date;

public class CardlistVO {
	
	private Integer id;		// 카드리스트 아이디
	private Integer p_id;	// 소속된 프로젝트
	private Integer u_id;	// 카드리스트 생성한 사람
	private String title;	// 카드리스트 제목
	private Date cdate;		// 카드리스트 생성 시간
	private Date udate;		// 카드리스트 업데이트 시간
	private Integer ps_id;	// 카드 상태 코드
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getP_id() {
		return p_id;
	}
	public void setP_id(Integer p_id) {
		this.p_id = p_id;
	}
	public Integer getU_id() {
		return u_id;
	}
	public void setU_id(Integer u_id) {
		this.u_id = u_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public Integer getPs_id() {
		return ps_id;
	}
	public void setPs_id(Integer ps_id) {
		this.ps_id = ps_id;
	}
	@Override
	public String toString() {
		return "CardlistVO [id=" + id + ", p_id=" + p_id + ", u_id=" + u_id + ", title=" + title + ", cdate=" + cdate
				+ ", udate=" + udate + ", ps_id=" + ps_id + "]";
	}
}
