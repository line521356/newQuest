package cn.kepu.questionnaire.tree.model;

import java.util.ArrayList;
import java.util.List;

/**
 * 节点
 */
public class AttributeNode {

    private String attributeName = null;
    private List<AttributeNode> childNodes = null;
    private String parentStatus = null; // 父节点的状态（表示的是从父节点过度到当前节点时的状态）
    
    private boolean isLeaf = false; // 是否是叶子节点
//    private String leafValue = null; // 叶子节点的值
    
    public AttributeNode(String attributeName) {
        this.attributeName = attributeName;
    }
    
    public String getAttributeName() {
        return attributeName;
    }
    
    public List<AttributeNode> getChildNodes() {
        return childNodes;
    }
    
    public void addChildNodes(AttributeNode node) {
        if (childNodes == null) {
            childNodes = new ArrayList<>();
        }
        
        childNodes.add(node);
    }
    
    public void setParentStatus(String parentStatus) {
        this.parentStatus = parentStatus;
    }
    
    public String getParentStatus() {
        return parentStatus;
    }
    
    // TODO ---------------------- leaf node -------------------------------
    
    public void setLeaf(boolean isLeaf) {
        this.isLeaf = isLeaf;
    }
    
    public boolean isLeaf() {
        return isLeaf;
    }
    
//    public void setLeafValue(String leafValue) {
//        this.leafValue = leafValue;
//    }
//    
//    public String getLeafValue() {
//        return leafValue;
//    }
    
//    @Override
//    public String toString() {
//        return "{" + (parentStatus == null ? "" : parentStatus) + "-" + (isLeaf ? leafValue : attributeName + ": " + childNodes) + "}";
//    }
}
