package cn.kepu.questionnaire.service.impl;

import java.util.HashSet;
import java.util.List;

import cn.kepu.questionnaire.dao.ITestPolyFatherDao;
import cn.kepu.questionnaire.pojo.testPolySon;
import cn.kepu.questionnaire.service.ITestPolyFatherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("itestPolyFatherService")
public class TestPolyFatherServiceImpl implements ITestPolyFatherService {
	
	@Autowired
	private ITestPolyFatherDao testPolyFatherDao;
	
	public List<testPolySon> getSons(){
		return testPolyFatherDao.selSonsAsFather();
	}
	
	
	
}
