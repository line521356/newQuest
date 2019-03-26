package cn.kepu.questionnaire.controller;

import cn.kepu.questionnaire.pojo.MonitorPoint;
import cn.kepu.questionnaire.service.ILiveService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/live")
public class LiveController {

    @Autowired
    ILiveService iLiveService;

    @Value("${live.rtmp-url}")
    String baseLiveIp;

    @GetMapping("/live")
    public String live(){
        return "livePages/liveList";
    }

    @GetMapping("/getAllPoint")
    @ResponseBody
    public JSONObject getAllPoint(){
        List <MonitorPoint> monitorPointList = iLiveService.getAllPoint();
        JSONObject result = new JSONObject();
        result.put("data", monitorPointList);
        result.put("code", 0);
        result.put("msg", "");
        return result;

    }

    @GetMapping("/video")
    public String video(String ip,Model model){
        String url = baseLiveIp + ip;
        model.addAttribute("url",url);
        return "livePages/live";
    }

}
