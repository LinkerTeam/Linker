package com.linker.domain;

import java.sql.Date;

public class ProjectVO {

	private int id;
	private String title;
	private int u_id;
	private int t_id;
	private int ps_id;
	private Date cdate;
	private String writerEmail;
	private String writerNickName;
	 
	public String getWriterEmail() {
		return writerEmail;
	}
	public void setWriterEmail(String writerEmail) {
		this.writerEmail = writerEmail;
	}
	public String getWriterNickName() {
		return writerNickName;
	}
	public void setWriterNickName(String writerNickName) {
		this.writerNickName = writerNickName;
	}
	public Date getCdate() {
		return cdate;
	}
	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getU_id() {
		return u_id;
	}
	public void setU_id(int u_id) {
		this.u_id = u_id;
	}
	public int getT_id() {
		return t_id;
	}
	public void setT_id(int t_id) {
		this.t_id = t_id;
	}
	public int getPs_id() {
		return ps_id;
	}
	public void setPs_id(int ps_id) {
		this.ps_id = ps_id;
	}
	@Override
	public String toString() {
		return "ProjectVO [id=" + id + ", title=" + title + ", u_id=" + u_id + ", t_id=" + t_id + ", ps_id=" + ps_id
				+ ", cdate=" + cdate + ", writerEmail=" + writerEmail + ", writerNickName=" + writerNickName + "]";
	}
}
