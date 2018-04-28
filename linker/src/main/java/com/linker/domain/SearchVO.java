
package com.linker.domain;

public class SearchVO {

	private String keyword;
	private int p_id; //달성/가리기/전체 검색할 때 프로젝트 id가 필요
	private int u_id;

	public int getU_id() {
		return u_id;
	}

	public void setU_id(int u_id) {
		this.u_id = u_id;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getP_id() {
		return p_id;
	}

	public void setP_id(int p_id) {
		this.p_id = p_id;
	}

	@Override
	public String toString() {
		return "SearchVO [keyword=" + keyword + ", p_id=" + p_id + ", u_id=" + u_id + "]";
	}
	
	
}
