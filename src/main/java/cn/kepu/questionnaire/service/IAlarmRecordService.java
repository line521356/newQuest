package cn.kepu.questionnaire.service;

import cn.kepu.questionnaire.pojo.AlarmRecord;
import com.alibaba.fastjson.JSONObject;

import java.util.List;

public interface IAlarmRecordService {

	void startAlarming(Integer aRecId);
	
	void stopAlarming(Integer aRecId);
	
	List<Integer> chkAlarming();
	
	List<AlarmRecord> getAlrminRecs();
	
	JSONObject getUnhandledRes(Integer page, Integer limit);
	
	JSONObject getHandledRes(Integer page, Integer limit);
	
	JSONObject getErrRes(Integer page, Integer limit);
	
	void checkFirePoints();
	
	void cancelAlm(AlarmRecord alarmRecord);
	
	List<AlarmRecord> chkRecsInGps();			//GPS坐标的报警记录查询接口

	List<AlarmRecord> selAllIsAlarming();

	void alarmRecordService(String aRecId);
}
