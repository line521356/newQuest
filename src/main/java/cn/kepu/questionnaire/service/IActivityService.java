package cn.kepu.questionnaire.service;

import java.io.IOException;
import java.util.List;

import cn.kepu.questionnaire.pojo.Activity;
import org.springframework.web.multipart.MultipartFile;


public interface IActivityService {

	void saveNewAct(Activity activity, MultipartFile actPic) throws IOException;
	
	List<Activity> getAllActs();
	
	List<Object> actsListJson();
}
