package cn.kepu.questionnaire.pojo;

/**
 * 水源点
 * @author SilentWhale
 *
 */
public class WaterSource {

		Integer watSrID;
		String watSrName;			//水源点名称
		String watSrType;			//水源类型
		String watQuantity;			//蓄水量
		
		Integer rtID;				//水源点的位置与关联路径
		Location position;
		Double gpsLat;			//用于接收GPS坐标，这两个参数不提供构造方法
		Double gpsLon;
		
		public WaterSource() {
			super();
		}
				
		public WaterSource(Integer watSrID, String watSrName, String watSrType, String watQuantity, Integer rtID,
				Location position) {
			super();
			this.watSrID = watSrID;
			this.watSrName = watSrName;
			this.watSrType = watSrType;
			this.watQuantity = watQuantity;
			this.rtID = rtID;
			this.position = position;
		}


		public Integer getWatSrID() {
			return watSrID;
		}
		public void setWatSrID(Integer watSrID) {
			this.watSrID = watSrID;
		}
		public String getWatSrName() {
			return watSrName;
		}
		public void setWatSrName(String watSrName) {
			this.watSrName = watSrName;
		}
		public String getWatSrType() {
			return watSrType;
		}
		public void setWatSrType(String watSrType) {
			this.watSrType = watSrType;
		}
		public String getWatQuantity() {
			return watQuantity;
		}
		public void setWatQuantity(String watQuantity) {
			this.watQuantity = watQuantity;
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
			return "WaterSource [watSrID=" + watSrID + ", watSrName=" + watSrName + ", watSrType=" + watSrType
					+ ", watQuantity=" + watQuantity + ", rtID=" + rtID + ", position=" + position + ", gpsLat="
					+ gpsLat + ", gpsLon=" + gpsLon + "]";
		}

}
