package cn.kepu.questionnaire.service;

import cn.kepu.questionnaire.pojo.MoniterVideo;
import cn.kepu.questionnaire.pojo.MonitorPoint;
import cn.kepu.questionnaire.pojo.SrchBody;
import cn.kepu.questionnaire.pojo.VideoDetInfo;

import java.util.List;

public interface IMoniterVideoService {

	MoniterVideo getSigVid();
	
	List<Object> mVidsListJson();
	
	List<MoniterVideo> getAllmVids();
	
	List<Object> getDSrchResult(SrchBody srchBody);
	
	List<Object> GlobalSrch(SrchBody srchBody);
	
	void delVids(List<SrchBody> srchBodies);
	
	VideoDetInfo getVidDetInfo(Integer vidID, String videoType);

	void insertVid(MoniterVideo moniterVideo);

	MonitorPoint findMonitorPointById(String id);
}
