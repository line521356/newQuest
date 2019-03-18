package cn.kepu.questionnaire.dao;

import java.util.List;

import cn.kepu.questionnaire.pojo.*;
import org.apache.ibatis.annotations.Param;

public interface IRouteMapDao {

	Route getSingleRoute(Integer rtID);	//获取单条路线，不包括该路线包含的点，只包含该路线的基本信息如长度、时间等，单表，route
	
	List<Location> getPtsInRt(@Param("rtID")Integer rtID, @Param("zmLev")Integer zmLev);	//根据路线ID和放缩级别查路线所包含的点，单表，location
	
	List<Location> selLocsInRt(@Param("rtID")Integer rtID, @Param("zmLev")Integer zmLev);   //这个查询和getPtsInRt的差别只是查询结果缩小了，对于location大表来说是必要的
	
	Location selLocsByPtID(@Param("pointID")Integer pointID, @Param("zmLev")Integer zmLev);   //有点问题，zmlev不起作用
	
	List<Integer> selCtRoutesInSinPlan(Integer planID);	  //根据预案ID查询该预案中包含的路径ID集合
	
	void istPoiAuto(Location location);
	
	String selSegsInSinRoute(Location location);
	
	String selSegsByRtID(Integer rtID);
	
	List<EmergencyPlan> selPlanByRtID(Integer rtID);
	
	EmergencyPlan selAllPoisByplanID(Integer planID);
	
	Integer selRtTypeByrtID(Integer rtID);
	
	List<Location> selMatInPlan(@Param("rtID")Integer rtID, @Param("zmLev")Integer zmLev);
	
	List<Location> selWaterInPlan(@Param("rtID")Integer rtID, @Param("zmLev")Integer zmLev);
	
	List<Location> selCrewStInPlan(@Param("rtID")Integer rtID, @Param("zmLev")Integer zmLev);
	
	EmergencyPlan selRtsByplanID(Integer planID);
	
	//-----------------------------以下函数服务于切换预案-------------------------------
	
	EmergencyPlan selCpltPlanByPlanID(Integer planID);
	
	String selNameByCrewID(Integer crewID);
	
	//-----------------------------以下函数服务于小窗口当前方案详情----------------------
	
	Material selCpltMat(Integer matID);
	
	WaterSource selCpltWat(Integer watSrID);
	
	Crew selCpltCrew(Integer crewID);
}
