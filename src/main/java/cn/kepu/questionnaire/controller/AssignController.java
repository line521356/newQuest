package cn.kepu.questionnaire.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.kepu.questionnaire.pojo.TnNeedsQuestionnaire;
import cn.kepu.questionnaire.pojo.ZtreeNode;
import cn.kepu.questionnaire.service.IAssignService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;



@Controller
@RequestMapping("/assign")
public class AssignController {
				
	@Autowired
	@Qualifier("assignService")
	private IAssignService assignService;
	
	
	
	
	
	//------------------------------pure dispatcher----------------------------
	
	@RequestMapping("/orgSel")      //调试Ztree用
	public String toOrgSel(){
		return "AssignPages/ztreeTest";
	}
	
	
	
	//------------------------------functional dispatcher----------------------------
	
	
	/**
	 * Temp: 单个指定对象查询上一级单位/查询下一级单位，注释代码部分的实现思路是使用子部门与父部门一对一关系
	 * 绑定查询,不删是保存多对一查询完整实例
	 * @param map
	 * @return
	 * 
	 */
	@RequestMapping("/getOrgInfo")
	public String getOrgInfo(Map<String, Object> map){
		
//		EosorgTOrganization organization = new EosorgTOrganization();
//		organization = assignService.getOrg(89112997);
//		map.put("organization", organization);
//		
		map.put("chilOrgs", assignService.getChilOrgs(2));
		
		return "AssignPages/AssignOrg";
	}
	
	
	
	/**
	 * 查询当前对象的所有下一级机构
	 * @param orgId
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/getOrgInfo/{orgId}", method=RequestMethod.GET)
	public String getOrgChil(@PathVariable("orgId")Integer orgId, Map<String, Object> map){
		map.put("chilOrgs", assignService.getChilOrgs(orgId));
		return "AssignPages/AssignOrg";
	}
	
	
	/**
	 * 获取所有部门信息（生成树） 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/getAllOrgs", method=RequestMethod.POST)
	@ResponseBody
	public List<Object> findAllLibrary(HttpServletRequest request, HttpServletResponse response){
		Integer rootId = 2;		//给定树的根节点
		List<Object> resultList=assignService.getOrgsToZTree(rootId);
		return resultList;
	}
	
	/**
	 * 提交已选择的节点	
	 * @param ztreeNodes
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/subChkdNodes", method=RequestMethod.POST)
	public void getChekdObjects(@RequestBody List<ZtreeNode> ztreeNodes, HttpServletResponse response) throws Exception{
		assignService.transNSaveAssnDept(ztreeNodes);
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write("{\"result\":\"true\"}");
	}
	
	
	/**
	 * 该方法两个入口共用
	 * @param quesnrID
	 * @param map
	 * @return
	 */
	@RequestMapping("/{quesnrID}")
	public String toAssign(@PathVariable("quesnrID") Integer quesnrID, Map<String, Object> map){
		TnNeedsQuestionnaire temp_quesnr = new TnNeedsQuestionnaire();
		temp_quesnr.setID(quesnrID);
		map.put("currentQuesnr", temp_quesnr);
		map.put("testString", "this is a test string.");
		return "forward:/assign/orgSel";
	}
	
	
	
	
	
	
	
}
