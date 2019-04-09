package cn.kepu.questionnaire.service.impl;

import java.util.Date;
import java.util.Iterator;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Vector;

import cn.kepu.questionnaire.dao.IAlarmRecordDao;
import cn.kepu.questionnaire.dao.IMoniterVideoDao;
import cn.kepu.questionnaire.pojo.*;
import cn.kepu.questionnaire.service.IMoniterVideoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("moniterVideoService")
public class MoniterVideoImpl implements IMoniterVideoService {
	
	@Resource
	private IMoniterVideoDao moniterVideoDao;
	@Resource
	private IAlarmRecordDao alarmRecordDao;
	
	
	public MoniterVideo getSigVid(){
		return moniterVideoDao.selSigVid();
	}
	
	
	public List<MoniterVideo> getAllmVids(){
		return moniterVideoDao.selAllmVids();
	}
	
	/**
	 * 获取视频详情，用于视频播放页
	 * @author SilentWhale
	 */
	public VideoDetInfo getVidDetInfo(Integer vidID, String videoType){
		VideoDetInfo detInfo = new VideoDetInfo();
		
		if (vidID == null || videoType == null || videoType.length() < 1) {   //入参检查
			return null;
		} else {
			detInfo.setVidID(vidID);
		}
		
		if (videoType.equals("mVids")) {
			detInfo = moniterVideoDao.selSigmVidByID(vidID);
		}
		if (videoType.equals("rVids")) {
			detInfo = moniterVideoDao.selSigrVidByID(vidID);
		}
		if (videoType.equals("aVids")) {
			detInfo = moniterVideoDao.selSigaVidByID(vidID);
		}
		if (detInfo.getMptId() != null) {
			VideoDetInfo detInfoInMpt = moniterVideoDao.selSigMptByID(detInfo.getMptId());
			detInfo.setMptIP(detInfoInMpt.getMptIP() == null? "" : detInfoInMpt.getMptIP());
			detInfo.setMptName(detInfoInMpt.getMptName() == null? "" : detInfoInMpt.getMptName());
			detInfo.setLattitude(detInfoInMpt.getLattitude() == null? 0 : detInfoInMpt.getLattitude());
			detInfo.setLongtitude(detInfoInMpt.getLongtitude() == null? 0 : detInfoInMpt.getLongtitude());
			detInfo.setHeight(detInfoInMpt.getHeight() == null? 0 : detInfoInMpt.getHeight());
		}
		if (detInfo.getaRecId() != null) {
			VideoDetInfo detInfoInaRec = alarmRecordDao.selSigaRecByID(detInfo.getaRecId());
			detInfo.setStartTime(detInfoInaRec.getStartTime() == null? new java.sql.Date(0) : detInfoInaRec.getStartTime());
			detInfo.setIsConfirm(detInfoInaRec.getIsConfirm() == null? 0 : detInfoInaRec.getIsConfirm());
			detInfo.setIsAlarmed(detInfoInaRec.getIsAlarmed() == null? 0 : detInfoInaRec.getIsAlarmed());
		}
		return detInfo;
	}

	@Override
	public void insertVid(MoniterVideo moniterVideo) {
		moniterVideoDao.insertVid(moniterVideo);
	}

	public List<Object> mVidsListJson(){
		String str = null;
		List<Object> mVidsListJson = new ArrayList<Object>();
		List<MoniterVideo> mVideos = getAllmVids();
		
		for(MoniterVideo moniterVideo : mVideos){
			str = null;
			str = "{mVidName:'" + moniterVideo.getmVidName() + "',mVidGrnTime:'" + moniterVideo.getmVidGrnTime() + "',mVidUrl:'" + moniterVideo.getmVidUrl()
			 + "',mSkchImgUrl:'" + moniterVideo.getmSkchImgUrl() + "',vidType:'1',vidId:'"+ moniterVideo.getmVidId() + "'}";
			mVidsListJson.add(str);
		}
		
		return mVidsListJson;	
	}
	
	
	/**
	 * 按类型查找视频
	 */
	public List<Object> getDSrchResult(SrchBody srchBody){
		

		List<Object> dVidsListJson = new ArrayList<Object>();
		List<MoniterVideo> moniterVideos = new ArrayList<MoniterVideo>();
		List<RecordVideo> recordVideos = new ArrayList<RecordVideo>();
		List<AlarmVideo> alarmVideos = new ArrayList<AlarmVideo>();
		
		switch (srchBody.getVidType()) {
		case 1:
			srchBody.setSrchRange("monitervideo");
			if (srchBody.getMptInfo() == ""){	//没有监控点信息
				moniterVideos = moniterVideoDao.GselmVids(srchBody);
			} else {
				switch (srchBody.getMptInfoType()){
				case 1:
					srchBody.setMptInfoDesc("mptId");				
					moniterVideos = moniterVideoDao.selSinmVidAllInfoByMptID(Integer.parseInt(srchBody.getMptInfo()));
					if (srchBody.getEndDate() != null || srchBody.getStartDate() != null) {  //如果搜索条件中包含日期，那么在结果集中进一步筛选
						moniterVideos = pickmVidByDate(moniterVideos, srchBody);
					} 
					break;
				case 2:
					srchBody.setMptInfoDesc("mptIP");
					MonitorPoint monitorPointIP = moniterVideoDao.GselVidsByMptIP(srchBody);				
					moniterVideos = monitorPointIP.getMoniterVideos();
					if (srchBody.getEndDate() != null || srchBody.getStartDate() != null) {   
						moniterVideos = pickmVidByDate(moniterVideos, srchBody);
					} 				
					break;
				case 3:
					srchBody.setMptInfoDesc("mptName");  //监控点名称支持模糊查找
					List<MonitorPoint> monitorPoints = moniterVideoDao.selmptsWithName(srchBody);
					for(MonitorPoint monitorPoint : monitorPoints){
						moniterVideos.addAll(moniterVideoDao.selSinmVidAllInfoByMptID(monitorPoint.getMptId()));
					}
					if (srchBody.getEndDate() != null || srchBody.getStartDate() != null){
						moniterVideos = pickmVidByDate(moniterVideos, srchBody);
					}
					break;
				}				
			}			
			dVidsListJson = transToSum(moniterVideos, null, null);
			break;
		case 2:
			srchBody.setSrchRange("RecordVideo");
			if (srchBody.getMptInfo() == ""){	//没有监控点信息
				recordVideos = moniterVideoDao.GselrVids(srchBody);
			} else {
				switch (srchBody.getMptInfoType()){
				case 1:
					srchBody.setMptInfoDesc("mptId");				
					recordVideos = moniterVideoDao.selSinrVidAllInfoByMptID(Integer.parseInt(srchBody.getMptInfo()));
					if (srchBody.getEndDate() != null || srchBody.getStartDate() != null) {  //如果搜索条件中包含日期，那么在结果集中进一步筛选
						recordVideos = pickrVidByDate(recordVideos, srchBody);
					} 
					break;
				case 2:
					srchBody.setMptInfoDesc("mptIP");
					MonitorPoint monitorPointIP = moniterVideoDao.GselVidsByMptIP(srchBody);				
					recordVideos = monitorPointIP.getRecordVideos();
					if (srchBody.getEndDate() != null || srchBody.getStartDate() != null) {   
						recordVideos = pickrVidByDate(recordVideos, srchBody);
					} 				
					break;
				case 3:
					srchBody.setMptInfoDesc("mptName");  //监控点名称支持模糊查找
					List<MonitorPoint> monitorPoints = moniterVideoDao.selmptsWithName(srchBody);
					for(MonitorPoint monitorPoint : monitorPoints){
						recordVideos.addAll(moniterVideoDao.selSinrVidAllInfoByMptID(monitorPoint.getMptId()));
					}
					if (srchBody.getEndDate() != null || srchBody.getStartDate() != null){
						recordVideos = pickrVidByDate(recordVideos, srchBody);
					}
					break;
				}				
			}		
			dVidsListJson = transToSum(null, recordVideos, null);
			break;
		case 3:
			srchBody.setSrchRange("AlarmVideo");
			if (srchBody.getMptInfo() == ""){	//没有监控点信息
				alarmVideos = moniterVideoDao.GselaVids(srchBody);
			} else {
				switch (srchBody.getMptInfoType()){
				case 1:
					srchBody.setMptInfoDesc("mptId");				
					alarmVideos = moniterVideoDao.selSinaVidAllInfoByMptID(Integer.parseInt(srchBody.getMptInfo()));
					if (srchBody.getEndDate() != null || srchBody.getStartDate() != null) {  //如果搜索条件中包含日期，那么在结果集中进一步筛选
						alarmVideos = pickaVidByDate(alarmVideos, srchBody);
					} 
					break;
				case 2:
					srchBody.setMptInfoDesc("mptIP");
					MonitorPoint monitorPointIP = moniterVideoDao.GselVidsByMptIP(srchBody);				
					alarmVideos = monitorPointIP.getAlarmVideos();
					if (srchBody.getEndDate() != null || srchBody.getStartDate() != null) {   
						alarmVideos = pickaVidByDate(alarmVideos, srchBody);
					} 				
					break;
				case 3:
					srchBody.setMptInfoDesc("mptName");  //监控点名称支持模糊查找
					List<MonitorPoint> monitorPoints = moniterVideoDao.selmptsWithName(srchBody);
					for(MonitorPoint monitorPoint : monitorPoints){
						alarmVideos.addAll(moniterVideoDao.selSinaVidAllInfoByMptID(monitorPoint.getMptId()));
					}
					if (srchBody.getEndDate() != null || srchBody.getStartDate() != null){
						alarmVideos = pickaVidByDate(alarmVideos, srchBody);
					}
					break;
				}				
			}
			dVidsListJson = transToSum(null, null, alarmVideos);
			break;
		}
			
		
		
		//------------------选择搜索方式----------------------------------------
		
//		switch (srchBody.getVidType()) {
//		case 1:
//			srchBody.setSrchRange("monitervideo");
//			List<MoniterVideo> mVideos = moniterVideoDao.selSrchResultByDate(srchBody);
//			for(MoniterVideo moniterVideo : mVideos){
//				str = null;
//				str = "{mVidName:'" + moniterVideo.getmVidName() + "',mVidGrnTime:'" + moniterVideo.getmVidGrnTime() + "',mVidUrl:'" + moniterVideo.getmVidUrl()
//				 + "',mSkchImgUrl:'" + moniterVideo.getmSkchImgUrl() + "',vidType:'1',vidId:'"+ moniterVideo.getmVidId() + "'}";
//				mVidsListJson.add(str);
//			}
//			break;
//		case 2:
//			srchBody.setSrchRange("RecordVideo");
//			List<RecordVideo> rVideos = moniterVideoDao.selrSrchResultByDate(srchBody);
//			for(RecordVideo recordVideo : rVideos){
//				str = null;
//				str = "{mVidName:'" + recordVideo.getrVidName() + "',mVidGrnTime:'" + recordVideo.getStartTime() + "',mVidUrl:'" + recordVideo.getrVidUrl()
//				 + "',mSkchImgUrl:'" + recordVideo.getSkchImgUrl() + "',vidType:'2',vidId:'"+ recordVideo.getrVidId() + "'}";
//				mVidsListJson.add(str);
//			}
//			break;
//		case 3:
//			srchBody.setSrchRange("AlarmVideo");
//			List<AlarmVideo> aVideos = moniterVideoDao.selaSrchResultByDate(srchBody);
//			for(AlarmVideo alarmVideo : aVideos){
//				str = null;
//				str = "{mVidName:'" + alarmVideo.getaVidName() + "',mVidGrnTime:'" + alarmVideo.getStartTime() + "',mVidUrl:'" + alarmVideo.getaVidUrl()
//				 + "',mSkchImgUrl:'" + alarmVideo.getSkchImgUrl() + "',vidType:'3',vidId:'"+ alarmVideo.getaVidId() + "'}";
//				mVidsListJson.add(str);
//			}
//			break;
//
//		default:
//			srchBody.setSrchRange("monitervideo");
//			List<MoniterVideo> mVideosDef = moniterVideoDao.selSrchResultByDate(srchBody);
//			for(MoniterVideo moniterVideo : mVideosDef){
//				str = null;
//				str = "{mVidName:'" + moniterVideo.getmVidName() + "',mVidGrnTime:'" + moniterVideo.getmVidGrnTime() + "',mVidUrl:'" + moniterVideo.getmVidUrl()
//				 + "',mSkchImgUrl:'" + moniterVideo.getmSkchImgUrl() + "',vidType:'1',vidId:'"+ moniterVideo.getmVidId() + "'}";
//				mVidsListJson.add(str);
//			}
//			break;
//		}
		

		return dVidsListJson;
	}
	
	/**
	 * 全局搜索，搜索范围是3个表中的所有视频
	 */
	public List<Object> GlobalSrch(SrchBody srchBody){
		

		List<Object> gVidsListJson = new ArrayList<Object>();

		//---------------------------- 大换血  任何一个条件都可能为空 -------------------------


		//先处理单表的部分,即监控点关键词为空，这里不考虑mptInfoType，因为无论输入什么关键词类型，关键词为空那就是无效的
		if (srchBody.getMptInfo() == "") {

			List<MoniterVideo> moniterVideos = moniterVideoDao.GselmVids(srchBody);
			List<RecordVideo> recordVideos = moniterVideoDao.GselrVids(srchBody);
			List<AlarmVideo> alarmVideos = moniterVideoDao.GselaVids(srchBody);
			gVidsListJson = transToSum(moniterVideos, recordVideos, alarmVideos);

		} else { //监控点信息不为空的情况下

			List<MoniterVideo> moniterVideos = new ArrayList<MoniterVideo>();
			List<RecordVideo> recordVideos = new ArrayList<RecordVideo>();
			List<AlarmVideo> alarmVideos = new ArrayList<AlarmVideo>();

			switch (srchBody.getMptInfoType()) {
			case 1:
				srchBody.setMptInfoDesc("mptId");
				moniterVideos = moniterVideoDao.selSinmVidAllInfoByMptID(Integer.parseInt(srchBody.getMptInfo()));
				recordVideos = moniterVideoDao.selSinrVidAllInfoByMptID(Integer.parseInt(srchBody.getMptInfo()));
				alarmVideos = moniterVideoDao.selSinaVidAllInfoByMptID(Integer.parseInt(srchBody.getMptInfo()));
				if (srchBody.getEndDate() != null || srchBody.getStartDate() != null) {  //如果搜索条件中包含日期，那么在结果集中进一步筛选
					moniterVideos = pickmVidByDate(moniterVideos, srchBody);
					recordVideos = pickrVidByDate(recordVideos, srchBody);
					alarmVideos = pickaVidByDate(alarmVideos, srchBody);
				}
				gVidsListJson = transToSum(moniterVideos, recordVideos, alarmVideos);
				break;
			case 2:
				srchBody.setMptInfoDesc("mptIP");
				MonitorPoint monitorPointIP = moniterVideoDao.GselVidsByMptIP(srchBody);
				moniterVideos = monitorPointIP.getMoniterVideos();
				recordVideos = monitorPointIP.getRecordVideos();
				alarmVideos = monitorPointIP.getAlarmVideos();
				if (srchBody.getEndDate() != null || srchBody.getStartDate() != null) {
					moniterVideos = pickmVidByDate(moniterVideos, srchBody);
					recordVideos = pickrVidByDate(recordVideos, srchBody);
					alarmVideos = pickaVidByDate(alarmVideos, srchBody);
				}
				gVidsListJson = transToSum(moniterVideos, recordVideos, alarmVideos);
				break;
			case 3:
				srchBody.setMptInfoDesc("mptName");  //监控点名称支持模糊查找
				List<MonitorPoint> monitorPoints = moniterVideoDao.selmptsWithName(srchBody);
				for(MonitorPoint monitorPoint : monitorPoints){
					moniterVideos.addAll(moniterVideoDao.selSinmVidAllInfoByMptID(monitorPoint.getMptId()));
					recordVideos.addAll(moniterVideoDao.selSinrVidAllInfoByMptID(monitorPoint.getMptId()));
					alarmVideos.addAll(moniterVideoDao.selSinaVidAllInfoByMptID(monitorPoint.getMptId()));
				}
				if (srchBody.getEndDate() != null || srchBody.getStartDate() != null){
					moniterVideos = pickmVidByDate(moniterVideos, srchBody);
					recordVideos = pickrVidByDate(recordVideos, srchBody);
					alarmVideos = pickaVidByDate(alarmVideos, srchBody);
				}
				gVidsListJson = transToSum(moniterVideos, recordVideos, alarmVideos);
				break;
			default:
				srchBody.setMptInfoDesc("mptId");
				moniterVideos = moniterVideoDao.selSinmVidAllInfoByMptID(Integer.parseInt(srchBody.getMptInfo()));
				recordVideos = moniterVideoDao.selSinrVidAllInfoByMptID(Integer.parseInt(srchBody.getMptInfo()));
				alarmVideos = moniterVideoDao.selSinaVidAllInfoByMptID(Integer.parseInt(srchBody.getMptInfo()));
				if (srchBody.getEndDate() != null || srchBody.getStartDate() != null) {  //如果搜索条件中包含日期，那么在结果集中进一步筛选
					moniterVideos = pickmVidByDate(moniterVideos, srchBody);
					recordVideos = pickrVidByDate(recordVideos, srchBody);
					alarmVideos = pickaVidByDate(alarmVideos, srchBody);
				}
				gVidsListJson = transToSum(moniterVideos, recordVideos, alarmVideos);
				break;
			}

		}

		//---------------------------- 大换血  任何一个条件都可能为空 -------------------------

		return gVidsListJson;
	}
	
	/**
	 * 删除视频
	 */
	public void delVids(List<SrchBody> srchBodies){
		
		for(SrchBody srchBody : srchBodies){
			
			switch (srchBody.getVidType()) {
			case 1:
				moniterVideoDao.delmVid(srchBody);
				break;
			case 2:
				moniterVideoDao.delrVid(srchBody);
				break;
			case 3:
				moniterVideoDao.delaVid(srchBody);
				break;
			default:
				System.out.println("Error");
				break;
			}
			
		}
	}
	
	/**
	 * 用于全局搜索，把三种类型的视频转化成统一格式的JSON数组
	 * 这个地方没有改成自动生成JSON串的原因是我需要捏造一个对象中没有的属性：vidType
	 * @param moniterVideos
	 * @param recordVideos
	 * @param alarmVideos
	 * @return
	 */
	public List<Object> transToSum(List<MoniterVideo> moniterVideos, List<RecordVideo> recordVideos, List<AlarmVideo> alarmVideos){
		
		String str = null;
		List<Object> gVidsListJson = new ArrayList<Object>();
		
		if (moniterVideos != null) {
			for(MoniterVideo moniterVideo : moniterVideos){
				str = null;
				str = "{mVidName:'" + moniterVideo.getmVidName() + "',mVidGrnTime:'" + moniterVideo.getmVidGrnTime() + "',mVidUrl:'" + moniterVideo.getmVidUrl()
				 + "',mSkchImgUrl:'" + moniterVideo.getmSkchImgUrl() + "',vidType:'1',vidId:'"+ moniterVideo.getmVidId() + "'}";
				gVidsListJson.add(str);
			}
		}
		
		if (recordVideos != null) {
			for(RecordVideo recordVideo : recordVideos){
				str = null;
				str = "{mVidName:'" + recordVideo.getrVidName() + "',mVidGrnTime:'" + recordVideo.getStartTime() + "',mVidUrl:'" + recordVideo.getrVidUrl()
				 + "',mSkchImgUrl:'" + recordVideo.getSkchImgUrl() + "',vidType:'2',vidId:'"+ recordVideo.getrVidId() + "'}";
				gVidsListJson.add(str);
			}
		}
		
		if (alarmVideos != null) {
			for(AlarmVideo alarmVideo : alarmVideos){
				str = null;
				str = "{mVidName:'" + alarmVideo.getaVidName() + "',mVidGrnTime:'" + alarmVideo.getStartTime() + "',mVidUrl:'" + alarmVideo.getaVidUrl()
				 + "',mSkchImgUrl:'" + alarmVideo.getSkchImgUrl() + "',vidType:'3',vidId:'"+ alarmVideo.getaVidId() + "'}";
				gVidsListJson.add(str);
			}
		}
				
		
		return gVidsListJson;
	}
	
	/**
	 * 从结果中剔除不符合日期搜索条件的mVid对象
	 * @param moniterVideos
	 * @param srchBody
	 * @return
	 */
	private List<MoniterVideo> pickmVidByDate(List<MoniterVideo> moniterVideos, SrchBody srchBody){
		
		Date startDate = srchBody.getStartDate();
		Date endDate = srchBody.getEndDate();
		
		if (startDate != null && endDate != null) {
			Iterator<MoniterVideo> iterator = moniterVideos.iterator();
			while(iterator.hasNext()){
				MoniterVideo moniterVideo = iterator.next();
				if((moniterVideo.getmVidGrnTime().after(endDate)) || (moniterVideo.getmVidGrnTime().before(startDate)))
	                iterator.remove();
			}
		} else if(startDate == null){
			Iterator<MoniterVideo> iterator = moniterVideos.iterator();
			while(iterator.hasNext()){
				MoniterVideo moniterVideo = iterator.next();
				if(moniterVideo.getmVidGrnTime().after(endDate))
	                iterator.remove();
			}
		} else {
			Iterator<MoniterVideo> iterator = moniterVideos.iterator();
			while(iterator.hasNext()){
				MoniterVideo moniterVideo = iterator.next();
				if(moniterVideo.getmVidGrnTime().before(startDate))
	                iterator.remove();
			}
		}
		
		return moniterVideos;
	}
	
	/**
	 * 从结果中剔除不符合日期搜索条件的rVid对象
	 * @param recordVideos
	 * @param srchBody
	 * @return
	 */
	private List<RecordVideo> pickrVidByDate(List<RecordVideo> recordVideos, SrchBody srchBody){
		Date startDate = srchBody.getStartDate();
		Date endDate = srchBody.getEndDate();
		
		if (startDate != null && endDate != null) {
			Iterator<RecordVideo> iterator = recordVideos.iterator();
			while(iterator.hasNext()){
				RecordVideo recordVideo = iterator.next();
				if((recordVideo.getStartTime().after(endDate)) || (recordVideo.getStartTime().before(startDate)))
	                iterator.remove();
			}			
		} else if(startDate == null){
			Iterator<RecordVideo> iterator = recordVideos.iterator();
			while(iterator.hasNext()){
				RecordVideo recordVideo = iterator.next();
				if(recordVideo.getStartTime().after(endDate))
	                iterator.remove();
			}
		} else {
			Iterator<RecordVideo> iterator = recordVideos.iterator();
			while(iterator.hasNext()){
				RecordVideo recordVideo = iterator.next();
				if(recordVideo.getStartTime().before(startDate))
	                iterator.remove();
			}
		}
		return recordVideos;
	}
	
	/**
	 * 从结果中剔除不符合日期搜索条件的aVid对象
	 * @param alarmVideos
	 * @param srchBody
	 * @return
	 */
	private List<AlarmVideo> pickaVidByDate(List<AlarmVideo> alarmVideos, SrchBody srchBody){
		Date startDate = srchBody.getStartDate();
		Date endDate = srchBody.getEndDate();
		
		if (startDate != null && endDate != null) {
			Iterator<AlarmVideo> iterator = alarmVideos.iterator();
			while(iterator.hasNext()){
				AlarmVideo alarmVideo = iterator.next();
				if((alarmVideo.getStartTime().after(endDate)) || (alarmVideo.getStartTime().before(startDate)))
	                iterator.remove();
			}			
		} else if(startDate == null){
			Iterator<AlarmVideo> iterator = alarmVideos.iterator();
			while(iterator.hasNext()){
				AlarmVideo alarmVideo = iterator.next();
				if(alarmVideo.getStartTime().after(endDate))
	                iterator.remove();
			}
		} else {
			Iterator<AlarmVideo> iterator = alarmVideos.iterator();
			while(iterator.hasNext()){
				AlarmVideo alarmVideo = iterator.next();
				if(alarmVideo.getStartTime().before(startDate))
	                iterator.remove();
			}
		}
		return alarmVideos;
	}
	
	
	
}
