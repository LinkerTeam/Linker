package com.linker.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.domain.ProjectVO;
import com.linker.domain.UserVO;

@Repository
public class ProjectDAOImpl implements ProjectDAO {

	private static String namespace = "com.linker.mapper.projectMapper";

	@Inject
	SqlSession session;
 
	// 프로젝트 생성
	@Override
	public int createProject(ProjectVO vo) throws Exception {
		return session.insert(namespace + ".createProject", vo);
	}

	// 프로젝트 리스트
	@Override
	public List<ProjectVO> listProject(int userID) throws Exception {
		return session.selectList(namespace + ".listProject", userID);
	}

	// 프로젝트 상태 변경(가리기/완전숨기기) & title 변경
	@Override
	public void modifyProject(ProjectVO vo) throws Exception {
		session.update(namespace + ".modifyProject", vo);
	}

	@Override
	public ProjectVO titleName(int p_id) throws Exception {
		return session.selectOne(namespace+".titleName",p_id);
	}

	@Override
	public List<UserVO> teamProfile(int t_id) throws Exception {
		return session.selectList(namespace+".teamProfile",t_id);
	}

	@Override
	public int checkProject(ProjectVO vo) throws Exception {
		
		return session.selectOne(namespace+".checkProject",vo);
	}
	//숨기 프로젝트 리스트
	@Override
	public List<ProjectVO> hiddenList(int u_id) throws Exception {
		return session.selectList(namespace+".hiddenList",u_id);
	}
	//프로젝트 이름 바꾸기
	@Override
	public void modifiyTitle(ProjectVO vo) throws Exception {
		 session.update(namespace+".modifiyTitle",vo);
	}
	//프로젝트 즐겨찾기 추가
	@Override
	public void favoriteAdd(int u_id, int p_id) throws Exception {	
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("u_id",u_id);
		map.put("p_id",p_id);
		session.insert(namespace+".favoriteAdd",map);	
	}
	//즐겨찾기 리스트
	@Override
	public List<ProjectVO> favoriteList(int u_id) throws Exception {
		return  session.selectList(namespace+".favoriteList",u_id);
	}
	
	//즐겨찾기 삭제
	@Override
	public void favoriteDelete(int u_id, int p_id) throws Exception {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("u_id", u_id);
		map.put("p_id", p_id);
		session.delete(namespace+".favoriteDelete",map);
		
	}
	
	
	
	
}
