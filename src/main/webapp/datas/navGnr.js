var navsGnr = [{
	"title": "火情影像资源管理",
	"icon": "fa-camera-retro",
	"spread": true,
	"children": [{
		"title": "监控视频管理",
		"icon": "fa-camera-retro",
		"href": "mVid/toVideoBoard2"   
	}, {
		"title": "图片浏览",
		"icon": "&#xe64a;",
		"href": "shotcut/checkAllShots"
	}, {
		"title": "图片管理",
		"icon": "&#xe634",
		"href": "shotcut/checkImgList"
	},{
        "title":"视频监控直播",
        "icon": "&#xe634",
        "href":"live/live"
    }]
}, {
	"title": "报警记录管理",
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
	"title": "火情处理",
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
	"title": "扑救资源管理",
	"icon": "fa-cubes",
	"spread": false,
	"children": [{
		"title": "扑救资源列表",
		"icon": "&#xe62d;",
		"href": "emrPlan/ffSrcList"
	}]
}];
