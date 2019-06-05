package cn.kepu.questionnaire.pojo;

import java.io.Serializable;
import java.util.List;

/**
 *	防火预案
 */
public class EmergencyPlan implements Serializable{

	
	private static final long serialVersionUID = -1341057130122922864L;
	
	Integer planID;
	String planName;
	String planIntro;
	String targetRtID;
	Integer priority;
	String routes;									//TODO 跟下面的ctRoutes重了，但是先不改吧
	String materials;
	String watersource;
	String crew;
	String arrTime;
	String rtsLen;
	String wdFrcRst;
	String tempRst;
	String timeRst;
	
	List<Integer> ctRoutes;//所包含的路径ID

	public EmergencyPlan() {
		super();
	}	

	public EmergencyPlan(Integer planID, String planName, String planIntro, String targetRtID, Integer priority,
			String routes, String materials, String watersource, String crew, String arrTime, String rtsLen,
			String wdFrcRst, String tempRst, String timeRst, List<Integer> ctRoutes) {
		super();
		this.planID = planID;
		this.planName = planName;
		this.planIntro = planIntro;
		this.targetRtID = targetRtID;
		this.priority = priority;
		this.routes = routes;
		this.materials = materials;
		this.watersource = watersource;
		this.crew = crew;
		this.arrTime = arrTime;
		this.rtsLen = rtsLen;
		this.wdFrcRst = wdFrcRst;
		this.tempRst = tempRst;
		this.timeRst = timeRst;
		this.ctRoutes = ctRoutes;
	}



	public Integer getPlanID() {
		return planID;
	}

	public void setPlanID(Integer planID) {
		this.planID = planID;
	}
		
	public String getPlanName() {
		return planName;
	}

	public void setPlanName(String planName) {
		this.planName = planName;
	}

	public String getPlanIntro() {
		return planIntro;
	}

	public void setPlanIntro(String planIntro) {
		this.planIntro = planIntro;
	}
			
	public String getTargetRtID() {
		return targetRtID;
	}

	public void setTargetRtID(String targetRtID) {
		this.targetRtID = targetRtID;
	}

	public Integer getPriority() {
		return priority;
	}

	public void setPriority(Integer priority) {
		this.priority = priority;
	}

	public List<Integer> getCtRoutes() {
		return ctRoutes;
	}

	public void setCtRoutes(List<Integer> ctRoutes) {
		this.ctRoutes = ctRoutes;
	}
	
	public String getRoutes() {
		return routes;
	}

	public void setRoutes(String routes) {
		this.routes = routes;
	}

	public String getMaterials() {
		return materials;
	}

	public void setMaterials(String materials) {
		this.materials = materials;
	}

	public String getWatersource() {
		return watersource;
	}

	public void setWatersource(String watersource) {
		this.watersource = watersource;
	}
	
	public String getCrew() {
		return crew;
	}

	public void setCrew(String crew) {
		this.crew = crew;
	}	

	public String getArrTime() {
		return arrTime;
	}

	public void setArrTime(String arrTime) {
		this.arrTime = arrTime;
	}

	public String getRtsLen() {
		return rtsLen;
	}

	public void setRtsLen(String rtsLen) {
		this.rtsLen = rtsLen;
	}
		
	public String getWdFrcRst() {
		return wdFrcRst;
	}

	public void setWdFrcRst(String wdFrcRst) {
		this.wdFrcRst = wdFrcRst;
	}

	public String getTempRst() {
		return tempRst;
	}

	public void setTempRst(String tempRst) {
		this.tempRst = tempRst;
	}

	public String getTimeRst() {
		return timeRst;
	}

	public void setTimeRst(String timeRst) {
		this.timeRst = timeRst;
	}

	@Override
	public String toString() {
		return "EmergencyPlan [planID=" + planID + ", planName=" + planName + ", planIntro=" + planIntro
				+ ", targetRtID=" + targetRtID + ", priority=" + priority + ", routes=" + routes + ", materials="
				+ materials + ", watersource=" + watersource + ", crew=" + crew + ", arrTime=" + arrTime + ", rtsLen="
				+ rtsLen + ", wdFrcRst=" + wdFrcRst + ", tempRst=" + tempRst + ", timeRst=" + timeRst + ", ctRoutes="
				+ ctRoutes + "]";
	}


}
