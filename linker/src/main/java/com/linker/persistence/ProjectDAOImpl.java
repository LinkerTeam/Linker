package com.linker.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.domain.ProjectVO;

@Repository
public class ProjectDAOImpl implements ProjectDAO {

	private static String namespace = "com.linker.mapper.projectMapper";

	@Inject
	SqlSession session;

	@Override
	public int createProject(ProjectVO vo) throws Exception {
		return session.insert(namespace+".createProject", vo);
	}

}
