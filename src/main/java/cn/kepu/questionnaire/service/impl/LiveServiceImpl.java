package cn.kepu.questionnaire.service.impl;

import cn.kepu.questionnaire.dao.IMoniterVideoDao;
import cn.kepu.questionnaire.pojo.MonitorPoint;
import cn.kepu.questionnaire.service.ILiveService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class LiveServiceImpl implements ILiveService {

    @Resource
    IMoniterVideoDao iMoniterVideoDao;

    @Override
    public List<MonitorPoint> getAllPoint() {
        return iMoniterVideoDao.getAllMonitorPoint();
    }
}
