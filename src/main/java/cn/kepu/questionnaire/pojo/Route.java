package cn.kepu.questionnaire.pojo;

import java.io.Serializable;
import java.util.List;
/**
 * 表示一条路线
 */
public class Route implements Serializable{

	
	private static final long serialVersionUID = -6715136110793663412L;

	Integer rtID;
	double rtLength; //路线长度，默认单位公里
	Integer rtTime;		//通过这条路的时间，默认单位分钟
	Integer rtType;
	String segSerial;	//该路线对应的线段序列
	
	List<Location> points; 	//一对多，路径包括的点
	
	public Route() {
		super();
	}

	public Route(Integer rtID, double rtLength, Integer rtTime, Integer rtType, String segSerial,
			List<Location> points) {
		super();
		this.rtID = rtID;
		this.rtLength = rtLength;
		this.rtTime = rtTime;
		this.rtType = rtType;
		this.segSerial = segSerial;
		this.points = points;
	}


	public Integer getRtID() {
		return rtID;
	}

	public void setRtID(Integer rtID) {
		this.rtID = rtID;
	}

	public double getRtLength() {
		return rtLength;
	}

	public void setRtLength(double rtLength) {
		this.rtLength = rtLength;
	}

	public Integer getRtTime() {
		return rtTime;
	}

	public void setRtTime(Integer rtTime) {
		this.rtTime = rtTime;
	}

	public Integer getRtType() {
		return rtType;
	}

	public void setRtType(Integer rtType) {
		this.rtType = rtType;
	}

	public List<Location> getPoints() {
		return points;
	}

	public void setPoints(List<Location> points) {
		this.points = points;
	}	

	public String getSegSerial() {
		return segSerial;
	}

	public void setSegSerial(String segSerial) {
		this.segSerial = segSerial;
	}

	@Override
	public String toString() {
		return "Route [rtID=" + rtID + ", rtLength=" + rtLength + ", rtTime=" + rtTime + ", rtType=" + rtType
				+ ", segSerial=" + segSerial + ", points=" + points + "]";
	}

	
	
		
}
