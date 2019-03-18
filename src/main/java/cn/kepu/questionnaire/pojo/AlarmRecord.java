package cn.kepu.questionnaire.pojo;

import java.io.Serializable;
import java.sql.Timestamp;


public class AlarmRecord implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -624046322235149729L;
	
	Integer aRecId;
	Integer mptId;
	double optLattitude;
	double optLongtitude;
	double optHeight;
	String alarmTime;
	Integer isConfirm;
	Integer isAlarmed;
	Integer isAlarming;
	String mptName;    //监控点名称，这里不再用ID,这个对象不是数据表的完全映射
	String name;
	String phone;
	Double hrzAngle;
	
	public AlarmRecord() {
		super();
	}
		
	public AlarmRecord(Integer aRecId, Integer mptId, double optLattitude, double optLongtitude, double optHeight,
			String alarmTime, Integer isConfirm, Integer isAlarmed, Integer isAlarming, String mptName, String name,
			String phone, Double hrzAngle) {
		super();
		this.aRecId = aRecId;
		this.mptId = mptId;
		this.optLattitude = optLattitude;
		this.optLongtitude = optLongtitude;
		this.optHeight = optHeight;
		this.alarmTime = alarmTime;
		this.isConfirm = isConfirm;
		this.isAlarmed = isAlarmed;
		this.isAlarming = isAlarming;
		this.mptName = mptName;
		this.name = name;
		this.phone = phone;
		this.hrzAngle = hrzAngle;
	}

	public Integer getaRecId() {
		return aRecId;
	}
	public void setaRecId(Integer aRecId) {
		this.aRecId = aRecId;
	}
	public Integer getMptId() {
		return mptId;
	}
	public void setMptId(Integer mptId) {
		this.mptId = mptId;
	}
	public double getOptLattitude() {
		return optLattitude;
	}
	public void setOptLattitude(double optLattitude) {
		this.optLattitude = optLattitude;
	}
	public double getOptLongtitude() {
		return optLongtitude;
	}
	public void setOptLongtitude(double optLongtitude) {
		this.optLongtitude = optLongtitude;
	}
	public double getOptHeight() {
		return optHeight;
	}
	public void setOptHeight(double optHeight) {
		this.optHeight = optHeight;
	}
	public String getAlarmTime() {
		return alarmTime;
	}
	public void setAlarmTime(String alarmTime) {
		this.alarmTime = alarmTime;
	}
	public Integer getIsConfirm() {
		return isConfirm;
	}
	public void setIsConfirm(Integer isConfirm) {
		this.isConfirm = isConfirm;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Integer getIsAlarmed() {
		return isAlarmed;
	}

	public void setIsAlarmed(Integer isAlarmed) {
		this.isAlarmed = isAlarmed;
	}

	public Integer getIsAlarming() {
		return isAlarming;
	}

	public void setIsAlarming(Integer isAlarming) {
		this.isAlarming = isAlarming;
	}

	public String getMptName() {
		return mptName;
	}

	public void setMptName(String mptName) {
		this.mptName = mptName;
	}

	
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public Double getHrzAngle() {
		return hrzAngle;
	}

	public void setHrzAngle(Double hrzAngle) {
		this.hrzAngle = hrzAngle;
	}

	@Override
	public String toString() {
		return "AlarmRecord [aRecId=" + aRecId + ", mptId=" + mptId + ", optLattitude=" + optLattitude
				+ ", optLongtitude=" + optLongtitude + ", optHeight=" + optHeight + ", alarmTime=" + alarmTime
				+ ", isConfirm=" + isConfirm + ", isAlarmed=" + isAlarmed + ", isAlarming=" + isAlarming + ", mptName="
				+ mptName + ", name=" + name + ", phone=" + phone + ", hrzAngle=" + hrzAngle + "]";
	}

	
}
