package cn.kepu.questionnaire.dao;

import cn.kepu.questionnaire.pojo.Message;

import java.util.List;

public interface IMessageDao {
    void saveMessage(Message message);

    Message getMessageById(Integer id);

    Message getMessageByMptId(Integer pointId);

    void deleteMessage(Integer pointId);
}
