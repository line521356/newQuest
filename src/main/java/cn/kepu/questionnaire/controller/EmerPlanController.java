package cn.kepu.questionnaire.controller;

import java.util.List;


import cn.kepu.questionnaire.pojo.*;
import cn.kepu.questionnaire.service.IEmerPlanService;
import cn.kepu.questionnaire.service.IRouteMapService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;


/**
 * 扑火预案与扑救资源controller
 */

@Controller
@RequestMapping("/emrPlan")
public class EmerPlanController {

	@Autowired
	@Qualifier("emerPlanService")
	private IEmerPlanService emerPlanService;
	
	@Autowired
	@Qualifier("routemapService")
	private IRouteMapService routemapService;
	
	/**
	 * 创建新的预案
	 * @return
	 */
	@RequestMapping("/createNew")
	public String createNew(){
		return "PlanPages/createPlan";
	}
	
	@RequestMapping("/planList")
	public String planList(){
		return "PlanPages/planList";
	}
	
	@RequestMapping("/locateSrc")
	public String locateSrc(){
		return "PlanPages/locateSrc";
	}
	
	@RequestMapping("/detInfoWin")
	public String detInfoWin(){
		return "PlanPages/planDetInfo";
	}
	
	@RequestMapping("/revInfoWin")
	public String revInfoWin(){
		return "PlanPages/revisePlan";
	}
	
	@RequestMapping("/ffSrcList")
	public String ffSrcList(){
		return "PlanPages/ffSrcList";
	}
	
	@RequestMapping("/toCreateMat")
	public String toCreateMat(){
		return "PlanPages/createMat";
	}
	
	@RequestMapping("/toCreateWat")
	public String toCreateWat(){
		return "PlanPages/createWat";
	}
	
	@RequestMapping("/toCreateCrew")
	public String toCreateCrew(){
		return "PlanPages/createCrew";
	}
	
	@RequestMapping("/toRvdMat")
	public String toRvdMat(){
		return "PlanPages/reviseMat";
	}
	
	@RequestMapping("/toRvdWat")
	public String toRvdWat(){
		return "PlanPages/reviseWat";
	}
	
	@RequestMapping("/toRvdCrew")
	public String toRvdCrew(){
		return "PlanPages/reviseCrew";
	}
	
	/**
	 * 获取最短路径
	 * @param location
	 * @return
	 */
	@RequestMapping("/countRts")
	@ResponseBody
	public JSONObject countRts(@RequestBody Location location){
		JSONObject result = new JSONObject();
		result = emerPlanService.srchRoutes(location.getZmLev(), location.getRtID());  //绑定入参方便，实际是起始和终点路径的ID
		result.put("msg", 1);
		return result;
	}
	
	/**
	 * 用户修改路径，获取路径信息
	 * @param emergencyPlan
	 * @return
	 */
	@RequestMapping("/reviseRts")
	@ResponseBody
	public JSONObject rvdRts(@RequestBody EmergencyPlan emergencyPlan){
		JSONObject result = new JSONObject();
		result = emerPlanService.rvdRoutes(emergencyPlan.getRoutes());  //绑定入参方便，实际只有用户修改后输入的路径ID序列
		return result;
	}
	
	/**
	 * 查询物资点或水源点
	 * @param emergencyPlan
	 * @return
	 */
	@RequestMapping("/srchPois")
	@ResponseBody
	public JSONObject srchPois(@RequestBody EmergencyPlan emergencyPlan){
		JSONObject result = new JSONObject();
		result = emerPlanService.srchPois(emergencyPlan);  //绑定入参方便，实际只有用户选择的POI点ID序列（新建是单个，修改是多个）
		return result;
	}
	
	/**
	 * 用户修改预案中的物资点-获取物资点信息
	 * @param emergencyPlan
	 * @return
	 */
	@RequestMapping("/rvdMats")
	@ResponseBody
	public JSONObject rvdMats(@RequestBody EmergencyPlan emergencyPlan){
		JSONObject result = new JSONObject();
		result = emerPlanService.rvdMats(emergencyPlan.getMaterials());  //绑定入参方便，实际只有用户修改后输入的路径ID序列
		return result;
	}
	
	/**
	 * 修改物资点信息-单个
	 * @param material
	 * @return
	 */
	@RequestMapping("/rvdMat")
	@ResponseBody
	public JSONObject rvdMat(@RequestBody Material material){
		JSONObject result = new JSONObject();
		emerPlanService.rvdMat(material);
		result.put("msg", 1);
		return result;
	}
	
	/**
	 * 用户修改水源点，获取水源点信息
	 * @param emergencyPlan
	 * @return
	 */
	@RequestMapping("/rvdWats")
	@ResponseBody
	public JSONObject rvdWats(@RequestBody EmergencyPlan emergencyPlan){
		JSONObject result = new JSONObject();
		result = emerPlanService.rvdWats(emergencyPlan.getWatersource());  //绑定入参方便，实际只有用户修改后输入的路径ID序列
		return result;
	}
	
	/**
	 * 修改水源点信息-单个
	 * @param waterSource
	 * @return
	 */
	@RequestMapping("/rvdWat")
	@ResponseBody
	public JSONObject rvdWat(@RequestBody WaterSource waterSource){
		JSONObject result = new JSONObject();
		emerPlanService.rvdWat(waterSource);
		result.put("msg", 1);
		return result;
	}
	
	/**
	 * 修改人员信息-单个
	 * @param crew
	 * @return
	 */
	@RequestMapping("/rvdCrew")
	@ResponseBody
	public JSONObject rvdCrew(@RequestBody Crew crew){
		JSONObject result = new JSONObject();
		emerPlanService.rvdCrew(crew);
		result.put("msg", 1);
		return result;
	}
	
	/**
	 * 预案全列表
	 * @param page
	 * @param limit
	 * @return
	 */
	@RequestMapping("/chkAllPlans")
	@ResponseBody
    public JSONObject chkHandledRecs(Integer page, Integer limit){
    	JSONObject resObj = new JSONObject();    	
    	resObj = emerPlanService.PlanAllList(page, limit);  	
    	return resObj;
    }
	
	/**
	 * 提交新建预案
	 * @param emergencyPlan
	 * @return
	 */
	@RequestMapping("/submitNewPlan")
	@ResponseBody
	public JSONObject submitNewPlan(@RequestBody EmergencyPlan emergencyPlan){
		JSONObject result = new JSONObject();
		emerPlanService.createPlan(emergencyPlan);
		result.put("msg", 1);
		return result;
	}
	
	/**
	 * 提交新物资点
	 * @param material
	 * @return
	 */
	@RequestMapping("/submitNewMat")
	@ResponseBody
	public JSONObject submitNewMat(@RequestBody Material material){
		JSONObject result = new JSONObject();
		emerPlanService.createMats(material);
		return result;
	}
	
	/**
	 * 提交新的人员
	 * @return
	 */
	@RequestMapping("/submitNewCrew")
	@ResponseBody
	public JSONObject submitNewCrew(@RequestBody Crew crew){
		JSONObject result = new JSONObject();
		emerPlanService.createCrew(crew);
		return result;
	}
	
	/**
	 * 提交新水源点
	 * @param waterSource
	 * @return
	 */
	@RequestMapping("/submitNewWat")
	@ResponseBody
	public JSONObject submitNewWat(@RequestBody WaterSource waterSource){
		JSONObject result = new JSONObject();
		emerPlanService.createWats(waterSource);
		return result;
	}
	
	/**
	 * 更新预案
	 * @param emergencyPlan
	 * @return
	 */
	@RequestMapping("/updatePlan")
	@ResponseBody
	public JSONObject updatePlan(@RequestBody EmergencyPlan emergencyPlan){
		JSONObject result = new JSONObject();
		emerPlanService.updatePlan(emergencyPlan);
		result.put("msg", 1);
		return result;
	}
	
	/**
	 * 搜索预案
	 * @param page
	 * @param limit
	 * @param kwTyep
	 * @param keyWord
	 * @return
	 */
	@RequestMapping("/srchPlan")
	@ResponseBody
	public JSONObject srchPlan(Integer page, Integer limit, Integer kwTyep, String keyWord){		//搜索类型：priority 关键词:planName
		JSONObject result = new JSONObject();
		List<EmergencyPlan> plans = emerPlanService.srchPlans(kwTyep, keyWord);
		result.put("count", plans.size());							//分页
		if (page * limit < plans.size()) {
			plans = plans.subList((page-1)*limit, page*limit);
		} else {
			plans = plans.subList((page-1)*limit, plans.size());
		}
		result.put("data", plans);
		result.put("code", 0);
		result.put("msg", "");
		return result;
	}
	
	/**
	 * 搜索扑救资源
	 * @param page
	 * @param limit
	 * @param kwTyep
	 * @param keyWord
	 * @return
	 */
	@RequestMapping("/srchSrcs")
	@ResponseBody
	public JSONObject srchSrcs(Integer page, Integer limit, Integer kwType, String keyWord, Integer listType){		//搜索类型：priority 关键词:planName
		JSONObject result = emerPlanService.srchSrcs(kwType, keyWord, listType, page, limit);
		return result;
	}
	
	/**
	 * 删除预案
	 * @param emergencyPlan
	 * @return
	 */
	@RequestMapping("/delPlan")
	@ResponseBody
	public JSONObject delPlan(@RequestBody EmergencyPlan emergencyPlan){		//搜索类型：priority 关键词:planName
		JSONObject result = new JSONObject();
		emerPlanService.delPlan(emergencyPlan.getPlanID());
		result.put("msg", "1");
		return result;
	}
	
	/**
	 * 获取列表中预案的详情
	 * @param emergencyPlan
	 * @return
	 */
	@RequestMapping("/detInfo")
	@ResponseBody
	public JSONObject planDetInfo(@RequestBody EmergencyPlan emergencyPlan){			//这个入参没有实际意义，只是为了绑定方便和节约时间，里面只有当前预案的ID
		JSONObject result = routemapService.srchPlanDet(emergencyPlan.getPlanID());
		return result;
	}
	
	/**
	 * 修改预案回显原预案信息
	 * @param emergencyPlan
	 * @return
	 */
	@RequestMapping("/priInfo")
	@ResponseBody
	public JSONObject priInfo(@RequestBody EmergencyPlan emergencyPlan){			//这个入参没有实际意义，只是为了绑定方便和节约时间，里面只有当前预案的ID
		JSONObject result = routemapService.srchPlanDet(emergencyPlan.getPlanID());  
		return result;
	}
	
	/**
	 * 修改物资点信息-回显原物资点信息
	 * @param material
	 * @return
	 */
	@RequestMapping("/priMat")
	@ResponseBody
	public JSONObject priMat(@RequestBody Material material){
		JSONObject result = new JSONObject();
		result.put("priMat", emerPlanService.priMatInfo(material.getMatID()));
		result.put("msg", 1);
		return result;
	}
	
	/**
	 * 修改水源点信息-回显原水源点信息
	 * @param waterSource
	 * @return
	 */
	@RequestMapping("/priWat")
	@ResponseBody
	public JSONObject priWat(@RequestBody WaterSource waterSource){
		JSONObject result = new JSONObject();
		result.put("priWat", emerPlanService.priWatInfo(waterSource.getWatSrID()));
		result.put("msg", 1);
		return result;
	}
	
	/**
	 * 修改人员信息-回显原人员信息
	 * @param crew
	 * @return
	 */
	@RequestMapping("/priCrew")
	@ResponseBody
	public JSONObject priCrew(@RequestBody Crew crew){
		JSONObject result = new JSONObject();
		result.put("priCrew", emerPlanService.priCrewInfo(crew.getCrewID()));
		result.put("msg", 1);
		return result;
	}
	
	/**
	 * 全扑救资源列表
	 * @param emergencyPlan
	 * @return
	 */
	@RequestMapping("/allffSrcList")
	@ResponseBody
	public JSONObject ffSrcList(Integer listType, Integer page, Integer limit){			//这个入参没有实际意义，只是为了绑定方便和节约时间，里面只有当前预案的ID
		JSONObject result = emerPlanService.ffSrcList(listType, page, limit);  
		return result;
	}
	
	/**
	 * 删除扑救资源
	 * @param emergencyPlan
	 * @return
	 */
	@RequestMapping("/delffSrc")
	@ResponseBody
	public JSONObject delffSrc(@RequestBody Material material){			//TransCar: 扑救资源类型  matID: 扑救资源ID
		JSONObject result = new JSONObject();
		emerPlanService.delSrc(material.getTransCar(), material.getMatID());
		result.put("msg", 1);
		return result;
	}
		
	
}
