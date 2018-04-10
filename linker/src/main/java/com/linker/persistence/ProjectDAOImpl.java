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

	// 프로젝트 달성&프로젝트 가리기(숨기기)&프로젝트 이름변경
	@Override
	public int modifyProject(ProjectVO vo) throws Exception {
		return session.update(namespace + ".modifyProject", vo);
	}
    
	//프로젝트 타이틀 가져오기
	@Override
	public ProjectVO titleName(int p_id) throws Exception {
	
		return session.selectOne(namespace+".titleName",p_id);
	}

	//로그인한 회원의 모든팀의 각각의 프로필사진가져오기
	@Override
	public List<UserVO> teamProfile(int t_id) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".teamProfile",t_id);
	}
    
	//프로젝트 가리기
	@Override
	public void hiddenProject(int p_id) throws Exception {
		
		session.update(namespace+".hiddenProject",p_id);
		
	}

	//프로젝트 리오픈
	@Override
	public void reopenProject(int p_id) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace+".reopenProject",p_id);
	}
	
	//프로젝트 삭제 
	@Override
	public void deleteProject(int p_id) throws Exception {
		session.update(namespace+".deleteProject",p_id);
		
	}

	//프로젝트 상태 체크
	@Override
	public ProjectVO projectstatus(int p_id, int t_id) throws Exception {
		
		Map<String,Integer> map = new HashMap<String,Integer>();
		 map.put("p_id", p_id);
		 map.put("t_id", t_id);
		
		 System.out.println(map.toString());
		return session.selectOne(namespace+".projectstatus",map);
	}

	
	
 
	
	
}
