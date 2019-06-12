package cn.kepu.questionnaire.dao;

import java.util.List;

import cn.kepu.questionnaire.pojo.*;
import org.apache.ibatis.annotations.Param;


public interface IEmerPlanDao {

	
	String selRtMapByStEdID(@Param("stRtID")Integer stRtID, @Param("endRtID")Integer endRtID);
	
	String selCrewNameByCrId(Integer stRtID);
	
	String selCrewNameByRtId(Integer rtID);
	
	Integer selRrtIDByCrId(Integer crewID);			//查询人员所关联的路径ID
	
	List<Material> selMatByRtId(Integer rtID);
	
	List<WaterSource> selWatByRtId(Integer rtID);
	
	List<EmergencyPlan> selAllPlans();

	EmergencyPlan selPlanById(Integer planID);
	
	List<Material> selAllMats();
	
	List<WaterSource> selAllWats();
	
	List<Crew> selAllCrew();
	
	void istNewPlan(EmergencyPlan emergencyPlan);
	
	void istNewMat(Material material);
	
	void istNewWat(WaterSource waterSource);
	
	void istNewCrew(Crew crew);
	
	Route selTimeNLen(Integer rtID);
	
	List<EmergencyPlan> selPlansByName(String planName);
	
	List<Material> selMatsByName(String matName);
	
	List<WaterSource> selWatsByName(String watSrName);
	
	List<Crew> selCrewByName(String crewName);
	
	void delPlanByID(Integer planID);
	
	void delMatByID(Integer matID);
	
	void delWatByID(Integer watSrID);
	
	void delCrewByID(Integer crewID);
	
	void updatePlan(EmergencyPlan emergencyPlan);
	
	void updateMat(Material material);
	
	void updateWat(WaterSource waterSource);
	
	void updateCrew(Crew crew);
	
	void updateLoc(Location location);				//位置点的更新有3个值是不能动的：关联的POIID、放缩级别、POI类别
	
	void updateLocByZlNSrcID(Location location);	//同上
	
	Location selLocBySrcID(Integer srcID);			//选取一个POI点的位置信息，固定1级
	
	Location selLocByWatID(Integer srcID);
	
	Location selLocByCrewID(Integer srcID);
	
	Location selFirstPtInRt(@Param("rtID")Integer rtID, @Param("zmLev")Integer zmLev);			//选取路径的第一个点

    List<Location> selAllLocation(Integer zmLev);

	void updatePlanRoute(EmergencyPlan emergencyPlan);

	Crew selCrewById(Integer id);
}
