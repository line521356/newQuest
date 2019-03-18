package cn.kepu.questionnaire.pojo;

import java.io.Serializable;

/**
 * 表示一个点的位置，包括横坐标与纵坐标,放缩级别，路径ID，及在路径中的点序号
 */
public class Location implements Serializable{

	private static final long serialVersionUID = -5415092561874730356L;
	
	Integer pointID;
	Integer pointX;
	Integer pointY;
	Integer zmLev;
	Integer rtID;
	Integer sptOrdInRt;
	Integer ptType;
	
	public Location() {
		super();
	}

	public Location(Integer pointID, Integer pointX, Integer pointY, Integer zmLev, Integer rtID, Integer sptOrdInRt,
			Integer ptType) {
		super();
		this.pointID = pointID;
		this.pointX = pointX;
		this.pointY = pointY;
		this.zmLev = zmLev;
		this.rtID = rtID;
		this.sptOrdInRt = sptOrdInRt;
		this.ptType = ptType;
	}

	public Integer getPointID() {
		return pointID;
	}

	public void setPointID(Integer pointID) {
		this.pointID = pointID;
	}

	public Integer getPointX() {
		return pointX;
	}

	public void setPointX(Integer pointX) {
		this.pointX = pointX;
	}

	public Integer getPointY() {
		return pointY;
	}

	public void setPointY(Integer pointY) {
		this.pointY = pointY;
	}

	public Integer getZmLev() {
		return zmLev;
	}

	public void setZmLev(Integer zmLev) {
		this.zmLev = zmLev;
	}

	public Integer getRtID() {
		return rtID;
	}

	public void setRtID(Integer rtID) {
		this.rtID = rtID;
	}

	public Integer getSptOrdInRt() {
		return sptOrdInRt;
	}

	public void setSptOrdInRt(Integer sptOrdInRt) {
		this.sptOrdInRt = sptOrdInRt;
	}		

	public Integer getPtType() {
		return ptType;
	}

	public void setPtType(Integer ptType) {
		this.ptType = ptType;
	}

	@Override
	public String toString() {
		return "Location [pointID=" + pointID + ", pointX=" + pointX + ", pointY=" + pointY + ", zmLev=" + zmLev
				+ ", rtID=" + rtID + ", sptOrdInRt=" + sptOrdInRt + ", ptType=" + ptType + "]";
	}


		
}
