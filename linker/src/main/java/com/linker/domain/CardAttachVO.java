package com.linker.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class CardAttachVO {
	
	private int id; //첨부파일 id
	private String file; //파일명
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy.MM.dd a hh:mm", timezone="GMT+9")
	private Date cdate; //업로드 날짜
	private int c_id; //해당 카드 id
	private int ps_id; //해당 카드의 상태값

	private long size; //파일 크기
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public Date getCdate() {
		return cdate;
	}
	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}
	public int getC_id() {
		return c_id;
	}
	public void setC_id(int c_id) {
		this.c_id = c_id;
	}
	public int getPs_id() {
		return ps_id;
	}
	public void setPs_id(int ps_id) {
		this.ps_id = ps_id;
	}
	public long getSize() {
		return size;
	}
	public void setSize(long size) {
		this.size = size;
	}
	
	@Override
	public String toString() {
		return "CardAttachVO [id=" + id + ", file=" + file + ", cdate=" + cdate + ", c_id=" + c_id + ", ps_id=" + ps_id
				+ ", size=" + size + "]";
	}
	
}
