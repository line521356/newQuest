package cn.kepu.questionnaire.tree;

import java.util.ArrayList;
import java.util.List;

public class TreeNode {
    private String nodeName;

    public TreeNode(String nodeName) {
        this.nodeName = nodeName;
    }

    public String getNodeName() {
        return nodeName;
    }

    public void setNodeName(String nodeName) {
        this.nodeName = nodeName;
    }

    List <String> label=new ArrayList<>();//和子节点间的边标签

    ArrayList <TreeNode> node=new ArrayList<>();//对应子节点

}
