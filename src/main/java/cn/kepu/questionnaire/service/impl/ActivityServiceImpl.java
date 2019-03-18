package cn.kepu.questionnaire.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import cn.kepu.questionnaire.dao.IActivityDao;
import cn.kepu.questionnaire.pojo.Activity;
import cn.kepu.questionnaire.service.IActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;



@Service("activityService")
public class ActivityServiceImpl implements IActivityService {
	
	
	@Autowired
	private IActivityDao activityDao;
	
	
	
	public void saveNewAct(Activity activity, MultipartFile actPic) throws IOException{
		
		String originalPicName = actPic.getOriginalFilename();
		
		if (actPic !=null && originalPicName!=null && originalPicName.length()>0)  {
			 
			String pic_path = "D:\\ProjectData\\ActHubPics\\";  
			   
	        // 新的图片名称  UUID.randomUUID()随机数  
	        String newFilename = UUID.randomUUID()  
	              + originalPicName.substring(originalPicName.lastIndexOf(".")); 
	        
	        File newfile=new java.io.File(pic_path+newFilename);  
	        //将内存的数据写入磁盘  
	        actPic.transferTo(newfile);  
	        //上传成功需要经新的图片名称写到activity对象  
	        activity.setActPicUrl(newFilename);
		}
		
		activityDao.istAct(activity);		

	}
	
	
	
	public List<Activity> getAllActs(){		
		return activityDao.selAllActs();
	}
	
	public List<Object> actsListJson(){
		
		String str = null;
		List<Object> actsListJson = new ArrayList<Object>();
		List<Activity> activities = getAllActs();
		
		for(Activity activity : activities){
			str = null;
			str = "{actId:'" + activity.getActId() + "',actName:'" + activity.getActName() + "',actIntro:'" + activity.getActIntro()
			 + "',actPicUrl:'" + activity.getActPicUrl() + "'}";
			actsListJson.add(str);
		}
		
		return actsListJson;		
	}
	
	
}
