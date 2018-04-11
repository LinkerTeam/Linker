package com.linker.persistence;

import java.util.List;

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
		System.out.println(vo.toString());
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
	
}
