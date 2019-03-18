package cn.kepu.questionnaire.service;

import java.util.List;

import cn.kepu.questionnaire.pojo.EmergencyPlan;
import cn.kepu.questionnaire.pojo.Location;
import cn.kepu.questionnaire.pojo.Route;
import com.alibaba.fastjson.JSONObject;

public interface IRouteMapService {
	
	List<Route> checkRoutesInPlan(Integer planID, Integer zmLev);
	
	void savePoi(Location location);
	
	
	List<EmergencyPlan> chkSegs(Location location);
	
	List<List<Location>> driveWaysInPlan(Integer planID, Location firePoint);
	
	List<List<Location>> pathsInPlan(Integer planID, Location firePoint);
	
	List<List<Location>> poiInPlan(Integer planID, Location firePoint);
	
	Location repositionFP(Location firePoint);
	
	List<EmergencyPlan> srchPlanSkch(List<EmergencyPlan> emergencyPlans);
	
	JSONObject srchPlanDet(Integer planID);
		
}
