package com.linker.domain;

import java.util.Date;

public class teamVO {
	private int id;
	private String teamName;
	private String teamLeader;
	private String teamMember;
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
	public String getTeamLeader() {
		return teamLeader;
	}
	public void setTeamLeader(String teamLeader) {
		this.teamLeader = teamLeader;
	}
	public String getTeamMember() {
		return teamMember;
	}
	public void setTeamMember(String teamMember) {
		this.teamMember = teamMember;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "teamVO [id=" + id + ", teamName=" + teamName + ", teamLeader=" + teamLeader + ", teamMember="
				+ teamMember + ", date=" + date + "]";
	}
	
	
}
