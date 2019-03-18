package cn.kepu.questionnaire.service;


import cn.kepu.questionnaire.pojo.TnAssignDept;
import cn.kepu.questionnaire.pojo.TnNeedsQuestionnaire;
import cn.kepu.questionnaire.pojo.TnQuestionnaireItem;

import java.util.List;

public interface IQuesnrService {
		
	
	
	List<TnNeedsQuestionnaire> getQuesnrList();      //获取所有问卷

	int saveQsnBsnInfo(TnNeedsQuestionnaire tnNeedsQuestionnaire);  //存储问卷基本信息
	
	void saveQsnItm(TnQuestionnaireItem tnQuestionnaireItem);  //存储问卷问题及选项
	
	List<TnQuestionnaireItem> getQuesOfQsn(Integer basicInfoID);   //获取指定问卷的问题
	
	void fillItms(List<TnQuestionnaireItem> items);
	
	//----------------------------以下方法用于问卷预览---------------------------------
	TnNeedsQuestionnaire getBscInfo(Integer quesnrID);
	
	List<TnAssignDept> getAssndDept(Integer quesnrID);
	
}
