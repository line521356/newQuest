package cn.kepu.questionnaire.service;

import java.util.List;

import cn.kepu.questionnaire.pojo.*;
import com.alibaba.fastjson.JSONObject;


public interface IEmerPlanService {

	
	JSONObject srchRoutes(Integer stRtID, Integer endRtID);
	
	JSONObject rvdRoutes(String rtSerial);
	
	JSONObject srchPois(EmergencyPlan emergencyPlan);
	
	JSONObject rvdMats(String matSerial);
	
	void rvdMat(Material material);
	
	void rvdWat(WaterSource waterSource);
	
	void rvdCrew(Crew crew);
	
	JSONObject rvdWats(String watSerial);
	
	JSONObject PlanAllList(Integer page, Integer limit);
	
	JSONObject ffSrcList(Integer listTyep, Integer page, Integer limit);

	EmergencyPlan selPlanByID(Integer planID);
	
	void createPlan(EmergencyPlan emergencyPlan);
	
	void createMats(Material material);
	
	void createWats(WaterSource waterSource);
	
	void createCrew(Crew crew);
	
	void updatePlan(EmergencyPlan emergencyPlan);
	
	List<EmergencyPlan> srchPlans(Integer kwType, String keyWord);
	
	JSONObject srchSrcs(Integer kwType, String keyWord, Integer listType, Integer page, Integer limit);
	
	void delPlan(Integer planID);
	
	void delSrc(Integer listType, Integer srcID);
	
	Material priMatInfo(Integer matID);
	
	WaterSource priWatInfo(Integer watSrID);
	
	Crew priCrewInfo(Integer crewID);

	List<Location> selAllLocation(Integer zmLev);

	void updatePlanRoute(EmergencyPlan emergencyPlan);
}
