package cn.kepu.questionnaire.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.kepu.questionnaire.dao.IShotCutDao;
import cn.kepu.questionnaire.pojo.MonitorPoint;
import cn.kepu.questionnaire.pojo.ShotCutImg;
import cn.kepu.questionnaire.service.IShotCutService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service("shotCutService")
public class ShotCutServiceImpl implements IShotCutService {

	@Autowired
	IShotCutDao shotCutDao;
	
	
	/**
	 * 获取所有截图
	 */
	public List<ShotCutImg> getAllShots(){
		List<ShotCutImg> imgs = shotCutDao.selAllShots();
		for(ShotCutImg img : imgs){
			img.setSrcMonitor(shotCutDao.selMptNameByID(img.getMptId()));
			img.setSrcCrew(shotCutDao.selCrewNameByID(img.getCrewID()));
		}
		return imgs;
	}
	
	public void delImg(Integer scImgId){
		shotCutDao.delImgByID(scImgId);		
	}
	
	/**
	 * 搜索图片
	 */
	public List<ShotCutImg> srchImgs(Integer kwType, String keyWord,Integer imgType, String recTime_st, String recTime_ed){
		List<ShotCutImg> resImgs = new ArrayList<ShotCutImg>();
		if (kwType != null && kwType == 1) {				//根据监控点ID搜索
			resImgs = shotCutDao.selImgsByMptID(Integer.parseInt(keyWord), imgType, recTime_st, recTime_ed);
		}
		if (kwType != null && kwType == 2) {				//根据监控点名称搜索			
			List<MonitorPoint> mpts = shotCutDao.selMptsByName(keyWord);
			if (mpts.size() > 0) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("mpts", mpts);
				map.put("scImgType", imgType);
				map.put("startDate", recTime_st);
				map.put("endDate", recTime_ed);
				resImgs = shotCutDao.selImgsByMptName(map);
			}
		}
		if (kwType != null && kwType == 3) {				//根据图片ID搜索，其他参数全部作废
			resImgs.add(shotCutDao.selImgByID(Integer.parseInt(keyWord)));		
		}
		if (kwType == null) {								//根据日期与图片类型查表
			resImgs = shotCutDao.selImgsByTypeNDate(imgType, recTime_st, recTime_ed);
		}
		return resImgs;
	}
	
}
