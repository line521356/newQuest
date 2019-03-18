<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

<title>活动中心</title>
</head>

<body>
	
	<div id="allActsDisplay"></div>
	
	
	<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="/js/react.js"></script>
	<script type="text/javascript" src="/js/react-dom.js"></script>
	<script type="text/javascript" src="/js/browser.min.js"></script>
	<script type="text/babel">

			

          var UserGist = React.createClass({
  				getInitialState: function() {
    			return {
      				actName: '',
      				actIntro: ''
    			};
  		  },

  			componentDidMount: function() {
    			$.get(this.props.source, function(result) {
					
					receiveData(result);

      				var crtAct = result[0];

      				if (this.isMounted()) {
       			 		this.setState({
          					actName: crtAct.actName,
          					actIntro: crtAct.actIntro
        				});
						console.log(crtAct.actName + "????" );
      				}
    			}.bind(this));
  			},

  			render: function() {
    			return (
      				<div>
        			{this.state.actName} is the Name and {this.state.actIntro} is the intro.
      				</div>
   	 				);
  				}
			});

		
		function receiveData(result){
			console.log(result);
		}

		ReactDOM.render(
  			<UserGist source="${pageContext.request.contextPath }/act/getAllActs" />,
  			document.getElementById('allActsDisplay')
		);
    </script>
</body>
</html>