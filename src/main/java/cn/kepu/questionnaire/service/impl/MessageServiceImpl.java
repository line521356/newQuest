package cn.kepu.questionnaire.service.impl;

import cn.kepu.questionnaire.dao.IMessageDao;
import cn.kepu.questionnaire.pojo.Message;
import cn.kepu.questionnaire.service.IMessageService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class MessageServiceImpl implements IMessageService {

    @Resource
    IMessageDao iMessageDao;

    @Override
    public void saveMessage(Message message) {
        iMessageDao.deleteMessage(message.getPointId());
        iMessageDao.saveMessage(message);
    }

    @Override
    public Message getMessageById(Integer id) {
        return iMessageDao.getMessageById(id);
    }

    @Override
    public Message getMessageByMptId(Integer id) {
        return iMessageDao.getMessageByMptId(id);
    }
}
