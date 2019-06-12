package cn.kepu.questionnaire.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import cn.kepu.questionnaire.dao.IRouteMapDao;
import cn.kepu.questionnaire.pojo.*;
import cn.kepu.questionnaire.service.IRouteMapService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;


@Service("routemapService")
public class RouteMapServiceImpl implements IRouteMapService {

	@Autowired
	private IRouteMapDao routeMapDao;
	
	public List<Route> checkRoutesInPlan(Integer zmLev, Integer planID){	//入参：预案ID与放缩级别
		EmergencyPlan emergencyPlan = new EmergencyPlan();			// 这个对象其实是个空对象，只有路线，没有预案的其他信息，考虑优化
		emergencyPlan.setCtRoutes(routeMapDao.selCtRoutesInSinPlan(planID));	//得到含有路线ID集合的EmergencePlan对象
		
		List<Route> routes = new ArrayList<Route>();
		for(Integer rtID : emergencyPlan.getCtRoutes()){
			routes.add(routeMapDao.getSingleRoute(rtID));
		}
		
		for(Route route : routes){
			route.setPoints(routeMapDao.getPtsInRt(route.getRtID(), zmLev));
		}
		
		return routes;
	}
	
	
	/**
	 * 将坐标存入数据库（临时小工具：坐标拾取存储器）
	 */
	public void savePoi(Location location){
		routeMapDao.istPoiAuto(location);
	}
	
	/**
	 * 改写：入参火点位置，location 包括火点坐标和放缩级别
	 * 
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<EmergencyPlan> chkSegs(Location location){
		
		int[] routeSum = {5,6,12,13,20};						//TODO 别忘了这里是模拟街区，还没测试全部算一遍的效率如何
		//{5,6,12,13,20,7,8,9,10,11,15,18,19,21,22,23,24};
		List<Route> candRoutes = new ArrayList<Route>();    //等待被比较距离的路径 
		List<Double> routeDis = new ArrayList<Double>();
		Map<Integer, Double> IDnDis = new HashMap<Integer, Double>();			//路径ID与距离（带符号/方向）键值对

		
		for(int i : routeSum){
			candRoutes.add(routeMapDao.getSingleRoute(i));
		}
		for(Route route : candRoutes){
			route.setSegSerial(routeMapDao.selSegsByRtID(route.getRtID()));    
			route.setPoints(routeMapDao.getPtsInRt(route.getRtID(), 1));     //这里放缩级别默认1级
		}
		
		for(Route route : candRoutes){
			String segments = route.getSegSerial();
			List<Location> segLocs = route.getPoints();
			List<Integer> segTerminals = new ArrayList<Integer>();
			String[] strArr = segments.split(",");						//TODO 考虑把这个地方封装成函数，后面预案那里也会大量用到字符串拆解成数字组这项功能
			for(String single : strArr){
				segTerminals.add(Integer.parseInt(single));
			}
			Iterator<Location> iterator = segLocs.iterator();
			while(iterator.hasNext()){
				Location loc = iterator.next();							//临时变量，为避免并发错误
				if (!segTerminals.contains(loc.getSptOrdInRt())) {
					iterator.remove();
				}
			}
			routeDis.add(countDis(segLocs,location));
		}				
		
		
		if (routeDis.size() != routeSum.length) {				//把路径ID与火点距离封装成Map
			System.out.println("距离判断异常");
		} else {
			for(int i=0; i<routeSum.length; i++){
				IDnDis.put(routeSum[i], routeDis.get(i));
			}		
		}
		
		
		double minDis = Integer.MAX_VALUE;                                      //取最大的数，目前判断最小值好像也没有更好的办法了
		int clstRtID = 0;														//最近的路
		for(Map.Entry<Integer, Double> entry : IDnDis.entrySet()){				//取出带符号（方向）的，距离最短的路径ID
			double value = entry.getValue();									//临时变量，免得反复调方法
			int key = entry.getKey();
			if (Math.abs(value) < minDis) {
				minDis = Math.abs(value);
				if (value >= 0) {
					clstRtID = key;
				} else {
					clstRtID = -key;
				}				
			}
		}
		
		List<EmergencyPlan> candPlans = routeMapDao.selPlanByRtID(clstRtID);	//根据带符号（方向）的最近路径ID查找符合条件的预案集合
		Iterator<EmergencyPlan> epIterator = candPlans.iterator();
		while(epIterator.hasNext()){
			EmergencyPlan emergencyPlan = epIterator.next();					//临时变量
			List<Integer> targetIDs = strToIntList(emergencyPlan.getTargetRtID()); 
			if ((!judgeAvPlan(IDnDis, targetIDs)) || (!judgeRsts(emergencyPlan, location))) {	//两项校验内容，目的路径与方向，以及时间、温度、风力限制
				epIterator.remove();
			}
		}
		
		Collections.sort(candPlans, new Comparator() {
			@Override
	        public int compare(Object o1, Object o2) {  
	            EmergencyPlan ep1=(EmergencyPlan)o1;  ng
	            EmergencyPlan ep2=(EmergencyPlan)o2;  
	            return -ep1.getPriority().compareTo(ep2.getPriority());  
	        } 		
		});
		
		//TODO 把下面的输出作为日志内容
		for(EmergencyPlan emergencyPlan: candPlans){
			System.out.println("备选的可用预案"  + emergencyPlan.getPlanID());
		}
		for(Map.Entry<Integer, Double> entry : IDnDis.entrySet()){
			System.out.println("当前火点与个路线的距离（带方向）： " + "key= "+entry.getKey()+" and value= "+entry.getValue());
		}
		
		return candPlans;		
	}
	
	
	/**
	 * 输入路径的线段端点集合，返回距离，正值表示点在路径的相对右边位置，负值表示在相对左边位置
	 * @return
	 */
	private double countDis(List<Location> segLocs, Location location){
		double result = Integer.MAX_VALUE;
		int direction = Integer.MAX_VALUE;
		List<Double> segDis = new ArrayList<Double>();
				
		for (int i = 0; i < segLocs.size()-1; i++) {
				direction = judgeDirection(segLocs.get(i).getPointX(), segLocs.get(i).getPointY(), segLocs.get(i+1).getPointX(), segLocs.get(i+1).getPointY(), location.getPointX(), location.getPointY());
				segDis.add(direction * pointToLine(segLocs.get(i).getPointX(), segLocs.get(i).getPointY(), segLocs.get(i+1).getPointX(), segLocs.get(i+1).getPointY(), location.getPointX(), location.getPointY()));
			
		}
		
		double min = Math.abs(segDis.get(0));
		for(int i=1; i<segDis.size(); i++){
			if (Math.abs(segDis.get(i)) < min) {
				min = segDis.get(i);
			}
		}
		result = min;
		
		return result;
	}
	
	
	/**
	 * 点到直线的最短距离的判断 点（x0,y0） 到由两点组成的线段（x1,y1） ,( x2,y2 )
	 * @param x1 线上点1
	 * @param y1
	 * @param x2 线上点2
	 * @param y2
	 * @param x0 点横坐标
	 * @param y0 点纵坐标
	 * @return
	 */
	private double pointToLine(int x1, int y1, int x2, int y2, int x0,int y0){
		 double space = 0;
		    double a, b, c;
		    a = lineSpace(x1, y1, x2, y2);// 线段的长度
		    b = lineSpace(x1, y1, x0, y0);// (x1,y1)到点的距离
		    c = lineSpace(x2, y2, x0, y0);// (x2,y2)到点的距离
		    if (c <= 0.000001 || b <= 0.000001) {
		       space = 0;
		       System.out.println("点在线段的端点上");
		       return space;
		    }
		    if (a <= 0.000001) {
		       space = -1;
		       System.out.println("构不成线段，返回-1，报错");
		       return space;
		    }
		    if (c * c >= a * a + b * b) {
		       space = b;
		       System.out.println("返回b");
		       return space;
		    }
		    if (b * b >= a * a + c * c) {
		       space = c;
		       System.out.println("返回c");
		       return space;
		    }
		    double p = (a + b + c) / 2;// 半周长
		    double s = Math.sqrt(p * (p - a) * (p - b) * (p - c));// 海伦公式求面积
		    space = 2 * s / a;// 返回点到线的距离（利用三角形面积公式求高）
		    return space;
	}
	
	/**
	 * 点到点的距离
	 * @param x1
	 * @param y1
	 * @param x2
	 * @param y2
	 * @return
	 */
	private double lineSpace(int x1, int y1, int x2, int y2){
		double lineLength = 0;
	    lineLength = Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
	    return lineLength;
	}
	
	/**
	 * 判断点相对线段的方位
	 * @param x1
	 * @param y1
	 * @param x2
	 * @param y2
	 * @param x0
	 * @param y0
	 * @return
	 */
	private int judgeDirection(int x1, int y1, int x2, int y2, int x0,int y0){
		
		int result = 0;
		
		double k = (double)(y2 - y1)/(x2 - x1);			//求出线段直线函数再判断火点和直线的方位关系
		double b = y1 - k*x1;

		
		if (y0 > k*x0 + b) {							//点在线段的右边
			result = 1;
		} else if (y0 == k*x0 + b) {					//点在线上
			result = 0;
		} else {
			result = -1;								//点在线段的左边
		}
		
		return result;
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
	 * 针对多条路线的预案，判断该预案的可用性，判断条件是：
	 * 预案中所包含的路线和火点的距离差值不超过15个像素
	 * 
	 * 目前这个函数有一个前置条件：rtIDs的路径，map中都有相对距离数值
	 * 没有以上条件则需要不存在判断，直接返回false
	 * @return
	 */
	private boolean judgeAvPlan(Map<Integer, Double> mapOrigin, List<Integer> rtIDsOrigin){
								
		if ((rtIDsOrigin.size() == 1)) {								//预案中只有一条路
			if (rtIDsOrigin.get(0) * mapOrigin.get(Math.abs(rtIDsOrigin.get(0))) < 0) {		//判断火点方位和目标路径的方向是否一致
				return false;
			}
			return true;
		}
		
		Map<Integer, Double> map = new HashMap<Integer, Double>();		//复制map和list，以免引用传递改变原本的值
		map.putAll(mapOrigin);
		List<Integer> rtIDs = new ArrayList<Integer>();
		rtIDs.addAll(rtIDsOrigin);
		//------------------------------方向判断-----------------------------------
		
		for(Integer rtID: rtIDs){
			if (rtID * map.get(Math.abs(rtID)) < 0) {
				return false;
			}
		}
		//------------------------------去符号（方向）-----------------------------------
				
		for(int i=0; i<rtIDs.size(); i++){
			if (rtIDs.get(i) < 0) {
				rtIDs.set(i, -rtIDs.get(i));
			}
		}
		for(Map.Entry<Integer, Double> entry : map.entrySet()){
			if (entry.getValue() < 0) {
				entry.setValue(-entry.getValue());
			}
		}
		
		//------------------------------距离判断-----------------------------------
		double gap = Integer.MAX_VALUE;	
		gap = map.get(rtIDs.get(1)) - map.get(rtIDs.get(0));	//预案中只有2条路		
		if (Math.abs(gap) >15){
			return false;
		} else if (rtIDs.size() == 2) {
			return true;
		}
		
		
		double leftMin = gap>0?map.get(rtIDs.get(0)):map.get(rtIDs.get(1));	 //预案中有多条路，上不封顶
		gap = Math.abs(gap);
		for(int i=2; i<rtIDs.size(); i++){
			double temp = map.get(rtIDs.get(i)) - leftMin;
			if (Math.abs(temp) > gap) {
				gap = Math.abs(temp);
			}
			if ((temp+leftMin) < leftMin) {
				leftMin = temp + leftMin;
			}
		}
		if (gap <= 15) {
			return true;
		}
		
		return false;
	}
	
	/**
	 * 路线单独获取，路线是本身是两层的LocationList
	 */
	public List<List<Location>> driveWaysInPlan(Integer planID, Location firePoint){
		List<List<Location>> driveWay = new ArrayList<List<Location>>();
		EmergencyPlan emergencyPlan = routeMapDao.selRtsByplanID(planID);
		List<Integer> rtIDs = strToIntList(emergencyPlan.getRoutes());
		List<Integer> tgRtIDs = strToIntList(emergencyPlan.getTargetRtID());
		for (int i=0; i<tgRtIDs.size(); i++) {
			if (tgRtIDs.get(i) < 0) {
				tgRtIDs.set(i, -tgRtIDs.get(i));
			}
		}
		
		for(Integer rtID : rtIDs){
			List<Location> curRoute = routeMapDao.selLocsInRt(rtID, firePoint.getZmLev());
			if (routeMapDao.selRtTypeByrtID(rtID) == 1) {
				if ((tgRtIDs.contains(rtID)) && (firePoint.getPointX() != null)) {		//判断是否是最后一段路，如果是则不会加载全部的位置点，另外火点坐标为空的情况一般为预案预览，下面的函数相同	
					driveWay.add(cutRoute(curRoute, firePoint));
				} else {
					driveWay.add(curRoute);
				}
			}
		}
		
		return driveWay;
	}
	
	/**
	 * 和上面的函数极度相似，正确的做法可能是合并jsonObject，但是为了避免出错和节省时间，代码复用性可能就低了
	 */
	public List<List<Location>> pathsInPlan(Integer planID, Location firePoint){
		List<List<Location>> path = new ArrayList<List<Location>>();
		EmergencyPlan emergencyPlan = routeMapDao.selRtsByplanID(planID);
		List<Integer> rtIDs = strToIntList(emergencyPlan.getRoutes());
		List<Integer> tgRtIDs = strToIntList(emergencyPlan.getTargetRtID());
		for (int i=0; i<tgRtIDs.size(); i++) {
			if (tgRtIDs.get(i) < 0) {
				tgRtIDs.set(i, -tgRtIDs.get(i));
			}
		}
		
		for(Integer rtID : rtIDs){
			List<Location> curRoute = routeMapDao.selLocsInRt(rtID, firePoint.getZmLev());
			if (routeMapDao.selRtTypeByrtID(rtID) == 2) {
				if ((tgRtIDs.contains(rtID)) && (firePoint.getPointX() != null)) {						//判断是否是最后一段路，如果是则不会加载全部的位置点
					path.add(cutRoute(curRoute, firePoint));
				} else {
					path.add(curRoute);
				}				
			}
		}
		
		return path;
	}
		
	
	/**
	 * 查询预案中的水源、物资
	 * 还需补上人员以及放缩级别的调整
	 */
	public List<List<Location>> poiInPlan(Integer planID, Location firePoint){
		List<List<Location>> result = new ArrayList<List<Location>>();
		EmergencyPlan emergencyPlan = routeMapDao.selAllPoisByplanID(planID);
		List<Integer> poiIDs = strToIntList(emergencyPlan.getRoutes());
		List<Location> materials = new ArrayList<Location>();
		List<Location> waterSource = new ArrayList<Location>();
		List<Location> crewStays = new ArrayList<Location>();
		
		
		//old version: 这里，我没有再取预案里的物资字段了，直接用路径ID来做了物资和水源的遍历，因为逻辑上来讲，路径确定了，什么都确定了，不需要再另外存储了
		//TODO [囿于数据表设计搁置]如果要优化的话这里还是考虑改成根据ID来取，本来存在预案里就是拿来取的，这里这么多and查询肯定是要比主键索引（虽然是主键索引要做多次，而且要改表结构，各个信息点和位置表的关系目前是一对多，因为一个POI有3个位置）要慢的
		for(Integer poiID : poiIDs){
			materials.addAll(routeMapDao.selMatInPlan(poiID, firePoint.getZmLev()));
		}
		result.add(materials);
		
		for(Integer poiID : poiIDs){
			waterSource.addAll(routeMapDao.selWaterInPlan(poiID, firePoint.getZmLev()));
		}
		result.add(waterSource);
		
		for(Integer poiID : poiIDs){
			crewStays.addAll(routeMapDao.selCrewStInPlan(poiID, firePoint.getZmLev()));
		}
		result.add(crewStays);
				
		return result;
	}
	
	/**
	 * 标绘路线时需计算出终点路径中与火点最近的点，然后将该序点之后的点删除
	 * @param ttRoute	整条路径
	 * @param firePoint	火点位置
	 * @return
	 */
	private List<Location> cutRoute(List<Location> ttRoute, Location firePoint){

		double stDis = Integer.MAX_VALUE;
		int ptOrd = -1;
		for(int i=0; i<ttRoute.size(); i++){
			double curDis = lineSpace(ttRoute.get(i).getPointX(), ttRoute.get(i).getPointY(), firePoint.getPointX(), firePoint.getPointY());
			if (curDis < stDis) {
				stDis = curDis;
				ptOrd = i+1;
			}   
		}
		
		
		Iterator<Location> iterator = ttRoute.iterator();
		while(iterator.hasNext()){
			Location loc = iterator.next();
			if (loc.getSptOrdInRt() > ptOrd) {
				iterator.remove();
			}
		}

		
		return ttRoute;
	}
	
	/**
	 * 地图放缩时，火点的重定位
	 */
	public Location repositionFP(Location firePoint){

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
	 * 小窗口-切换预案-获取预案梗概
	 */
	public List<EmergencyPlan> srchPlanSkch(List<EmergencyPlan> emergencyPlans){
		List<EmergencyPlan> result = new ArrayList<EmergencyPlan>();
		for(EmergencyPlan emergencyPlan : emergencyPlans){
			EmergencyPlan tempEmergencyPlan = routeMapDao.selCpltPlanByPlanID(emergencyPlan.getPlanID());
			result.add(tempEmergencyPlan);
		}
		for(EmergencyPlan emergencyPlan : result){
			List<Integer> crewIDs = strToIntList(emergencyPlan.getCrew());
			String crewNames = "";
			for(Integer crewID : crewIDs){
				crewNames += routeMapDao.selNameByCrewID(crewID);
				crewNames += ", ";
			}
			emergencyPlan.setPlanIntro(crewNames); 
		}
		return result;
	}
	
	/**
	 * 小窗口-获取当前预案详情
	 */
	public JSONObject srchPlanDet(Integer planID){
		JSONObject result = new JSONObject();
		
		EmergencyPlan curPlan = routeMapDao.selCpltPlanByPlanID(planID);
		result.put("planName", curPlan.getPlanName());
		result.put("planIntro", curPlan.getPlanIntro());			
		result.put("wdFrcRst", curPlan.getWdFrcRst().split(","));				//以下三项是修改预案时要加载的，小窗口用不到
		result.put("tempRst", curPlan.getTempRst().split(","));
		result.put("timeRst", curPlan.getTimeRst().split(","));
		
		List<Integer> matIDs = strToIntList(curPlan.getMaterials());
		List<Material> materials = new ArrayList<Material>();
		for(Integer matID : matIDs){
			materials.add(routeMapDao.selCpltMat(matID));
		}
		result.put("mats", materials);
		
		List<Integer> watScIDs = strToIntList(curPlan.getWatersource());
		List<WaterSource> waterSources = new ArrayList<WaterSource>();
		for(Integer watScID: watScIDs){
			waterSources.add(routeMapDao.selCpltWat(watScID));
		}
		result.put("watSrc", waterSources);
		
		List<Integer> crewIDs = strToIntList(curPlan.getCrew());
		List<Crew> crewInfo = new ArrayList<Crew>();
		for(Integer crewID: crewIDs){
			crewInfo.add(routeMapDao.selCpltCrew(crewID));
		}
		result.put("crewInfo", crewInfo);
		
		
		//----新方法，直接用终点路段号分段-------
		List<List<Route>> segedRoutes = new ArrayList<List<Route>>();
		List<Integer> targetRtIDs = strToIntList(curPlan.getTargetRtID());
		List<Integer> unposTgRtIDs = new ArrayList<Integer>();				//本来是直接放入未拨正的targetRtIDs，但是前台获取到的仍然是拨正后的值，所以这里复制了一个targetRtIDs的原始值数组
		unposTgRtIDs.addAll(targetRtIDs);
		result.put("unposTgRtIDs", unposTgRtIDs);								//这里放入未拨正的目标路径数组，为了不干扰修改预案回显以外的功能
		List<Integer> massRoutes = strToIntList(curPlan.getRoutes());
		for(int i=0; i<targetRtIDs.size(); i++){
			if (targetRtIDs.get(i) < 0) {
				targetRtIDs.set(i, -targetRtIDs.get(i));
			}
		}
		result.put("targetRtIDs", targetRtIDs);
		
		int statOrd = 0;
		for(Integer sidePt : targetRtIDs){
			int endOrd = massRoutes.indexOf(sidePt);
			List<Route> temp = new ArrayList<Route>();
			for(int i=statOrd; i<=endOrd; i++){
				temp.add(routeMapDao.getSingleRoute(massRoutes.get(i)));
			}
			segedRoutes.add(temp);
			statOrd = endOrd + 1;
		}
		result.put("segedRoutes", segedRoutes);
		
		result.put("msg", 1);
		
		return result;
	}
	
	/**
	 * 检验备选预案中的温度、风力、时间限制是否符合
	 * @param emergencyPlan
	 * @param location
	 * @return
	 */
	private boolean judgeRsts(EmergencyPlan emergencyPlan, Location location){
		boolean res = true;
		Integer curWdForce = location.getSptOrdInRt();
		Integer curTemp = location.getPtType();
		List<Integer> wdRange = strToIntList(emergencyPlan.getWdFrcRst());
		List<Integer> tpRange = strToIntList(emergencyPlan.getTempRst());
		String[] timeRange = emergencyPlan.getTimeRst().split(",");
		
		if (curWdForce < wdRange.get(0) || curWdForce > wdRange.get(1)) {
			res = false;
		}
		if (curTemp < tpRange.get(0) || curTemp > tpRange.get(1)) {
			res = false;
		}
		
		SimpleDateFormat df = new SimpleDateFormat("HH:mm:ss");
		String curTimeStr = df.format(System.currentTimeMillis());
		try {
			Date earlyTime = df.parse(timeRange[0]);//将字符串转换为date类型  
	        Date lateTime = df.parse(timeRange[1]);
	        Date curTime = df.parse(curTimeStr);
	        if (curTime.getTime() < earlyTime.getTime() || curTime.getTime() > lateTime.getTime()) {
	        	res = false;
			}
		} catch (ParseException e) {                
            e.printStackTrace();  
        } 
		return res;
	}
	
	
}
