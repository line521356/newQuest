package cn.kepu.questionnaire.service;

import cn.kepu.questionnaire.pojo.Message;

import java.util.List;

public interface IMessageService {

    void saveMessage(Message message);

    Message getMessageById(Integer id);

    Message getMessageByMptId(Integer id);
}
