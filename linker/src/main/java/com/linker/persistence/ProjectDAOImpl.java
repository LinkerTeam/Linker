package com.linker.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.domain.ProjectVO;

@Repository
public class ProjectDAOImpl implements ProjectDAO {

	private static String namespace = "com.linker.mapper.projectMapper";
   
	
	@Inject
	SqlSession session;
	


	// 프로젝트 생성
	@Override
	public int createProject(ProjectVO vo) throws Exception {
		return session.insert(namespace+".createProject", vo);
	}

	// 프로젝트 리스트
	@Override
	public List<ProjectVO> listProject(int teamID) throws Exception {
		return session.selectList(namespace+".listProject", teamID);
	}


	// 프로젝트 달성&프로젝트 가리기(숨기기)&프로젝트 이름변경
	@Override
	public int modifyProject(ProjectVO vo) throws Exception {
		return session.update(namespace+".modifyProject", vo);
	}

}
