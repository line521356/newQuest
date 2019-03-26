package cn.kepu.questionnaire.config;

import cn.kepu.questionnaire.pojo.MonitorPoint;
import cn.kepu.questionnaire.service.ILiveService;
import cn.kepu.questionnaire.utils.FfmpegUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Configuration
public class StreamConfig {

    @Value("${live.rtmp-url}")
    String baseLiveIp;

    @Autowired
    ILiveService iLiveService;

    @Bean
    public void rtsp2rtmp(){
        List<MonitorPoint> monitorPointList = iLiveService.getAllPoint();
        for (MonitorPoint monitorPoint : monitorPointList) {
            new Thread(() -> {
                String ip = monitorPoint.getMptIP();
                String rtmpUrl = baseLiveIp + ip;
                String rtspUrl = "rtsp://admin:GYDHJM@" + ip + ":554/h264/ch1/main/av_stream";
                try {
                    FfmpegUtil.recordPush(rtspUrl,rtmpUrl,20);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }).start();
        }
    }

}
