package cn.kepu.questionnaire.pojo;


/**
 * 扑救人员或办公人员
 * @author SilentWhale
 *
 */
public class Crew {

	Integer crewID;
	String crewName;
	Integer headCount;
	String crewType;
	String leader;
	
	Integer rtID;
	Location position;
	
	public Crew() {
		super();
	}
			
	public Crew(Integer crewID, String crewName, Integer headCount, String crewType, String leader, Integer rtID,
			Location position) {
		super();
		this.crewID = crewID;
		this.crewName = crewName;
		this.headCount = headCount;
		this.crewType = crewType;
		this.leader = leader;
		this.rtID = rtID;
		this.position = position;
	}



	public Integer getCrewID() {
		return crewID;
	}
	public void setCrewID(Integer crewID) {
		this.crewID = crewID;
	}
	public String getCrewName() {
		return crewName;
	}
	public void setCrewName(String crewName) {
		this.crewName = crewName;
	}
	public Integer getHeadCount() {
		return headCount;
	}
	public void setHeadCount(Integer headCount) {
		this.headCount = headCount;
	}
	public String getCrewType() {
		return crewType;
	}
	public void setCrewType(String crewType) {
		this.crewType = crewType;
	}
	public String getLeader() {
		return leader;
	}
	public void setLeader(String leader) {
		this.leader = leader;
	}
		
	public Location getPosition() {
		return position;
	}

	public void setPosition(Location position) {
		this.position = position;
	}		

	public Integer getRtID() {
		return rtID;
	}

	public void setRtID(Integer rtID) {
		this.rtID = rtID;
	}

	@Override
	public String toString() {
		return "Crew [crewID=" + crewID + ", crewName=" + crewName + ", headCount=" + headCount + ", crewType="
				+ crewType + ", leader=" + leader + ", rtID=" + rtID + ", position=" + position + "]";
	}

			
}
