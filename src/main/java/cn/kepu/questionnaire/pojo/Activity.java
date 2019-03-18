package cn.kepu.questionnaire.pojo;

import java.io.Serializable;
import java.sql.Date;

public class Activity implements Serializable{

	
	private static final long serialVersionUID = 5045812719268396953L;

	private Integer actId;
	
	private String actName;
	
	private String actIntro;
	
	private Integer actPrtCount;
	
	private Date actSpsDat;
	
	private Date actEndDat;
	
	private String actPicUrl;
	
	
	public Activity() {
		super();
	}
	
	public Activity(Integer actId, String actName, String actIntro, Integer actPrtCount, Date actSpsDat,
			Date actEndDat) {
		super();
		this.actId = actId;
		this.actName = actName;
		this.actIntro = actIntro;
		this.actPrtCount = actPrtCount;
		this.actSpsDat = actSpsDat;
		this.actEndDat = actEndDat;
	}


	public Integer getActId() {
		return actId;
	}
	public void setActId(Integer actId) {
		this.actId = actId;
	}
	public String getActName() {
		return actName;
	}
	public void setActName(String actName) {
		this.actName = actName;
	}
	public String getActIntro() {
		return actIntro;
	}
	public void setActIntro(String actIntro) {
		this.actIntro = actIntro;
	}
	public Integer getActPrtCount() {
		return actPrtCount;
	}
	public void setActPrtCount(Integer actPrtCount) {
		this.actPrtCount = actPrtCount;
	}
	public Date getActSpsDat() {
		return actSpsDat;
	}
	public void setActSpsDat(Date actSpsDat) {
		this.actSpsDat = actSpsDat;
	}
	public Date getActEndDat() {
		return actEndDat;
	}
	public void setActEndDat(Date actEndDat) {
		this.actEndDat = actEndDat;
	}

	public String getActPicUrl() {
		return actPicUrl;
	}

	public void setActPicUrl(String actPicUrl) {
		this.actPicUrl = actPicUrl;
	}

	@Override
	public String toString() {
		return "Activity [actId=" + actId + ", actName=" + actName + ", actIntro=" + actIntro + ", actPrtCount="
				+ actPrtCount + ", actSpsDat=" + actSpsDat + ", actEndDat=" + actEndDat + ", actPicUrl=" + actPicUrl
				+ "]";
	}

	
	

	
	
	
}
