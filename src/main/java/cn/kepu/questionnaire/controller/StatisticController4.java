package cn.kepu.questionnaire.controller;

import cn.kepu.questionnaire.service.IStatisticService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;

@Controller
@RequestMapping("/stat")
public class StatisticController4 {
	
	@Autowired
	@Qualifier("statisticService")
	private IStatisticService statisticService;

	@RequestMapping("/toStatBoard")
	public String toStatBoard(){
		return "StatPages/StatBoard";
	}
	
	@RequestMapping("/chkStoreVid")
	@ResponseBody
	public JSONArray chkStoreVid(){
		int res[] = statisticService.chkStorage();
		String jsonMessage = "[{'name':'监控视频', 'value':" + res[1] + "}," +
				"{'name':'录制视频', 'value':" + res[2] + "}," +
				"{'name':'报警视频', 'value':" + res[3] + "}," +
				"{'name':'空闲内存', 'value':" + res[0] + "}]";
		JSONArray result = JSONArray.parseArray(jsonMessage);
		return result;
	}
	
}
