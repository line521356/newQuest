package cn.kepu.questionnaire.service.impl;

import cn.kepu.questionnaire.dao.ITrainingDataDao;
import cn.kepu.questionnaire.pojo.TrainingData;
import cn.kepu.questionnaire.service.ITrainingDataService;
import cn.kepu.questionnaire.tree.client.C45Client;
import cn.kepu.questionnaire.tree.model.AttributeNode;
import com.alibaba.fastjson.JSON;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class TrainingDataServiceImpl implements ITrainingDataService {

    @Resource
    ITrainingDataDao iTrainingDataDao;

    @Override
    public Integer trainData(List<String> data) {
        List<TrainingData>trainingDataList =  iTrainingDataDao.selectAllTrainingData();
        List <List <String>> list = new ArrayList<>();
        for (TrainingData trainingData : trainingDataList) {
            List <String> row = new ArrayList<>();
            row.add("1");
            row.add(Double.parseDouble(trainingData.getPrecipitation())>2?"大":"小");
            double temp = Double.parseDouble(trainingData.getTemperature());
            if(temp<0){
                row.add("<0");
            }else if(temp<8){
                row.add("0-8");
            }else if(temp<18){
                row.add("8-18");
            }else {
                row.add(">=18");
            }
            double wind = Double.parseDouble(trainingData.getWindPower());
            if(wind>4){
                row.add(">4");
            }else{
                row.add("<4");
            }
            double rh = Double.parseDouble(trainingData.getHumidity());
            if(rh<50){
                row.add("<50");
            }else if(rh<65){
                row.add("50-65");
            }else if(rh<80){
                row.add("65-80");
            }else {
                row.add(">=80");
            }
            row.add(trainingData.getPlanId() + "");
            list.add(row);
        }
        C45Client c45Client = new C45Client(list);
        AttributeNode attributeNode = c45Client.start();
        System.out.println(JSON.toJSON(attributeNode));
        String res = c45Client.findLastLeaf(data,attributeNode);
        return res == null?null:Integer.parseInt(res);
    }
}
