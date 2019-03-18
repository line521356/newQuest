package cn.kepu.questionnaire.pojo;

import java.io.Serializable;

/**
 * 物资点对象
 * @author SilentWhale
 *
 */
public class Material implements Serializable{

	Integer matID;
	String matName;			//物资点名称
	Integer ffSuit;			//阻燃服
	Integer GpsDevice;		//GPS
	Integer transCar;		//运兵车
	Integer dynamotor;		//发电机
	Integer waterPipe;		//水管
	
	Integer rtID;			//关联的路径ID
	Location position;		//物资点位置
	Double gpsLat;			//用于接收GPS坐标，这两个参数不提供构造方法
	Double gpsLon;
	
	public Material() {
		super();
	}

	public Material(Integer matID, String matName, Integer ffSuit, Integer gpsDevice, Integer transCar,
			Integer dynamotor, Integer waterPipe, Integer rtID, Location position) {
		super();
		this.matID = matID;
		this.matName = matName;
		this.ffSuit = ffSuit;
		GpsDevice = gpsDevice;
		this.transCar = transCar;
		this.dynamotor = dynamotor;
		this.waterPipe = waterPipe;
		this.rtID = rtID;
		this.position = position;
	}

	public Integer getMatID() {
		return matID;
	}

	public void setMatID(Integer matID) {
		this.matID = matID;
	}

	public String getMatName() {
		return matName;
	}

	public void setMatName(String matName) {
		this.matName = matName;
	}

	public Integer getFfSuit() {
		return ffSuit;
	}

	public void setFfSuit(Integer ffSuit) {
		this.ffSuit = ffSuit;
	}

	public Integer getGpsDevice() {
		return GpsDevice;
	}

	public void setGpsDevice(Integer gpsDevice) {
		GpsDevice = gpsDevice;
	}

	public Integer getTransCar() {
		return transCar;
	}

	public void setTransCar(Integer transCar) {
		this.transCar = transCar;
	}

	public Integer getDynamotor() {
		return dynamotor;
	}

	public void setDynamotor(Integer dynamotor) {
		this.dynamotor = dynamotor;
	}

	public Integer getWaterPipe() {
		return waterPipe;
	}

	public void setWaterPipe(Integer waterPipe) {
		this.waterPipe = waterPipe;
	}
	
	public Integer getRtID() {
		return rtID;
	}

	public void setRtID(Integer rtID) {
		this.rtID = rtID;
	}

	public Location getPosition() {
		return position;
	}

	public void setPosition(Location position) {
		this.position = position;
	}
		
	public Double getGpsLat() {
		return gpsLat;
	}

	public void setGpsLat(Double gpsLat) {
		this.gpsLat = gpsLat;
	}

	public Double getGpsLon() {
		return gpsLon;
	}

	public void setGpsLon(Double gpsLon) {
		this.gpsLon = gpsLon;
	}

	@Override
	public String toString() {
		return "Material [matID=" + matID + ", matName=" + matName + ", ffSuit=" + ffSuit + ", GpsDevice=" + GpsDevice
				+ ", transCar=" + transCar + ", dynamotor=" + dynamotor + ", waterPipe=" + waterPipe + ", rtID=" + rtID
				+ ", position=" + position + ", gpsLat=" + gpsLat + ", gpsLon=" + gpsLon + "]";
	}
	
}
