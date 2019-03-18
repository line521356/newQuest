package cn.kepu.questionnaire.dao;


import java.util.List;
import java.util.Map;

import cn.kepu.questionnaire.pojo.TnAssignDept;
import cn.kepu.questionnaire.pojo.TnNeedsQuestionnaire;
import cn.kepu.questionnaire.pojo.TnQuestionnaireItem;
import cn.kepu.questionnaire.pojo.TnQuestionnaireItemChoice;
import org.apache.ibatis.annotations.Param;




public interface IQuesnrDao {
		
		
		List<TnNeedsQuestionnaire> selAllQuesnrs();
		
		
//		void istQsnBscInfo(TnNeedsQuestionnaire tnNeedsQuestionnaire);
		
		
		int istQsnBscInfo(TnNeedsQuestionnaire tnNeedsQuestionnaire);
				
		int istQsnItm(TnQuestionnaireItem tnQuestionnaireItem);
		
		void istQsnCho(List<TnQuestionnaireItemChoice> choices);
		
		List<TnQuestionnaireItem> selQsnItmByQsnId(Integer basicInfoID);
		
		List<TnQuestionnaireItemChoice> selItmChoByItmId(Integer itemID);
		
		//----------------------------以下方法用于预览-------------------------------------
		
		TnNeedsQuestionnaire selQsnBscInfo(Integer quesnrID);
		
		List<TnAssignDept> selAssnDeptByQIDWithOrg(@Param("quesnrID") Integer quesnrID);
		
		
}
