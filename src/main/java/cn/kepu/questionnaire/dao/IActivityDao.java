package cn.kepu.questionnaire.dao;

import java.util.List;

import cn.kepu.questionnaire.pojo.Activity;

public interface IActivityDao {
	
	void istAct(Activity activity);
	
	List<Activity> selAllActs();
}
