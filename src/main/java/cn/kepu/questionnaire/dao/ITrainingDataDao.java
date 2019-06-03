package cn.kepu.questionnaire.dao;

import cn.kepu.questionnaire.pojo.TrainingData;

import java.util.List;

public interface ITrainingDataDao {

    List<TrainingData> selectAllTrainingData();
}
