package cn.kepu.questionnaire.pojo;

import java.io.Serializable;
import java.util.List;

public class MonitorPoint implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8617139395096583919L;
	
	private Integer mptId;
	private String mptIP;
	private String mptName;
	private Double lattitude;
	private Double longtitude;
	private Double height;
	private List<MoniterVideo> moniterVideos;    //映射监控点和三类视频的一对多关系
	private List<RecordVideo> recordVideos;
	private List<AlarmVideo> alarmVideos;
	
	public MonitorPoint() {
		super();
	}

	public MonitorPoint(Integer mptId, String mptIP, String mptName, Double lattitude, Double longtitude,
			Double height, List<MoniterVideo> moniterVideos, List<RecordVideo> recordVideos,
			List<AlarmVideo> alarmVideos) {
		super();
		this.mptId = mptId;
		this.mptIP = mptIP;
		this.mptName = mptName;
		this.lattitude = lattitude;
		this.longtitude = longtitude;
		this.height = height;
		this.moniterVideos = moniterVideos;
		this.recordVideos = recordVideos;
		this.alarmVideos = alarmVideos;
	}



	public Integer getMptId() {
		return mptId;
	}

	public void setMptId(Integer mptId) {
		this.mptId = mptId;
	}

	public String getMptIP() {
		return mptIP;
	}

	public void setMptIP(String mptIP) {
		this.mptIP = mptIP;
	}

	public String getMptName() {
		return mptName;
	}

	public void setMptName(String mptName) {
		this.mptName = mptName;
	}

	public Double getLattitude() {
		return lattitude;
	}

	public void setLattitude(Double lattitude) {
		this.lattitude = lattitude;
	}

	public Double getLongtitude() {
		return longtitude;
	}

	public void setLongtitude(Double longtitude) {
		this.longtitude = longtitude;
	}

	public Double getHeight() {
		return height;
	}

	public void setHeight(Double height) {
		this.height = height;
	}
	
	public List<MoniterVideo> getMoniterVideos() {
		return moniterVideos;
	}


	public void setMoniterVideos(List<MoniterVideo> moniterVideos) {
		this.moniterVideos = moniterVideos;
	}


	public List<RecordVideo> getRecordVideos() {
		return recordVideos;
	}


	public void setRecordVideos(List<RecordVideo> recordVideos) {
		this.recordVideos = recordVideos;
	}

	public List<AlarmVideo> getAlarmVideos() {
		return alarmVideos;
	}

	public void setAlarmVideos(List<AlarmVideo> alarmVideos) {
		this.alarmVideos = alarmVideos;
	}

	@Override
	public String toString() {
		return "MonitorPoint [mptId=" + mptId + ", mptIP=" + mptIP + ", mptName=" + mptName + ", lattitude=" + lattitude
				+ ", longtitude=" + longtitude + ", height=" + height + ", moniterVideos=" + moniterVideos
				+ ", recordVideos=" + recordVideos + ", alarmVideos=" + alarmVideos + "]";
	}

}
