package cn.kepu.questionnaire.mythread;

import cn.kepu.questionnaire.utils.FfmpegUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class SendStreamExecutor implements Runnable{

    @Value("${live.rtmp-url}")
    String rtmpUrl;

    @Value("${live.rtsp-url}")
    String rtspUrl;

    @Override
    public void run() {
        try {
            FfmpegUtil.recordPush(rtspUrl,rtmpUrl,25);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("推流器异常请及时检查");
        }
    }
}
