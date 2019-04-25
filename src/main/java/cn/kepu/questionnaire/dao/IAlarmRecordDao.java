package cn.kepu.questionnaire.dao;

import java.util.List;

import cn.kepu.questionnaire.pojo.AlarmRecord;
import cn.kepu.questionnaire.pojo.VideoDetInfo;

public interface IAlarmRecordDao {

	void udtAlmStatusToStart(Integer aRecId);
	
	void udtAlmStatusToStop(Integer aRecId);
	
	List<Integer> selIsAlarming();
	
	List<AlarmRecord> selAlrmRecs();
	
	List<AlarmRecord> selUnhandledRecs();
	
	List<AlarmRecord> selHandledRecs();
	
	List<AlarmRecord> selUnposRecs();					//选择还没有定位的报警记录
	
	List<AlarmRecord> selErrRecs();
	
	VideoDetInfo selSigaRecByID(Integer aRecId);
	
	void updateRecAftLoc(AlarmRecord alarmRecord);
	
	void udtAlmStatusToCancel(AlarmRecord alarmRecord);

	List<AlarmRecord> selAllIsAlarming();

    void updateToExceptionAlarm(String aRecId);
}
