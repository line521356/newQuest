package cn.kepu.questionnaire.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.kepu.questionnaire.pojo.TnNeedsQuestionnaire;
import cn.kepu.questionnaire.pojo.TnQuestionnaireItem;
import cn.kepu.questionnaire.service.IQuesnrService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



@Controller
@RequestMapping("/quesnr")
public class QuesnrController {
			
		@Autowired
		@Qualifier("quesnrService")
		private IQuesnrService quesnrService;
		
		
	    @InitBinder   
        public void initBinder(WebDataBinder binder) {       //��ʽ��  �������ַ�
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");   
            dateFormat.setLenient(true);   
            binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));   
        }  
	
		//--------------------------Pure dispatcher ---------------------------- 
		
		
	    @RequestMapping("/creatItemnChoice2")    //调试添加问卷问题与选项功能2  转发到整段HTML代码动态复制
		public String CrtQuesNChoi2(){
			return "QuesnrPages/creatQuesnrQues2";
		}
	
	
	    @RequestMapping("/creatItemnChoice3")    //采用Demo2的方法测试增删文本框
		public String CrtQuesNChoi3(){
			return "QuesnrPages/creatQuesnrQues3";
		}
		
		
		
		//------------------------------functional dispatcher----------------------------
		
		
	    /**
	     * 获取问卷列表
	     * @param map
	     * @return
	     */
	    @RequestMapping("/getQuestionnaires")
		public String listQuesnr(Map<String, Object> map){                           //��ȡ�����ʾ��б�
			List<TnNeedsQuestionnaire> questionnaires  = quesnrService.getQuesnrList();
			map.put("questionnaires", questionnaires);
			return "QuesnrList";
		}
		
		
		
		/**
		 * 创建问卷基本信息（GET）
		 * @param map
		 * @return
		 */
		@RequestMapping(value="/creatQuesnrInfo",method=RequestMethod.GET)     //�����ʾ�1����ת�����ʾ���Ϣ��д
		public String toCreatQuesnrInfo(Map<String, Object> map){
			map.put("questionnaire", new TnNeedsQuestionnaire());
			return "QuesnrPages/creatQuesnrInfo";
		}
		
		/**
		 * 这里跳转至问题设置界面提供两个入口，这里是入口1：从问卷列表设置问题
		 * @param map
		 * @param quesnrID
		 * @return
		 */
		@RequestMapping(value="/{quesnrID}", method=RequestMethod.GET)
		public String toCreatAptedQuesnrInfo(Map<String, Object> map, @PathVariable("quesnrID") Integer quesnrID){
			TnNeedsQuestionnaire temp_quesnr = new TnNeedsQuestionnaire();
			temp_quesnr.setID(quesnrID);
			map.put("tnQuestionnaireItems",quesnrService.getQuesOfQsn(quesnrID)); //从入口1进入问题设置有可能该问卷已经有设置好的问题
			map.put("currentQuesnr", temp_quesnr);
			return "QuesnrPages/creatQuesnrQues";
		}		
		
		/**
		 * 创建问卷基本信息(POST)
		 * 这里是设置问题入口2：从设置问卷基本信息按常规步骤跳转至设置问题
		 * @param tnNeedsQuestionnaire
		 * @return
		 */
		@RequestMapping(value="/creatQuesnrInfo", method=RequestMethod.POST)     //�����ʾ�2���洢����Ϣ����ת��������д
		public String CrtBscInfo(TnNeedsQuestionnaire tnNeedsQuestionnaire, Map<String, Object> map){
			quesnrService.saveQsnBsnInfo(tnNeedsQuestionnaire);
			map.put("currentQuesnr", tnNeedsQuestionnaire);
			return "QuesnrPages/creatQuesnrQues";
		}
		
		
		/**
		 * 设置问题
		 * @param tnQuestionnaireItem
		 * @param model
		 * @return
		 */
		@RequestMapping(value="/addQuesItem",method=RequestMethod.POST)         //�����ʾ�3�� Ԥ������       ɾ��ԭ��ֻ��Ԥ���������⣬ûʲô����
		public String addQuesItem(TnQuestionnaireItem tnQuestionnaireItem, Map<String, Object> map){
			
			quesnrService.saveQsnItm(tnQuestionnaireItem);
			TnNeedsQuestionnaire temp_quesnr = tnQuestionnaireItem.getTnNeedsQuestionnaire();
			int temp_quesnrID = temp_quesnr.getID();
			map.put("tnQuestionnaireItems",quesnrService.getQuesOfQsn(temp_quesnrID));
			map.put("currentQuesnr", temp_quesnr);
			return "QuesnrPages/creatQuesnrQues";
		}
		
		
		@RequestMapping("/chkNPreview/{quesnrID}")
		public String prevQuesnrInfo(@PathVariable("quesnrID") Integer quesnrID, Map<String, Object> map){
			map.put("quesnrBasicInfo", quesnrService.getBscInfo(quesnrID));
			map.put("assndDepts", quesnrService.getAssndDept(quesnrID));
			
			List<TnQuestionnaireItem> quesnrQues = quesnrService.getQuesOfQsn(quesnrID);
			quesnrService.fillItms(quesnrQues);
			map.put("quesnrQues", quesnrQues);
			
			return "QuesnrPages/preview";
		}
		
		
		
}
