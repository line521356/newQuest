package cn.kepu.questionnaire.pojo;


/**
 * 测试Mybatis对继承和多态的支持，父类
 * @author SilentWhale
 *
 */

public class testPolyFather {
	
	private Integer seats;
	private String saveBelts;
	
	public testPolyFather(Integer seats, String saveBelts) {
		super();
		this.seats = seats;
		this.saveBelts = saveBelts;
	}
	public testPolyFather() {
		super();
	}
	
	
	
	public Integer getSeats() {
		return seats;
	}
	public void setSeats(Integer seats) {
		this.seats = seats;
	}
	public String getSaveBelts() {
		return saveBelts;
	}
	public void setSaveBelts(String saveBelts) {
		this.saveBelts = saveBelts;
	}
	@Override
	public String toString() {
		return "testPolyFather [seats=" + seats + ", saveBelts=" + saveBelts + "]";
	}
	
	
	
	
	
}
