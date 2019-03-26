package cn.kepu.questionnaire.scheduleds;

import cn.kepu.questionnaire.pojo.MoniterVideo;
import cn.kepu.questionnaire.service.IMoniterVideoService;
import cn.kepu.questionnaire.utils.FfmpegUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Date;

//@Component
public class LiveVideoBackUpScheduled {

    @Value("${live.rtmp-url}")
    String liveUrl;

    @Value("${live.backup-path}")
    String backupPath;

    @Value("${live.backup-path-virtual}")
    String backupPathVirtual;

    @Value("${live.pic-path}")
    String picPath;

    @Value("${live.pic-path-virtual}")
    String picPathVirtual;

    @Autowired
    IMoniterVideoService iMoniterVideoService;

    @Scheduled(cron = "0 0/5 * * * ? ")
    public void videoBackUp(){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmm");
        Date now = new Date();
        String fileName = simpleDateFormat.format(now) + ".mp4";
        String picName = simpleDateFormat.format(now) + ".jpg";
        String fileSavePath = backupPath + fileName;
        String picSavePath = picPath + picName;
        try {
            new Thread(() -> {
                try {
                    FfmpegUtil.saveVideoPic(liveUrl,picSavePath);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }).start();
            new Thread(() -> {
                try {
                    FfmpegUtil.frameRecord(liveUrl,fileSavePath,1);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }).start();
            MoniterVideo moniterVideo = new MoniterVideo();
            moniterVideo.setmVidName(simpleDateFormat.format(now)+"监控视频");
            moniterVideo.setmVidGrnTime(new java.sql.Date(now.getTime()));
            moniterVideo.setmVidUrl("mVids/"+fileName);
            moniterVideo.setmSkchImgUrl(picName);
            moniterVideo.setMptId(1);
            iMoniterVideoService.insertVid(moniterVideo);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
