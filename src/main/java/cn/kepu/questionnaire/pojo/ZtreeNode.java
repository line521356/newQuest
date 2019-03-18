package cn.kepu.questionnaire.pojo;

import java.util.List;

/**
 * 
 * 用于生成对应ZTree节点
 *
 */
public class ZtreeNode {
	
	
		private Integer id;
		private Integer pId;
		private String name;
		private Integer check_child_state;
		private Integer quesnrID; //定制属性（Ztree节点中没有该属性），表示该指派部门所关联的问卷ID
		private boolean open;  //是否默认打开
		private boolean nocheck; //是否可以选
		private boolean checked; //是否默认选上
		private List<ZtreeNode> children;
		
		
		public ZtreeNode() {
			super();
		}



		public ZtreeNode(Integer id, Integer pId, String name,
				Integer check_child_state, Integer quesnrID, boolean open,
				boolean nocheck, boolean checked, List<ZtreeNode> children) {
			super();
			this.id = id;
			this.pId = pId;
			this.name = name;
			this.check_child_state = check_child_state;
			this.quesnrID = quesnrID;
			this.open = open;
			this.nocheck = nocheck;
			this.checked = checked;
			this.children = children;
		}


		



		public Integer getQuesnrID() {
			return quesnrID;
		}



		public void setQuesnrID(Integer quesnrID) {
			this.quesnrID = quesnrID;
		}



		public Integer getId() {
			return id;
		}


		public void setId(Integer id) {
			this.id = id;
		}


		public Integer getpId() {
			return pId;
		}


		public void setpId(Integer pId) {
			this.pId = pId;
		}


		public String getName() {
			return name;
		}


		public void setName(String name) {
			this.name = name;
		}

		
		public boolean isOpen() {
			return open;
		}


		public void setOpen(boolean open) {
			this.open = open;
		}


		public boolean isNocheck() {
			return nocheck;
		}


		public void setNocheck(boolean nocheck) {
			this.nocheck = nocheck;
		}


		public boolean isChecked() {
			return checked;
		}


		public void setChecked(boolean checked) {
			this.checked = checked;
		}

		

		public List<ZtreeNode> getChildren() {
			return children;
		}


		public void setChildren(List<ZtreeNode> children) {
			this.children = children;
		}

		

		public Integer getCheck_child_state() {
			return check_child_state;
		}




		public void setCheck_child_state(Integer check_child_state) {
			this.check_child_state = check_child_state;
		}



		@Override
		public String toString() {
			return "ZtreeNode [id=" + id + ", pId=" + pId + ", name=" + name
					+ ", check_child_state=" + check_child_state
					+ ", quesnrID=" + quesnrID + ", open=" + open
					+ ", nocheck=" + nocheck + ", checked=" + checked
					+ ", children=" + children + "]";
		}




		




		


		


		
		
		
	
}
