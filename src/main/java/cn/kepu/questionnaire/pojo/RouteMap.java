package cn.kepu.questionnaire.pojo;


/**
 * 起终点与最短路线的Map
 * @author SilentWhale
 *
 */
public class RouteMap {
	
	Integer stptID;
	Integer endRtID;
	String passbyRtID;
	
	public RouteMap() {
		super();
	}
	public RouteMap(Integer stptID, Integer endRtID, String passbyRtID) {
		super();
		this.stptID = stptID;
		this.endRtID = endRtID;
		this.passbyRtID = passbyRtID;
	}
	public Integer getStptID() {
		return stptID;
	}
	public void setStptID(Integer stptID) {
		this.stptID = stptID;
	}
	public Integer getEndRtID() {
		return endRtID;
	}
	public void setEndRtID(Integer endRtID) {
		this.endRtID = endRtID;
	}
	public String getPassbyRtID() {
		return passbyRtID;
	}
	public void setPassbyRtID(String passbyRtID) {
		this.passbyRtID = passbyRtID;
	}
	
	@Override
	public String toString() {
		return "RouteMap [stptID=" + stptID + ", endRtID=" + endRtID + ", passbyRtID=" + passbyRtID + "]";
	}
	
	
	
}
