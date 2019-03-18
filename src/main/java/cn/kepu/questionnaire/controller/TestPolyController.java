package cn.kepu.questionnaire.controller;

import java.util.HashSet;


import cn.kepu.questionnaire.pojo.testPolyDaughter;
import cn.kepu.questionnaire.pojo.testPolyFather;
import cn.kepu.questionnaire.pojo.testPolySon;
import cn.kepu.questionnaire.service.ITestPolyFatherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * TestPoly这一系列的接口和类均保存，以后还需要测试什么内容也方便
 * 
 * 0725 测试内容：
 * 1、Mybatis对继承的支持：支持，可以查子类表返回父类对象，但是仍然没法解决当前问题，因为多态是基于方法重写的
 * 2、发现新大陆之HashMap与HashSet: 可以满足后续联表查询时实现一个集合中有多个不同类型的对象
 * 3、最后保存的这个getSons()方法是为了测试HashSet集合中不允许存储相同对象，可以看到我加了3个对象，实际输出的size
 *    是2，同样的对象存储时，add()方法会返回false
 *    
 * 0726 测试内容
 * 1、Mybatis对HashSet的支持如何: 不支持 所有函数已经删除
 * @author SilentWhale
 *
 */

@Controller
@RequestMapping("/poly")
public class TestPolyController {

	@Autowired
	@Qualifier("itestPolyFatherService")
	private ITestPolyFatherService testPolyFatherService;
	
    //0725 测试函数	
	@RequestMapping("/getSons")
	public String getSons(){
		//List<testPolySon> sons = testPolyFatherService.getSons();
		HashSet<testPolyFather> fathers = new HashSet<testPolyFather>();
		testPolySon son = new testPolySon(2, "many");
		testPolyDaughter daughter = new testPolyDaughter(4, "little");
		
		fathers.add(son);
		fathers.add(son);
		fathers.add(daughter);
		
		System.out.println(fathers.size());
		
		System.out.println(fathers);
		//System.out.println(sons);
		return "";
	}
	
	
	
	
}
