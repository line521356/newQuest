package cn.kepu.questionnaire.service.impl;


import java.util.Iterator;
import java.util.List;
import java.util.Map;

import cn.kepu.questionnaire.dao.IQuesnrDao;
import cn.kepu.questionnaire.pojo.TnAssignDept;
import cn.kepu.questionnaire.pojo.TnNeedsQuestionnaire;
import cn.kepu.questionnaire.pojo.TnQuestionnaireItem;
import cn.kepu.questionnaire.pojo.TnQuestionnaireItemChoice;
import cn.kepu.questionnaire.service.IQuesnrService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service("quesnrService")
public class QuesnrServiceImpl implements IQuesnrService {

	@Autowired
	private IQuesnrDao quesnrDao;

	
	
	public List<TnNeedsQuestionnaire> getQuesnrList(){
		return quesnrDao.selAllQuesnrs();
	}
	

	public int saveQsnBsnInfo(TnNeedsQuestionnaire tnNeedsQuestionnaire){
		return quesnrDao.istQsnBscInfo(tnNeedsQuestionnaire);
	}
	
	public List<TnQuestionnaireItem> getQuesOfQsn(Integer basicInfoID){
		return quesnrDao.selQsnItmByQsnId(basicInfoID);		
	}
	
	//----------------------------以下方法用于问卷预览---------------------------------
	public TnNeedsQuestionnaire getBscInfo(Integer quesnrID){
		return quesnrDao.selQsnBscInfo(quesnrID);
	}
	
	public List<TnAssignDept> getAssndDept(Integer quesnrID){
		List<TnAssignDept> assignDepts = quesnrDao.selAssnDeptByQIDWithOrg(quesnrID);
		return assignDepts;
//		return quesnrDao.selAssnDeptByQIDWithOrg(quesnrID);
	}
	
	public List<TnQuestionnaireItemChoice> getChoices(Integer itemID){
		return quesnrDao.selItmChoByItmId(itemID);
	}
	//----------------------------以上方法用于问卷预览---------------------------------
	
	/**
	 * 存储问题Item对象和其对应的选项Choices对象集合
	 * @param TnQuestionnaireItem
	 * @author SilWhale_Make
	 */
	public void saveQsnItm(TnQuestionnaireItem tnQuestionnaireItem){		
	
		int ItmId;
		char choiceCode = 'A';
		
		quesnrDao.istQsnItm(tnQuestionnaireItem);   //存储Item对象						
		ItmId = tnQuestionnaireItem.getID();   //取存储Item对象的ID
		List<TnQuestionnaireItemChoice> choices = tnQuestionnaireItem.getChoices();	  //所有Choice选项赋值多对一字段：ItemID	
		
//		for(int i = 0; i < choices.size(); i++){
//			TnQuestionnaireItemChoice choice_temp = choices.get(i);
//			choice_temp.setTnQuestionnaireItem(new TnQuestionnaireItem());
//			TnQuestionnaireItem item_temp = choice_temp.getTnQuestionnaireItem();
//			item_temp.setID(ItmId);
//		} 
		
		for(TnQuestionnaireItemChoice choice:choices){			
			TnQuestionnaireItemChoice choice_temp = choice;
			choice_temp.setTnQuestionnaireItem(new TnQuestionnaireItem());
			TnQuestionnaireItem item_temp = choice_temp.getTnQuestionnaireItem();
			item_temp.setID(ItmId);
			choice_temp.setChoiceCode(choiceCode++);
		}
		
		if(tnQuestionnaireItem.getHasOtherInput() > 0){  //判断本题是否含有其他选项，若有则添加一个其他选项
			TnQuestionnaireItemChoice choice_other = new TnQuestionnaireItemChoice();
			choice_other.setChoiceContent("其他");
			choice_other.setAllowOtherInput(1);
			choice_other.setTnQuestionnaireItem(new TnQuestionnaireItem());
			choice_other.getTnQuestionnaireItem().setID(ItmId);
			choice_other.setChoiceCode(choiceCode);
			choices.add(choice_other);
		}
		
		quesnrDao.istQsnCho(choices);    //存储choice集合
	}
	
	
	public void fillItms(List<TnQuestionnaireItem> items){		
		
		//迭代方式1
//		for(int i=0; i<items.size(); i++){
//			TnQuestionnaireItem item_temp = items.get(i);
//			item_temp.setChoices(getChoices(item_temp.getID()));
//		}
		
		//迭代方式2
//		Iterator<TnQuestionnaireItem> iter=items.iterator();
//		while(iter.hasNext()){
//			TnQuestionnaireItem item_temp = iter.next();
//			item_temp.setChoices(getChoices(item_temp.getID()));
//		}
		
		//迭代方式3
		for(TnQuestionnaireItem item:items){
			TnQuestionnaireItem item_temp = item;
			item_temp.setChoices(getChoices(item_temp.getID()));
		}
		
	}
	
	
}
