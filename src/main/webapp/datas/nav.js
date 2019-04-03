var navs = [{
	"title": "流媒体服务管理",
	"icon": "fa-camera-retro",
	"spread": true,
	"children": [{
		"title": "历史视频点播",
		"icon": "fa-camera-retro",
		"href": "mVid/toVideoBoard2"   
	}, {
		"title":"实时监控查看",
		"icon":"&#xe634",
		"href":"live/live"
	}]
}, {
    "title": "图片资源管理",
    "icon": "&#xe64a;",
    "spread": false,
    "children": [{
        "title": "图片浏览",
        "icon": "&#xe64a;",
        "href": "shotcut/checkAllShots"
    }, {
        "title": "图片管理",
        "icon": "&#xe634;",
        "href": "shotcut/checkImgList"
    }]
},{
	"title": "林火报警管理",
	"icon": "fa-bell",
	"spread": false,
	"children": [{
		"title": "报警处理",
		"icon": "&#xe645;",
		"href": "alrmRec/toAlrmManage"
	}, {
		"title": "统计数据",
		"icon": "fa-bar-chart",
		"href": "stat/toStatBoard"
	}]
}, {
	"title": "救灾预案管理",
	"icon": "fa-map-pin",
	"spread": false,
	"children": [{
		"title": "扑救方案",
		"icon": "&#xe63c;",
		"href": "map/mapView"
	}]
}, {
	"title": "扑火预案管理",
	"icon": "fa-list-alt",
	"spread": false,
	"children": [{
		"title": "扑火预案列表",
		"icon": "&#xe62a;",
		"href": "emrPlan/planList"
	}, {
		"title": "创建扑火预案",
		"icon": "fa-plus-square-o",
		"href": "emrPlan/createNew"
	}]
}, {
	"title": "救灾资源管理",
	"icon": "fa-cubes",
	"spread": false,
	"children": [{
		"title": "扑救资源列表",
		"icon": "&#xe62d;",
		"href": "emrPlan/ffSrcList"
	}]
}, {
	"title": "系统管理",
	"icon": "fa-cogs",
	"spread": false,
	"children": [{
		"title": "用户管理",
		"icon": "&#xe613;",
		"href": "user/userList"
	}, {
		"title": "日志管理",
		"icon": "&#xe60a;",
		"href": "user/logList"
	}]
}];
