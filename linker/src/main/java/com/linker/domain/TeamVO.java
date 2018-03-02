package com.linker.domain;

import java.util.Date;

public class TeamVO {
	private int id;
	private String teamName;
	private Date date;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "teamVO [id=" + id + ", teamName=" + teamName + ", date=" + date + "]";
	}
	
	
}
