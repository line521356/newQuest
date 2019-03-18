package cn.kepu.questionnaire.service;


import cn.kepu.questionnaire.pojo.ShotCutImg;

import java.util.List;

public interface IShotCutService {

	
	List<ShotCutImg> getAllShots();
	
	void delImg(Integer scImgId);
	
	List<ShotCutImg> srchImgs(Integer kwType, String keyWord,Integer imgType, String recTime_st, String recTime_ed);
}
