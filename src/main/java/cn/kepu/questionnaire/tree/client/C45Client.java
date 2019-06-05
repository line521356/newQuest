package cn.kepu.questionnaire.tree.client;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cn.kepu.questionnaire.tree.core.C45Core;
import cn.kepu.questionnaire.tree.model.AttributeNode;
import cn.kepu.questionnaire.tree.utils.C45Utils;
import cn.kepu.questionnaire.tree.utils.DecisionTreeUtils;
import org.apache.log4j.spi.RootLogger;

public class C45Client {

    private List<List<String>> rawData;

    public static void main(String[] args) throws IOException {
//        C45Client c45Client = new C45Client(DecisionTreeUtils.getData());
//        AttributeNode attributeNode = c45Client.start();
//        List <String> strs = new ArrayList<>();
//        strs.add("小");
//        strs.add("<50");
//        strs.add("8-18");
//        strs.add("<4");
//        String res = c45Client.findLastLeaf(strs,attributeNode);
//        System.out.println(res);

    }

    public C45Client(List<List<String>> rawData) {
        this.rawData = rawData;
    }

    public String findLastLeaf(List<String>row,AttributeNode root){
        int count = 0;
       AttributeNode attributeNode = root;
       List <AttributeNode> attributeNodeList = null;
       Boolean flag = false;
       while(!attributeNode.isLeaf()||attributeNode.getChildNodes() != null||attributeNode.getChildNodes().size() == 0){
           attributeNodeList = attributeNode.getChildNodes();
           for (AttributeNode node : attributeNodeList) {
               if(row.contains(node.getAttributeName())){
                   attributeNode = node;
               }
               flag = node.isLeaf();
               if(flag){
                   attributeNode = node;
                   break;
               }
               count++;
           }
           if(flag){
               break;
           }
           if(count>2000){
               return null;
           }
       }
       return attributeNode.getAttributeName();
    }

    public AttributeNode start() {
        C45Utils.transformContinuouslyVariables(rawData);
        C45Core core = new C45Core();
        return createDecisionTree(core, rawData);
    }

    private AttributeNode createDecisionTree(C45Core core, List<List<String>> currentData) {
        Map<String, Double> maxIGRatioMap = core.maxInformationGainRatio(currentData);
        AttributeNode rootNode = new AttributeNode(maxIGRatioMap.keySet().iterator().next());
        setAttributeNodeStatus(core, currentData, rootNode);
//        DecisionTreeUtils.showDecisionTree(rootNode, "");
        return rootNode;
    }

    /**
     * 设置特征属性节点的分支及子节点
     *
     * @param core
     * @param currentData
     * @param node
     */
    private void setAttributeNodeStatus(C45Core core, List<List<String>> currentData, AttributeNode node) {
        List<String> attributeBranchList = DecisionTreeUtils.getAttributeBranchList(currentData, node.getAttributeName());
        int attributeIndex = DecisionTreeUtils.getAttributeIndex(currentData.get(0), node.getAttributeName());

        for (String attributeBranch : attributeBranchList) {
            List<List<String>> splitAttributeDataList = DecisionTreeUtils.splitAttributeDataList(currentData, attributeBranch, attributeIndex);
            buildDecisionTree(core, attributeBranch, splitAttributeDataList, node);
        }
    }

    /**
     * 构建 C4.5 决策树
     *
     * @param core
     * @param attributeBranch
     * @param splitAttributeDataList
     * @param node
     */
    private void buildDecisionTree(C45Core core, String attributeBranch, List<List<String>> splitAttributeDataList, AttributeNode node) {
        Map<String, Double> maxIGRatioMap = core.maxInformationGainRatio(splitAttributeDataList);

        String attributeName = maxIGRatioMap.keySet().iterator().next();
        double maxIG = maxIGRatioMap.get(attributeName);
        if (maxIG == 0.0) {
            List<String> singleLineData = splitAttributeDataList.get(splitAttributeDataList.size() - 1);

            AttributeNode leafNode = new AttributeNode(singleLineData.get(singleLineData.size() - 1));
            leafNode.setLeaf(true);
            leafNode.setParentStatus(attributeBranch);
            node.addChildNodes(leafNode);
            return;
        }

        AttributeNode attributeNode = getNewAttributeNode(attributeName, attributeBranch, node);

        setAttributeNodeStatus(core, splitAttributeDataList, attributeNode);
    }

    private AttributeNode getNewAttributeNode(String attributeName, String attributeBranch, AttributeNode node) {
        AttributeNode attributeNode = new AttributeNode(attributeName);
        attributeNode.setParentStatus(attributeBranch);
        node.addChildNodes(attributeNode);

        return attributeNode;
    }
}
