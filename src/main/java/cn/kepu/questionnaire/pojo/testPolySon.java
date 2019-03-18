package cn.kepu.questionnaire.pojo;

public class testPolySon extends testPolyFather{
	
	private Integer babyseat;
	private String saveAirBag;
	
	public testPolySon(Integer seats, String saveBelts) {
		super(seats, saveBelts);
	}

	public testPolySon(Integer seats, String saveBelts, Integer babyseat, String saveAirBag) {
		super(seats, saveBelts);
		this.babyseat = babyseat;
		this.saveAirBag = saveAirBag;
	}

	public Integer getBabyseat() {
		return babyseat;
	}

	public void setBabyseat(Integer babyseat) {
		this.babyseat = babyseat;
	}

	public String getSaveAirBag() {
		return saveAirBag;
	}

	public void setSaveAirBag(String saveAirBag) {
		this.saveAirBag = saveAirBag;
	}

	@Override
	public String toString() {
		return "testPolySon [babyseat=" + babyseat + ", saveAirBag=" + saveAirBag + "]";
	}

	
	
	
	
	
	
}
