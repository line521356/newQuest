package cn.kepu.questionnaire.service.impl;



import java.awt.geom.RectangularShape;
import java.net.Inet4Address;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import cn.kepu.questionnaire.dao.IEmerPlanDao;
import cn.kepu.questionnaire.dao.IRouteMapDao;
import cn.kepu.questionnaire.pojo.*;
import cn.kepu.questionnaire.service.IEmerPlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;



@Service("emerPlanService")
public class EmerPlanServiceImpl implements IEmerPlanService {

	@Autowired
	private IRouteMapDao routeMapDao;
	
	@Autowired
	private IEmerPlanDao emerPlanDao;
	
	/**
	 * 计算最短路径
	 */
	public JSONObject srchRoutes(Integer stRtID, Integer endRtID){
		JSONObject result = new JSONObject();
		List<Route> passRoutes = new ArrayList<Route>();
//		String passRtsStr = emerPlanDao.selRtMapByStEdID(stRtID, endRtID);	之前用数据库存储最短路径		
		stRtID = emerPlanDao.selRrtIDByCrId(stRtID);	//在进行路径计算之前要把人员的ID换算成它关联的路径的ID，不能直接将入参改成路径ID，将导致修改功能混乱
		String floydRes = floydRoutes(stRtID, endRtID);
		String rtSerial = "";
		List<Integer> passRts = strToIntList(floydRes);
		for(Integer passRtID : passRts){
			passRoutes.add(routeMapDao.getSingleRoute(passRtID+1));
			rtSerial += (passRtID+1) + ",";
		}
		rtSerial = rtSerial.substring(0, rtSerial.length()-1);

		result.put("curCrName", emerPlanDao.selCrewNameByRtId(stRtID)); 
		result.put("routes", passRoutes);
		result.put("passRtsStr", rtSerial);
		return result;
	}
	
	/**
	 * 修改路径
	 */
	public JSONObject rvdRoutes(String rtSerial){
		JSONObject result = new JSONObject();
		List<Integer> rtIDs = strToIntList(rtSerial);
		List<Route> rvdRoutes = new ArrayList<Route>();
		for(Integer rtID : rtIDs){
			Route tempRoute = routeMapDao.getSingleRoute(rtID);
			if (tempRoute == null) {
				result.put("msg", 0);
				return result;
			} else {
				rvdRoutes.add(tempRoute);
			}
		}
		
		if (rvdRoutes.size() > 0) {
			result.put("rvdRoutes", rvdRoutes);
			result.put("msg", 1);
		} else {
			result.put("msg", 0);
		}
				
		return result;
	}
	
	/**
	 * 修改物资点
	 */
	public JSONObject rvdMats(String matSerial){
		JSONObject result = new JSONObject();
		List<Integer> matIDs = strToIntList(matSerial);
		List<Material> rvdMats = new ArrayList<Material>();
		for(Integer matID : matIDs){
			Material tempMat = routeMapDao.selCpltMat(matID);
			if (tempMat == null) {
				result.put("msg", 0);
				return result;
			} else {
				rvdMats.add(tempMat);
			}
		}
		if (rvdMats.size() > 0) {
			result.put("materials", rvdMats);
			result.put("msg", 1);
		} else {
			result.put("msg", 0);
		}
		return result;
	}
	
	/**
	 * 修改物资点-单个
	 */
	public void rvdMat(Material material){
		emerPlanDao.updateMat(material);
		Location location = material.getPosition();
		if (material.getGpsLat() != null) {
			location = transGpsToPixel(location, material.getGpsLat(), material.getGpsLon());
		}
		emerPlanDao.updateLoc(location);
		uptLocinHLev(location);		
	}
	
	/**
	 * 修改水源点
	 */
	public JSONObject rvdWats(String watSerial){
		JSONObject result = new JSONObject();
		List<Integer> watIDs = strToIntList(watSerial);
		List<WaterSource> rvdWats = new ArrayList<WaterSource>();
		for(Integer watID : watIDs){
			WaterSource tempWat = routeMapDao.selCpltWat(watID);
			if (tempWat == null) {
				result.put("msg", 0);
				return result;
			} else {
				rvdWats.add(tempWat);
			}
		}
		if (rvdWats.size() > 0) {
			result.put("waterSources", rvdWats);
			result.put("msg", 1);
		} else {
			result.put("msg", 0);
		}
		return result;
	}
	
	/**
	 * 修改水源点信息-单个
	 * @param waterSource
	 */
	public void rvdWat(WaterSource waterSource){
		emerPlanDao.updateWat(waterSource);
		Location location = waterSource.getPosition();
		if (waterSource.getGpsLat() != null) {
			location = transGpsToPixel(location, waterSource.getGpsLat(), waterSource.getGpsLon());
		}
		emerPlanDao.updateLoc(location);
		uptLocinHLev(location);		
	}
	
	/**
	 * 修改人员信息-单个
	 * 0525更新为根据路径ID自动更新驻扎点位置
	 */
	public void rvdCrew(Crew crew){
		emerPlanDao.updateCrew(crew);
		Location priLoc = emerPlanDao.selLocByCrewID(crew.getCrewID());
		Location location = emerPlanDao.selFirstPtInRt(crew.getRtID(), 1);
		priLoc.setRtID(crew.getRtID());
		priLoc.setPointX(location.getPointX());
		priLoc.setPointY(location.getPointY());
		priLoc.setPtType(4);
		priLoc.setZmLev(1);
		emerPlanDao.updateLoc(priLoc);
		
		location = emerPlanDao.selFirstPtInRt(crew.getRtID(), 2);
		priLoc.setPointX(location.getPointX());
		priLoc.setPointY(location.getPointY());
		priLoc.setZmLev(2);
		emerPlanDao.updateLocByZlNSrcID(priLoc);
		
		location = emerPlanDao.selFirstPtInRt(crew.getRtID(), 3);
		priLoc.setPointX(location.getPointX());
		priLoc.setPointY(location.getPointY());
		priLoc.setZmLev(3);
		emerPlanDao.updateLocByZlNSrcID(priLoc);

	}
	
	/**
	 * 查找预案的核心信息：路径、物资点、水源点
	 */
	public JSONObject srchPois(EmergencyPlan emergencyPlan){
		JSONObject result = new JSONObject();
		List<Material> materials = new ArrayList<Material>();
		List<WaterSource> waterSources = new ArrayList<WaterSource>();
		
		String routesStr = emergencyPlan.getRoutes();
		if (routesStr != "") {
			List<Integer> rts = strToIntList(routesStr);
			for(Integer rtID : rts){
				List<Material> tempMat = emerPlanDao.selMatByRtId(rtID);
				if (tempMat.size() > 0) {
					materials.addAll(tempMat);
				}
				
				List<WaterSource> tempWat = emerPlanDao.selWatByRtId(rtID);
				if (tempWat.size() > 0) {
					waterSources.addAll(tempWat);
				} 				
			}
		}
				
		
		String matStr = emergencyPlan.getMaterials();
		if (matStr != "") {
			List<Integer> mats = strToIntList(matStr);
			for(Integer matID : mats){
				Material tempMat = routeMapDao.selCpltMat(matID);
				if (tempMat != null) {
					materials.add(tempMat);
				} else {
					result.put("msg", 0);
					return result;
				}
			}
		}
		
		String watStr = emergencyPlan.getWatersource();
		if (watStr != "") {
			List<Integer> watSrs = strToIntList(watStr);
			for(Integer watSrID : watSrs){
				WaterSource tempWat = routeMapDao.selCpltWat(watSrID);
				if (tempWat != null) {
					waterSources.add(tempWat);
				} else {
					result.put("msg", 0);
					return result;
				}
			}
		}
		

		result.put("materials", materials);
		result.put("waterSources", waterSources);
		result.put("msg", 1);

		
		
		return result;
	}
	
	
	/**
	 * 预案全列表
	 */
	public JSONObject PlanAllList(Integer page, Integer limit){
		JSONObject result = new JSONObject();	
		List<EmergencyPlan> allPlans = emerPlanDao.selAllPlans();
		result.put("count", allPlans.size());
		if (page * limit < allPlans.size()) {
			allPlans = allPlans.subList((page-1)*limit, page*limit);
		} else {
			allPlans = allPlans.subList((page-1)*limit, allPlans.size());
		}
		result.put("data", allPlans);
		result.put("code", 0);
		result.put("msg", "");
		return result;
	}
	
	/**
	 * 创建预案
	 */
	public void createPlan(EmergencyPlan emergencyPlan){

		List<Integer> targetRtIDs = strToIntList(emergencyPlan.getTargetRtID());
		List<Integer> massRoutes = strToIntList(emergencyPlan.getRoutes());

		//分路前将目标路径拨正
		for(int i=0; i<targetRtIDs.size(); i++){
			if (targetRtIDs.get(i) < 0) {
				targetRtIDs.set(i, -targetRtIDs.get(i));
			}
		}

		int statOrd = 0;
		for(Integer sidePt : targetRtIDs){
			int endOrd = massRoutes.indexOf(sidePt);
			int sumTime = 0;
			double sumLen = 0;
			for(int i=statOrd; i<=endOrd; i++){
				Route tempRt = emerPlanDao.selTimeNLen(massRoutes.get(i));
				sumTime += tempRt.getRtTime();
				sumLen += tempRt.getRtLength();
			}
			DecimalFormat df = new DecimalFormat("#.0");		//由于浮点数的自带误差，为避免字段超长，只保留一位小数
			sumLen = Double.parseDouble(df.format(sumLen));
			if (targetRtIDs.indexOf(sidePt) == targetRtIDs.size()-1) {
				if(emergencyPlan.getArrTime() != null){
					emergencyPlan.setArrTime(emergencyPlan.getArrTime() + sumTime + "min");
				} else {
					emergencyPlan.setArrTime(sumTime + "min");
				}
				if (emergencyPlan.getRtsLen() != null) {
					emergencyPlan.setRtsLen(emergencyPlan.getRtsLen() + sumLen + "km");
				} else {
					emergencyPlan.setRtsLen(sumLen + "km");
				}
			} else {
				if(emergencyPlan.getArrTime() != null){
					emergencyPlan.setArrTime(emergencyPlan.getArrTime() + sumTime + "min,");
				} else {
					emergencyPlan.setArrTime(sumTime + "min,");
				}
				if (emergencyPlan.getRtsLen() != null) {
					emergencyPlan.setRtsLen(emergencyPlan.getRtsLen() + sumLen + "km,");
				} else {
					emergencyPlan.setRtsLen(sumLen + "km,");
				}
			}
			statOrd = endOrd + 1;
		}
		emerPlanDao.istNewPlan(emergencyPlan);
	}
	
	/**
	 * 新建物资点
	 */
	public void createMats(Material material){
		emerPlanDao.istNewMat(material);
		Location location = material.getPosition();
		if (material.getGpsLat() != null) {
			location = transGpsToPixel(location, material.getGpsLat(), material.getGpsLon());
		}
		location.setSptOrdInRt(material.getMatID());	//获取matID
		rcPosNSave(location);
	}
	
	/**
	 * 新建水源点
	 */
	public void createWats(WaterSource waterSource){
		emerPlanDao.istNewWat(waterSource);
		Location location = waterSource.getPosition();
		if (waterSource.getGpsLat() != null) {
			location = transGpsToPixel(location, waterSource.getGpsLat(), waterSource.getGpsLon());
		}
		location.setSptOrdInRt(waterSource.getWatSrID());	//获取watID
		rcPosNSave(location);
	}
	
	/**
	 * 新增扑救人员，0521修改为不再使用用户输入的驻扎点，而是将关联路径的第一个点作为驻扎点
	 */
	public void createCrew(Crew crew){
		emerPlanDao.istNewCrew(crew);
		Location location = emerPlanDao.selFirstPtInRt(crew.getRtID(), 1);
		location.setRtID(crew.getRtID());
		location.setPtType(4);
		location.setSptOrdInRt(crew.getCrewID());
		location.setZmLev(1);
		routeMapDao.istPoiAuto(location);
		
		Location hLevLoc = emerPlanDao.selFirstPtInRt(crew.getRtID(), 2);
		location.setPointX(hLevLoc.getPointX());
		location.setPointY(hLevLoc.getPointY());
		location.setZmLev(2);
		routeMapDao.istPoiAuto(location);
		
		hLevLoc = emerPlanDao.selFirstPtInRt(crew.getRtID(), 3);
		location.setPointX(hLevLoc.getPointX());
		location.setPointY(hLevLoc.getPointY());
		location.setZmLev(3);
		routeMapDao.istPoiAuto(location);
	}
	
	/**
	 * 更新预案
	 */
	public void updatePlan(EmergencyPlan emergencyPlan){
		List<Integer> targetRtIDs = strToIntList(emergencyPlan.getTargetRtID());
		List<Integer> massRoutes = strToIntList(emergencyPlan.getRoutes());
		
		//分路前终点路径拨正
		for(int i=0; i<targetRtIDs.size(); i++){
			if (targetRtIDs.get(i) < 0) {
				targetRtIDs.set(i, -targetRtIDs.get(i));
			}
		}
		
		int statOrd = 0;
		for(Integer sidePt : targetRtIDs){
			int endOrd = massRoutes.indexOf(sidePt);
			int sumTime = 0;
			double sumLen = 0;
			for(int i=statOrd; i<=endOrd; i++){
				Route tempRt = emerPlanDao.selTimeNLen(massRoutes.get(i));
				sumTime += tempRt.getRtTime();
				sumLen += tempRt.getRtLength();
			}
			DecimalFormat df = new DecimalFormat("#.0");		//由于浮点数的自带误差，为避免字段超长，只保留一位小数
			sumLen = Double.parseDouble(df.format(sumLen));
			if (targetRtIDs.indexOf(sidePt) == targetRtIDs.size()-1) {
				if(emergencyPlan.getArrTime() != null){
					emergencyPlan.setArrTime(emergencyPlan.getArrTime() + sumTime + "min");				
				} else {
					emergencyPlan.setArrTime(sumTime + "min");
				}
				if (emergencyPlan.getRtsLen() != null) {
					emergencyPlan.setRtsLen(emergencyPlan.getRtsLen() + sumLen + "km");
				} else {
					emergencyPlan.setRtsLen(sumLen + "km");
				}
				//emergencyPlan.setArrTime(sumTime + "min");
				//emergencyPlan.setRtsLen(sumLen + "km");
			} else {
				if(emergencyPlan.getArrTime() != null){
					emergencyPlan.setArrTime(emergencyPlan.getArrTime() + sumTime + "min,");				
				} else {
					emergencyPlan.setArrTime(sumTime + "min,");
				}
				if (emergencyPlan.getRtsLen() != null) {
					emergencyPlan.setRtsLen(emergencyPlan.getRtsLen() + sumLen + "km,");
				} else {
					emergencyPlan.setRtsLen(sumLen + "km,");
				}
//				emergencyPlan.setArrTime(sumTime + "min,");
//				emergencyPlan.setRtsLen(sumLen + "km,");
			}			
			statOrd = endOrd + 1;
		}				
		emerPlanDao.updatePlan(emergencyPlan);
	}
	
	/**
	 * 搜索预案
	 */
	public List<EmergencyPlan> srchPlans(Integer kwType, String keyWord){
		
		List<EmergencyPlan> result = new ArrayList<EmergencyPlan>();
		if (kwType == 1) {					//根据预案ID搜索
			EmergencyPlan tempPlan = routeMapDao.selCpltPlanByPlanID(Integer.parseInt(keyWord));
			result.add(tempPlan);
		} else {												//根据预案名称搜索
			result = emerPlanDao.selPlansByName(keyWord);
		}
		return result;
	}
	
	/**
	 * 搜索扑救资源
	 */
	public JSONObject srchSrcs(Integer kwType, String keyWord, Integer listType, Integer page, Integer limit){
		JSONObject result = new JSONObject();
		
		if (listType == 1) {			
			if (kwType == 1) {
				List<Material> materials = new ArrayList<Material>();
				materials.add(routeMapDao.selCpltMat(Integer.parseInt(keyWord)));		//这里本来是可以唯一确认对象的，但是返回到layUI的结果必须是数组
				result.put("count", materials.size());
				result.put("data", materials);
				result.put("code", 0);
				result.put("msg", "");
			}
			if (kwType == 2) {
				List<Material> materials = emerPlanDao.selMatsByName(keyWord);
				result.put("count", materials.size());
				if (page * limit < materials.size()) {
					materials = materials.subList((page-1)*limit, page*limit);
				} else {
					materials = materials.subList((page-1)*limit, materials.size());
				}
				result.put("data", materials);
				result.put("code", 0);
				result.put("msg", "");
			}
		} 
		if (listType == 2) {
			if (kwType == 1) {
				List<WaterSource> waterSources = new ArrayList<WaterSource>();
				waterSources.add(routeMapDao.selCpltWat(Integer.parseInt(keyWord)));
				result.put("count", waterSources.size());
				result.put("data", waterSources);
				result.put("code", 0);
				result.put("msg", "");
			}
			if (kwType == 2) {
				List<WaterSource> waterSources = emerPlanDao.selWatsByName(keyWord);
				result.put("count", waterSources.size());
				if (page * limit < waterSources.size()) {
					waterSources = waterSources.subList((page-1)*limit, page*limit);
				} else {
					waterSources = waterSources.subList((page-1)*limit, waterSources.size());
				}
				result.put("data", waterSources);
				result.put("code", 0);
				result.put("msg", "");
			}
		}
		if (listType == 3) {
			if (kwType == 1) {
				List<Crew> crews = new ArrayList<Crew>();
				crews.add(routeMapDao.selCpltCrew(Integer.parseInt(keyWord)));
				result.put("count", crews.size());
				result.put("data", crews);
				result.put("code", 0);
				result.put("msg", "");
			}
			if (kwType == 2) {
				List<Crew> crews = emerPlanDao.selCrewByName(keyWord);
				result.put("count", crews.size());
				if (page * limit < crews.size()) {
					crews = crews.subList((page-1)*limit, page*limit);
				} else {
					crews = crews.subList((page-1)*limit, crews.size());
				}
				result.put("data", crews);
				result.put("code", 0);
				result.put("msg", "");
			}
		}
		
		return result;
	}
	
	/**
	 * 删除预案
	 */
	public void delPlan(Integer planID){ 
		emerPlanDao.delPlanByID(planID);
	}
	
	/**
	 * 删除扑救资源
	 */
	public void delSrc(Integer listType, Integer srcID){
		if (listType == 1) {
			emerPlanDao.delMatByID(srcID);
		}
		if (listType == 2) {
			emerPlanDao.delWatByID(srcID);
		}
		if (listType == 3) {
			emerPlanDao.delCrewByID(srcID);
		}
	}	
	
	/**
	 * 扑救资源全列表
	 */
	public JSONObject ffSrcList(Integer listType, Integer page, Integer limit){
		JSONObject result = new JSONObject();
		if (listType == 1) {
			List<Material> materials = emerPlanDao.selAllMats();
			result.put("count", materials.size());
			if (page * limit < materials.size()) {
				materials = materials.subList((page-1)*limit, page*limit);
			} else {
				materials = materials.subList((page-1)*limit, materials.size());
			}
			result.put("data", materials);
			result.put("code", 0);
			result.put("msg", "");			
		}
		if (listType == 2) {
			List<WaterSource> waterSources = emerPlanDao.selAllWats();
			result.put("count", waterSources.size());
			if (page * limit < waterSources.size()) {
				waterSources = waterSources.subList((page-1)*limit, page*limit);
			} else {
				waterSources = waterSources.subList((page-1)*limit, waterSources.size());
			}
			result.put("data", waterSources);
			result.put("code", 0);
			result.put("msg", "");
		}
		if (listType == 3) {
			List<Crew> crews = emerPlanDao.selAllCrew();
			result.put("count", crews.size());
			if (page * limit < crews.size()) {
				crews = crews.subList((page-1)*limit, page*limit);
			} else {
				crews = crews.subList((page-1)*limit, crews.size());
			}
			result.put("data", crews);
			result.put("code", 0);
			result.put("msg", "");
		}
		return result;
	}
	
	/**
	 * 修改物资点-回显物资点信息
	 */
	public Material priMatInfo(Integer matID){
		Material material = routeMapDao.selCpltMat(matID);
		material.setPosition(emerPlanDao.selLocBySrcID(matID));
		return material;
	}
	
	/**
	 * 修改水源点-回显水源点信息
	 */
	public WaterSource priWatInfo(Integer watSrID){
		WaterSource waterSource = routeMapDao.selCpltWat(watSrID);
		waterSource.setPosition(emerPlanDao.selLocByWatID(watSrID));
		return waterSource;
	}
	
	/**
	 * 修改人员信息-回显人员信息
	 */
	public Crew priCrewInfo(Integer crewID){
		Crew crew = routeMapDao.selCpltCrew(crewID);
		//crew.setPosition(emerPlanDao.selLocByCrewID(crewID));		不再显示位置，只显示关联路径
		return crew;
	}
	
	private List<Integer> strToIntList(String str){
		String[] strArr = str.split(",");
		List<Integer> intList = new ArrayList<Integer>();
		for(String single : strArr){
			intList.add(Integer.parseInt(single));
		}
		return intList;
	}
	
	/**
	 * 1、原来是地图放缩时，火点的重定位
	 * 2、新建预案时，根据1级坐标推算2、3级坐标
	 */
	private Location repositionFP(Location firePoint){

		int offsetX = 0;
		int fpY = firePoint.getPointY();
		//接下来是一个误差判断，主要来源于1级地图左边的留白和2、3级不一样，目前主要是X轴偏的比较大，所以只算了X轴的偏移值
        if (fpY > 0 && fpY <= 57) {
        	offsetX = 12;
		}
        if (fpY > 57 && fpY <= 331) {
        	offsetX = 10;
		}
        if (fpY > 331 && fpY <= 469) {
        	offsetX = 9;
		}
        if (fpY > 469 && fpY <= 605) {
        	offsetX = 8;
		}
        if (fpY > 605 && fpY <= 741) {
        	offsetX = 7;
		}
        if (fpY > 741 && fpY <= 880) {
        	offsetX = 6;
		}
        if (fpY > 880 && fpY <= 950) {
        	offsetX = 5;
		}
						
		if (firePoint.getZmLev() == 2) {
			firePoint.setPointX(firePoint.getPointX()*2177/1716 - offsetX);
			firePoint.setPointY(firePoint.getPointY()*1224/950);
		}
		if (firePoint.getZmLev() == 3) {
			firePoint.setPointX(firePoint.getPointX()*3618/1716 - offsetX);
			firePoint.setPointY(firePoint.getPointY()*2028/950);
		}
		return firePoint;
	}
	
	/**
	 * 根据一级位置计算2、3级位置并插入数据库
	 * @param location
	 */
	private void rcPosNSave(Location location) {		//传入的位置是一级位置
		routeMapDao.istPoiAuto(location);				//直接插入一级位置
		
		Integer originX = location.getPointX();			//保存原来的坐标值，以免2级坐标还算后影响3级坐标换算
		Integer originY = location.getPointY();
		
		location.setZmLev(2);							//计算2级坐标并插入location表
		location = repositionFP(location);
		routeMapDao.istPoiAuto(location);
		
		location.setPointX(originX);					//还原坐标
		location.setPointY(originY);
		location.setZmLev(3);							//计算3级坐标并插入location表
		location = repositionFP(location);
		routeMapDao.istPoiAuto(location);
	}
	
	/**
	 * 更新2、3级别的位置点信息
	 * @param location
	 */
	private void uptLocinHLev(Location location){
		Integer originX = location.getPointX();			//保存原来的坐标值，以免2级坐标还算后影响3级坐标换算
		Integer originY = location.getPointY();
		
		location.setZmLev(2);
		location = repositionFP(location);
		emerPlanDao.updateLocByZlNSrcID(location);
		
		location.setPointX(originX);
		location.setPointY(originY);
		location.setZmLev(3);
		location = repositionFP(location);
		emerPlanDao.updateLocByZlNSrcID(location);
	}
	
	/**
	 * 弗洛伊德-多源最短路径
	 * 这里直接把path矩阵移过来了，初始化系统时一次计算，后面都直接用了
	 * @param stRtID
	 * @param endRtID
	 * @return
	 */
	private String floydRoutes(Integer stRtID, Integer endRtID){
		String result = "";
		int path[][] = {
				{0,0,0,16,16,4,37,37,35,31,31,4,4,9,9,0,2,12,12,18,18,18,17,17,26,28,28,26,1,30,31,1,33,30,35,33,2,0},
				{1,1,1,16,16,4,37,37,35,31,31,4,4,9,9,16,2,12,12,18,18,18,17,17,26,28,28,26,1,30,31,1,33,30,35,33,2,0},
				{2,2,2,16,16,4,37,37,35,31,31,4,4,9,9,16,2,12,12,18,18,18,17,17,26,28,28,26,1,30,31,1,33,30,35,33,2,15},
				{2,2,16,3,3,4,37,37,35,31,31,4,4,9,9,3,3,12,12,18,18,18,17,17,26,28,28,26,1,30,31,1,33,30,35,33,16,15},
				{2,2,16,4,4,4,37,37,35,31,31,4,4,9,9,4,4,12,12,18,18,18,17,17,26,28,28,26,1,30,31,1,33,30,35,33,16,15},
				{2,2,16,4,5,5,37,37,35,31,31,5,5,9,9,4,4,12,12,18,18,18,17,17,26,28,28,26,1,30,31,1,33,30,35,33,16,15},
				{37,0,16,15,15,4,6,37,35,31,31,4,4,9,9,37,15,12,12,18,18,18,17,17,26,28,28,26,1,30,31,1,33,30,35,33,16,6},
				{37,0,16,15,15,4,37,7,35,31,31,4,4,9,9,37,15,12,12,18,18,18,17,17,26,28,28,26,1,30,31,1,33,30,35,33,16,7},
				{1,31,1,16,16,4,37,37,8,30,30,4,4,9,9,16,2,12,12,18,18,18,17,17,27,26,27,32,26,33,33,30,35,35,8,8,2,0},
				{1,31,1,16,16,4,37,37,35,9,9,4,4,9,9,16,2,12,12,18,18,18,17,17,27,28,28,29,31,30,9,9,33,30,35,33,2,0},
				{1,31,1,16,16,4,37,37,35,10,10,4,4,9,9,16,2,12,12,18,18,18,17,17,27,28,28,29,31,30,10,10,33,30,35,33,2,0},
				{2,2,16,4,11,11,37,37,35,31,31,11,11,9,9,4,4,12,12,18,18,18,17,17,26,28,28,26,1,30,31,1,33,30,35,33,16,15},
				{2,2,16,4,12,12,37,37,35,31,31,12,12,9,9,4,4,12,12,18,18,18,17,17,26,28,28,26,1,30,31,1,33,30,35,33,16,15},
				{1,31,1,16,16,4,37,37,35,13,9,4,4,13,9,16,2,12,12,18,18,18,17,17,27,28,28,29,31,30,9,9,33,30,35,33,2,0},
				{1,31,1,16,16,4,37,37,35,14,9,4,4,9,14,16,2,12,12,18,18,18,17,17,27,28,28,29,31,30,9,9,33,30,35,33,2,0},
				{15,2,16,15,15,4,37,37,35,31,31,4,4,9,9,15,15,12,12,18,18,18,17,17,26,28,28,26,1,30,31,1,33,30,35,33,16,15},
				{2,2,16,16,16,4,37,37,35,31,31,4,4,9,9,16,16,12,12,18,18,18,17,17,26,28,28,26,1,30,31,1,33,30,35,33,16,15},
				{2,2,16,4,12,12,37,37,35,31,31,12,17,9,9,4,4,17,12,18,18,18,17,17,26,28,28,26,1,30,31,1,33,30,35,33,16,15},
				{2,2,16,4,12,12,37,37,35,31,31,12,18,9,9,4,4,12,18,18,18,18,17,17,26,28,28,26,1,30,31,1,33,30,35,33,16,15},
				{2,2,16,4,12,12,37,37,35,31,31,12,18,9,9,4,4,12,19,19,18,18,17,17,26,28,28,26,1,30,31,1,33,30,35,33,16,15},
				{2,2,16,4,12,12,37,37,35,31,31,12,18,9,9,4,4,12,20,18,20,18,17,17,26,28,28,26,1,30,31,1,33,30,35,33,16,15},
				{2,2,16,4,12,12,37,37,35,31,31,12,18,9,9,4,4,12,21,18,18,21,17,17,26,28,28,26,1,30,31,1,33,30,35,33,16,15},
				{2,2,16,4,12,12,37,37,35,31,31,12,17,9,9,4,4,22,12,18,18,18,22,17,26,28,28,26,1,30,31,1,33,30,35,33,16,15},
				{2,2,16,4,12,12,37,37,35,31,31,12,17,9,9,4,4,23,12,18,18,18,17,23,26,28,28,26,1,30,31,1,33,30,35,33,16,15},
				{1,28,1,16,16,4,37,37,35,30,30,4,4,9,9,16,2,12,12,18,18,18,17,17,24,26,24,24,26,27,29,30,27,32,35,32,2,0},
				{1,28,1,16,16,4,37,37,35,31,31,4,4,9,9,16,2,12,12,18,18,18,17,17,26,25,25,26,25,27,29,28,27,32,35,32,2,0},
				{1,28,1,16,16,4,37,37,35,31,31,4,4,9,9,16,2,12,12,18,18,18,17,17,26,26,26,26,26,27,29,28,27,32,35,32,2,0},
				{1,28,1,16,16,4,37,37,35,30,30,4,4,9,9,16,2,12,12,18,18,18,17,17,27,26,27,27,26,27,29,30,27,32,35,32,2,0},
				{1,28,1,16,16,4,37,37,35,31,31,4,4,9,9,16,2,12,12,18,18,18,17,17,26,28,28,26,28,27,31,28,27,32,35,32,2,0},
				{1,31,1,16,16,4,37,37,35,30,30,4,4,9,9,16,2,12,12,18,18,18,17,17,27,26,27,29,26,29,29,30,29,29,35,33,2,0},
				{1,31,1,16,16,4,37,37,35,30,30,4,4,9,9,16,2,12,12,18,18,18,17,17,27,26,27,29,31,30,30,30,33,30,35,33,2,0},
				{1,31,1,16,16,4,37,37,35,31,31,4,4,9,9,16,2,12,12,18,18,18,17,17,27,28,28,29,31,30,31,31,33,30,35,33,2,0},
				{1,31,1,16,16,4,37,37,35,30,30,4,4,9,9,16,2,12,12,18,18,18,17,17,27,26,27,32,26,32,33,30,32,32,35,32,2,0},
				{1,31,1,16,16,4,37,37,35,30,30,4,4,9,9,16,2,12,12,18,18,18,17,17,27,26,27,32,26,33,33,30,33,33,35,33,2,0},
				{1,31,1,16,16,4,37,37,34,30,30,4,4,9,9,16,2,12,12,18,18,18,17,17,27,26,27,32,26,33,33,30,35,35,34,34,2,0},
				{1,31,1,16,16,4,37,37,35,30,30,4,4,9,9,16,2,12,12,18,18,18,17,17,27,26,27,32,26,33,33,30,35,35,35,35,2,0},
				{2,2,36,16,16,4,37,37,35,31,31,4,4,9,9,16,36,12,12,18,18,18,17,17,26,28,28,26,1,30,31,1,33,30,35,33,36,15},
				{37,0,16,15,15,4,37,37,35,31,31,4,4,9,9,37,15,12,12,18,18,18,17,17,26,28,28,26,1,30,31,1,33,30,35,33,16,37}
		};
		result = findPath(stRtID-1, endRtID-1, path);
		return result;
	}
	
	private String findPath(int start, int end, int[][] path) {
		if (path[start][end] == -1) {
			return "NoAccess";
		} else if (start == path[start][end]) {
			return start + "," + end;
		} else {
			return findPath(start, path[start][end], path)+","+end;
		}
	}
	
	/**
	 * 古德曼函数将GPS坐标转换为像素坐标（取整）
	 * @param location
	 * @return
	 */
	private Location transGpsToPixel(Location location, double lat, double lon){
		double latDis = (countLatDis(40.071171) - countLatDis(lat)) * 0.77885245901;
		double lonDis = (lon - 116.049671) * 85779.66839349142;
		int pixelY = (int)(latDis/197.651473 * 55.51);
		int pixelX = (int)(lonDis/197.651473 * 55.51);
		location.setPointX(pixelX + 8);
		location.setPointY(pixelY - 5);
		return location;
	}
	
	/**
	 * 古德曼函数-计算该纬度与赤道的距离
	 * @param gpsLattitude
	 * @return
	 */
	private double countLatDis(double gpsLattitude){
		double earthRad = 6378137.0; 

		double a = gpsLattitude * Math.PI / 180;  
		double y = earthRad / 2 * Math.log((1.0 + Math.sin(a)) / (1.0 - Math.sin(a)));
		
		return y;		
	}
	
	
}
