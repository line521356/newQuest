package cn.kepu.questionnaire.controller;



import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import cn.kepu.questionnaire.pojo.Activity;
import cn.kepu.questionnaire.service.IActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/act")
public class ActivityController {
	
	@Autowired
	@Qualifier("activityService")
	private IActivityService activityService;
	
	
	//-------------------------pure dispatcher---------------------- 
	
	@RequestMapping("/testReact")   //测试 react ： 从后台获取单个对象
	public String toActCentre(){
		return "ActivityPages/actCentre2";
	}
	
	@RequestMapping("/testReact2")   //测试 react ： 从后台获取对象集合
	public String toActCentre2(){
		return "ActivityPages/actCentre3";
	}
	
	@RequestMapping("/toActBoard")
	public String toActBoard(){
		return "ActivityPages/actBoard";
	}
	
	//TODO 测试成功 等待修改为正式版本
	@RequestMapping("/toActBoard2")     //测试使用LayUI渲染界面 
	public String toActBoard2(){
		return "ActivityPages/actBoard2";
	}
	
	//-------------------------functional dispatcher----------------
	
	@RequestMapping(value = "/creatAct", method=RequestMethod.GET) 
	public String toCreateAct(){
		return "ActivityPages/createAct";
	}
	
	
	@RequestMapping(value = "/creatAct", method=RequestMethod.POST)
	public String creatAct(Model model, Activity activity, MultipartFile actPic) throws Exception{
		activityService.saveNewAct(activity, actPic);
		model.addAttribute("currentActivity", activity);		
		return "ActivityPages/actCentre";
	}
	
	
	/**
	 * 这里使用AJAX的传输方式从后台获取所有活动的集合(Json字符串)
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/getAllActs", method=RequestMethod.POST)
	@ResponseBody
	public List<Object> getAllActs(){
//		List<Object> testArray = new ArrayList<Object>();
//		testArray.add("{actId:'1',actName:'测试活动1',actIntro:'测试活动1',actPicUrl:'d562a146-2aff-41ed-a170-518c4b05cca1.jpg'}");
//		testArray.add("{actId:'2',actName:'测试活动2',actIntro:'测试活动2',actPicUrl:'02eac4c4-14c1-42a8-8355-681262e11842.jpg'}");
//		testArray.add("{actId:'3',actName:'与福尔摩斯的亲密接触',actIntro:'I dont guess, I obsearve',actPicUrl:'5b3e0b1f-272e-43aa-bc8a-9a1c9c1c5eac.jpg'}");
//		testArray.add("{actId:'4',actName:'测试活动3',actIntro:'测试活动3',actPicUrl:'33002133-9594-4b32-9c34-44e346bd271f.jpg'}");
//		testArray.add("{actId:'5',actName:'测试活动4',actIntro:'测试活动4',actPicUrl:'a2174a0c-3d30-4ed2-84f3-c07b4b78f9d0.jpg'}");
//		testArray.add("{actId:'6',actName:'梦中的福尔摩斯',actIntro:'I dont guess, I observe and deduce.',actPicUrl:'0f27f868-6b7e-44c0-be12-902f35e6f229.jpg'}");
//		testArray.add("{actId:'7',actName:'活动0711',actIntro:'这是一个测试活动',actPicUrl:'92b96be3-2e92-4bb4-ae32-6705749301fc.jpg'}");
		List<Object> testArray = activityService.actsListJson();
		System.out.println(testArray);
		return testArray;
	}
	
	
}
