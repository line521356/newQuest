package cn.kepu.questionnaire.dao;


import cn.kepu.questionnaire.pojo.*;

import java.util.List;

/**
 * 这个接口实际上处理了所有视频数据（监控、手动录制、报警）持久，不只是监控视频，只是后期懒得改名了
 * @author SilentWhale
 *
 */
public interface IMoniterVideoDao {

	
	MoniterVideo selSigVid();
	
	List<MoniterVideo> selAllmVids();
	
	List<MoniterVideo> selSrchResultByDate(SrchBody srchBody);
	
	List<RecordVideo> selrSrchResultByDate(SrchBody srchBody);
	
	List<AlarmVideo> selaSrchResultByDate(SrchBody srchBody);
	
	List<MoniterVideo> GselmVids(SrchBody srchBody);    //根据日期查找m视频
	
	List<RecordVideo> GselrVids(SrchBody srchBody);    //根据日期查找r视频
	
	List<AlarmVideo> GselaVids(SrchBody srchBody);     //根据日期查找a视频
	
	MonitorPoint GselVidsByMptIP(SrchBody srchBody);   //根据监控点IP查询视频
	
	List<MonitorPoint> selmptsWithName(SrchBody srchBody);  //根据监控点名称查找监控点，模糊查找
	
	List<MoniterVideo> selSinmVidAllInfoByMptID(Integer mptId);  //根据监控点ID查找m视频
	
	List<RecordVideo> selSinrVidAllInfoByMptID(Integer mptId);   //根据监控点ID查找r视频
	
	List<AlarmVideo> selSinaVidAllInfoByMptID(Integer mptId);	 //根据监控点ID查找a视频
	
	void delmVid(SrchBody srchBody);
	
	void delrVid(SrchBody srchBody);
	
	void delaVid(SrchBody srchBody);
	
	VideoDetInfo selSigmVidByID(Integer vidID);
	
	VideoDetInfo selSigrVidByID(Integer vidID);
	
	VideoDetInfo selSigaVidByID(Integer vidID);
	
	VideoDetInfo selSigMptByID(Integer mptId);
	
	Integer selMvideoCount();
	
	Integer selRvideoCount();
	
	Integer selAvideoCount();

	void insertVid(MoniterVideo moniterVideo);

	List <MonitorPoint> getAllMonitorPoint();

    MonitorPoint findMonitorPointById(String id);
}
