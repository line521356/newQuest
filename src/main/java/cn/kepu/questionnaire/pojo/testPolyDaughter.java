package cn.kepu.questionnaire.pojo;

public class testPolyDaughter extends testPolyFather{
	
	private Integer skylightSeats;
	private String shakeProofBoard;
	
	public testPolyDaughter(Integer seats, String saveBelts) {
		super(seats, saveBelts);
	}

	public testPolyDaughter(Integer seats, String saveBelts, Integer skylightSeats, String shakeProofBoard) {
		super(seats, saveBelts);
		this.skylightSeats = skylightSeats;
		this.shakeProofBoard = shakeProofBoard;
	}

	public Integer getSkylightSeats() {
		return skylightSeats;
	}

	public void setSkylightSeats(Integer skylightSeats) {
		this.skylightSeats = skylightSeats;
	}

	public String getShakeProofBoard() {
		return shakeProofBoard;
	}

	public void setShakeProofBoard(String shakeProofBoard) {
		this.shakeProofBoard = shakeProofBoard;
	}

	@Override
	public String toString() {
		return "testPolyDaughter [skylightSeats=" + skylightSeats + ", shakeProofBoard=" + shakeProofBoard + "]";
	}
	
	
	
	
}
