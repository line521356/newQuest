package cn.kepu.questionnaire.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.StringJoiner;

import cn.kepu.questionnaire.pojo.Crew;
import cn.kepu.questionnaire.pojo.EmergencyPlan;
import cn.kepu.questionnaire.pojo.Location;
import cn.kepu.questionnaire.pojo.Route;
import cn.kepu.questionnaire.service.IEmerPlanService;
import cn.kepu.questionnaire.service.IRouteMapService;
import cn.kepu.questionnaire.service.ITrainingDataService;
import cn.kepu.questionnaire.service.impl.EmerPlanServiceImpl;
import cn.kepu.questionnaire.utils.ConstUtils;
import cn.kepu.questionnaire.utils.Wether;
import cn.kepu.questionnaire.utils.WetherUtil;
import com.alibaba.fastjson.JSONArray;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

@Controller
@RequestMapping("/map")
public class RouteMapController {
	
	
	@Autowired
	@Qualifier("routemapService")
	private IRouteMapService routemapService;

	@Autowired
	private ITrainingDataService iTrainingDataService;

	@Autowired
	private IEmerPlanService emerPlanService;
	

	//测试ARCGIS JS API
	@RequestMapping("/getMap")
	public String getMap(){
		return "MapPages/testMap";
	}
	
	//测试百度地图API
	@RequestMapping("/showMap")
	public String showMap(){
		return "MapPages/showMap";
	}
	
	//测试DIY+Canvas
	@RequestMapping("/mapView")
	public String mapView(){
		return "MapPages/mapNavigator";
	}
	
	@RequestMapping("/miniMap")
	public String miniMap(){
		return "MapPages/miniMap";
	}
	
	//测试多张图片一起加载
	@RequestMapping("/tileTrial")
	public String tileTrial(){
		return "MapPages/tileTrial";
	}
	
	/**
	 * 根据前台传来的地图级数和方案编号加载路径（后续将添加上其他POI）
	 * @param reqLoc
	 * @return
	 */
	@RequestMapping("/getRoute")
	@ResponseBody
	public JSONObject getRoute(@RequestBody Location reqLoc){		//这里以点作为参数逻辑上没有什么意义，只是前台数据要和后台bean对应，而location对象正好有这两个属性
		JSONObject result = new JSONObject();
		List<Location> driveWay = new ArrayList<Location>(); //最终返回给前端公路和小路两个点集
		List<Location> path = new ArrayList<Location>();

//		Route route = routemapService.checkSinRoute(reqLoc.getRtID(), reqLoc.getZmLev());	
//		result.put("points", route.getPoints());
		
		List<Route> routes = routemapService.checkRoutesInPlan(reqLoc.getZmLev(), reqLoc.getRtID());  //有点容易误会，这里传入的是放缩级别和方案ID，不是路径ID
		for(Route route : routes){
			if (route.getRtType() == 1) {
				driveWay.addAll(route.getPoints());
			} else {
				path.addAll(route.getPoints());
			}
		}
		result.put("driveWay", driveWay);
		result.put("path", path);
		return result;
	}
	
	/**
	 * 查看预案详情
	 * @return
	 */
	@RequestMapping("/planInfo")
	public String planInfo(){
		return "PlanPages/planInfo";
	}
	
	/**
	 * 跳转至像素坐标拾取页面（临时小工具：坐标拾取存储器）
	 * @return
	 */
	@RequestMapping("/locGetter")
	public String locGetter(){
		return "MapPages/pointGetter";
	}
	
	/**
	 * 接收前台传来的位置（临时小工具：坐标拾取存储器）
	 * @param location
	 * @return
	 */
	@RequestMapping("/sendLoc")
	@ResponseBody
	public JSONObject sendLoc(@RequestBody Location location){
		JSONObject result = new JSONObject();
		routemapService.savePoi(location);
		result.put("msg", 1);
		return result;
	}
	
	
	/**
	 * 测试路线的分段情况，后续需改写成根据火点位置获取预案
	 * Controller中的内容：
	 * 1、入参将改成只有火点位置   ---根据火点位置判断预案的ID  一个函数
	 * 2、根据预案ID加载预案中的所有内容   ---另一个函数
	 * @param location
	 * @return
	 */
	@RequestMapping("/testSegment")
	@ResponseBody
	public JSONObject testSegment(@RequestBody Location location){
		JSONObject result = new JSONObject();
		List<List<Location>> poisInPlan = null;
		Integer scorePlanID;     //被最终选定的预案ID
		
		if (location.getZmLev() > 1) {//放大地图重定位火点
			location = routemapService.repositionFP(location);
		}
		String lon = ConstUtils.mapxToGps(location.getPointX()+"");
		String lat = ConstUtils.mapyToGps(location.getPointY()+"");

		Wether wether = null;
		try {
			wether = WetherUtil.getNowWether(lon,lat);
		} catch (Exception e) {
			e.printStackTrace();
		}
		//训练数据
		List <String> row = new ArrayList<>();

		row.add(Double.parseDouble(wether.getPrecipitation())>2?"大":"小");
		Double temp = Double.parseDouble(wether.getTemperature());
		if(temp<0){
			row.add("<0");
		}else if(temp<8){
			row.add("0-8");
		}else if(temp<18){
			row.add("8-18");
		}else{
			row.add(">=18");
		}
		Double wind = Double.parseDouble(wether.getWindPower());
		if(wind>4){
			row.add(">4");
		}else{
			row.add("<4");
		}
		Double rh = Double.parseDouble(wether.getHumidity());
		if(rh<50){
			row.add("<50");
		}else if(rh<65){
			row.add("50-65");
		}else if(rh<80){
			row.add("65-80");
		}else{
			row.add(">=80");
		}

		scorePlanID = iTrainingDataService.trainData(row);
		result.put("availablePlans", scorePlanID);
		if(scorePlanID == null){
			result.put("msg", 0);
			return result;
		}

		List <Location> locations = emerPlanService.selAllLocation(location.getZmLev());
		Integer endId = null;
		Double min = 10000D;
		for (Location location1 : locations) {
			Double tmp = Math.sqrt((location1.getPointX()-location.getPointX())*(location1.getPointX()-location.getPointX())+(location1.getPointY()-location.getPointY())*(location1.getPointY()-location.getPointY()));
			if(tmp<min){
				endId = location1.getRtID();
				min = tmp;
			}
		}
		EmergencyPlan emergencyPlan  = emerPlanService.selPlanByID(scorePlanID);
		List <String> routsStrList = new ArrayList<>();
		List <String> wayList = Arrays.asList(emergencyPlan.getCrew().split(","));
		for (String s : wayList) {

			Crew crew = emerPlanService.selCrewById(Integer.parseInt(s));
			JSONObject wayResult = emerPlanService.srchRoutes(crew.getRtID(), endId);
			JSONArray jsonArray = wayResult.getJSONArray("routes");
			for (Object o : jsonArray) {
				routsStrList.add(JSONObject.parseObject(JSONObject.toJSONString(o),Route.class).getRtID()+"");
			}
		}

		emergencyPlan.setRoutes(StringUtils.join(routsStrList,","));
		emergencyPlan.setArrTime(null);
		emerPlanService.updatePlanRoute(emergencyPlan);

		List<List<Location>> driveWay = routemapService.driveWaysInPlan(scorePlanID, location);
		List<List<Location>> path = routemapService.pathsInPlan(scorePlanID, location);
		poisInPlan = routemapService.poiInPlan(scorePlanID, location);

		if (poisInPlan.size() < 3) {        //物资点、人员驻扎点、水源点是否齐全
			result.put("msg", 0);
			return result;
		}

		result.put("driveWay", driveWay);
		result.put("path", path);
		result.put("materials", poisInPlan.get(0));
		result.put("watersource", poisInPlan.get(1));
		result.put("crewStays", poisInPlan.get(2));
		result.put("scorePlanID", scorePlanID);
		result.put("msg", 1);

		return result;
	}
	
	
	/**
	 * 火点重定位（用于放缩）
	 * @param location
	 * @return
	 */
	@RequestMapping("/repositionFP")
	@ResponseBody
	public JSONObject repositionFP(@RequestBody Location location){
		JSONObject result = new JSONObject();
		if (location.getZmLev() > 1) {										//放大地图重定位火点
			location = routemapService.repositionFP(location);
		}
		result.put("fpX", location.getPointX());
		result.put("fpY", location.getPointY());
		result.put("msg", 1);
		return result;
	}
	
	/**
	 * 小窗口-切换预案-获取预案梗概
	 * @return
	 */
	@RequestMapping("/planSketch")
	@ResponseBody
	public JSONObject planSketch(@RequestBody List<EmergencyPlan> emergencyPlans){
		JSONObject result = new JSONObject();
		List<EmergencyPlan> skchPlans = routemapService.srchPlanSkch(emergencyPlans);
		result.put("msg", 1);
		result.put("skchPlans", skchPlans);
		return result;
	}
	
	/**
	 * 小窗口-获取当前预案的详情
	 * @return
	 */
	@RequestMapping("/planDetInfo")
	@ResponseBody
	public JSONObject planDetInfo(@RequestBody Location location){			//这个入参没有实际意义，只是为了绑定方便和节约时间，里面只有当前预案的ID
		JSONObject result = routemapService.srchPlanDet(location.getRtID());
		return result;
	}	
	
}
