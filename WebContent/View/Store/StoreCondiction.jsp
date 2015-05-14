<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<title> Welcome To &amp; Stamp </title>

<link href="../../js/jqGrid/jquery-ui/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="../../css/Bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" />
<link href="../../css/Bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link href="../../css/MenuBtn.css" rel="stylesheet" type ="text/css"/>
<link href="../../css/SearchArea.css" rel="stylesheet" type ="text/css"/>
<script src="../../js/jqGrid/js/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="../../js/datePicker/jquery-ui.js" type="text/javascript"></script>
<script src="../../js/datePicker/jquery.ui.datepicker-ko.js" type="text/javascript"></script>
<script src="../../js/gchart/jsapi.js" type="text/javascript"></script>

<script>
// Load the Visualization API and the piechart package.
google.load('visualization', '1.0', {'packages':['corechart']});

// Set a callback to run when the Google Visualization API is loaded.


// Callback that creates and populates a data table,
// instantiates the pie chart, passes in the data and
// draws it.
function drawChartGender(json) {

  // Create the data table.
  var data = new google.visualization.DataTable();
  data.addColumn('string', 'Topping');
  data.addColumn('number', 'Slices');
  data.addRows([
    ['남', json[0]],
    ['여', json[1]],
 
  ]);

  // Set chart options
  var options = {
        legend: {textStyle:{'fontSize':16}},
        pieSliceText: 'value',
        pieSliceTextStyle : {'fontSize':16},
        title: '성별에 따른 일일판매비율',
        pieStartAngle: 0,
        'height':300
      };

  // Instantiate and draw our chart, passing in some options.
  var chart = new google.visualization.PieChart(document.getElementById('GenderChart'));
  chart.draw(data, options);
}
function drawChartDateAges(value) {
	  // Create the data table.
	 var data = google.visualization.arrayToDataTable([
                                              ["Element", "Amount", { role: "style" } ],
                                              ["10대", value[0], "#b87333"],
                                              ["20대", value[1], "silver"],
                                              ["30데", value[2], "gold"],
                                              ["40대", value[3], "color: #e5e4e2"],
                                              ["50대", value[4], "color: #432211"],
                                              ["60대", value[5], "color: #123444"]
                                            ]);

      var view = new google.visualization.DataView(data);
      view.setColumns([0, 1,
                       { calc: "stringify",
                         sourceColumn: 1,
                         type: "string",
                         role: "annotation" },
                       2]);

      var options = {
        title: "일일 연령별 매출현황",
        bar: {groupWidth: "95%"},
        legend: { position: "none" },
        'height':300
      };
      var chart = new google.visualization.ColumnChart(document.getElementById("DateAges"));
      chart.draw(view, options);
}
function drawChartMonthAges(value) {
	  // Create the data table.
	 var data = google.visualization.arrayToDataTable([
                                            ["Element", "Amount", { role: "style" } ],
                                            ["10대", value[0], "#b87333"],
                                            ["20대", value[1], "silver"],
                                            ["30데", value[2], "gold"],
                                            ["40대", value[3], "color: #e5e4e2"],
                                            ["50대", value[4], "color: #432211"],
                                            ["60대", value[5], "color: #123444"]
                                          ]);

    var view = new google.visualization.DataView(data);
    view.setColumns([0, 1,
                     { calc: "stringify",
                       sourceColumn: 1,
                       type: "string",
                       role: "annotation" },
                     2]);

    var options = {
      title: "당월 연령별 매출현황",
      bar: {groupWidth: "95%"},
      legend: { position: "none" },
      'height':300
    };
    var chart = new google.visualization.ColumnChart(document.getElementById("MonthAges"));
    chart.draw(view, options);
}
function drawChartWeekAges(value) {
	  // Create the data table.
	 var data = google.visualization.arrayToDataTable([
                                          ["Element", "Amount", { role: "style" } ],
                                          ["월", value[0], "#b87333"],
                                          ["화", value[1], "silver"],
                                          ["수", value[2], "gold"],
                                          ["목", value[3], "color: #e5e4e2"],
                                          ["금", value[4], "color: #432211"],
                                          ["토", value[5], "color: #123444"],
                                          ["일", value[5], "color: #ab34fd"]
                                        ]);

  var view = new google.visualization.DataView(data);
  view.setColumns([0, 1,
                   { calc: "stringify",
                     sourceColumn: 1,
                     type: "string",
                     role: "annotation" },
                   2]);

  var options = {
    title: "주간 매출현황",
    bar: {groupWidth: "95%"},
    legend: { position: "none" },
    'height':300
  };
  var chart = new google.visualization.ColumnChart(document.getElementById("WeekChart"));
  chart.draw(view, options);
}

function drawMountAmountChart() {

	 var materialChart;
     var data = new google.visualization.DataTable();
     data.addColumn('date', 'Month');
     data.addColumn('number', "사용량");

     data.addRows([
       [new Date(2014,0),  5.7],
       [new Date(2014, 1),  8.7],
       [new Date(2014, 2),   12],
       [new Date(2014, 3), 15.3],
       [new Date(2014, 4), 18.6],
       [new Date(2014, 5), 20.9],
       [new Date(2014, 6), 19.8],
       [new Date(2014, 7), 16.6],
       [new Date(2014, 8), 13.3],
       [new Date(2014, 9),  9.9],
       [new Date(2014, 10),  6.6],
       [new Date(2014, 11),  4.5]
     ]);

     var materialOptions = {
       
         title: '월별 사용량',legend:'none'
     
     };

 
      var chart = new google.visualization.LineChart(document.getElementById('MonthAmount'));

      chart.draw(data, materialOptions);
    }
$(document).ready(function() {
	var Session_No = '<%= (String)session.getAttribute("Store_No") %>';
	if(Session_No == 'null') {
		document.location.href = "../Home/Login.jsp";
	}
	else{
		var test = new Array();
		var test2 = new Array();
		var test3 = new Array();
		var gender = new Array();
		test.push(1);
		test.push(2);
		test.push(3);
		test.push(4);
		test.push(5);
		test.push(6);
		test2.push(10);
		test2.push(20);
		test2.push(30);
		test2.push(40);
		test2.push(50);
		test2.push(60);
		test3.push(10);
		test3.push(20);
		test3.push(30);
		test3.push(40);
		test3.push(50);
		test3.push(60);
		test3.push(70);
		gender.push(202);
		gender.push(16);
		google.setOnLoadCallback(drawChartGender(gender));
		google.setOnLoadCallback(drawChartDateAges(test));
		google.setOnLoadCallback(drawChartMonthAges(test2));
		google.setOnLoadCallback(drawChartWeekAges(test2));
		google.setOnLoadCallback(drawMountAmountChart);
		
		$('#LogOut').on('click',function(){
			var LogOutMessage = confirm("정말 로그아웃하시겠습니까?");
			if(LogOutMessage){
				location.href= '../../Controller/Home/LogOut.jsp'
			}
		})
		
	}
});
</script>
</head>

<body>
<div id = 'header' class='clearfix'>
	<div id='IdArea' class='col-sm-12 col-xs-12 text-right clearfix'>
		<strong><%=session.getAttribute("ID")%></strong>님이 <strong>로그인</strong>하셨습니다.&nbsp;&nbsp;&nbsp;
		<button id = 'LogOut' class='btn btn-default'>로그아웃</button>
	</div>
	<div id = 'NavButton' class = 'col-sm-12 col-xs-12'>
		<input type = 'button' id = 'NavBtn' class = 'btn btn-default col-xs-12' value = '메뉴'/>
	</div>
	<div id = 'Nav' class= 'col-sm-12 col-xs-12 clearfix'>
		<a href= '../Home/Index.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>홈</a>
		<a href= '../Home/Reserve.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>적립하기</a>
		<a href= '../Member/MemberInsert.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
		<a href= '../Product/ProductInsert.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>교환상품등록</a>
		<a href= '../Product/ProductList.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>상품목록</a>
		<a href= '../Store/StoreCondiction.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>매장현황</a>
	</div>
	<br/>
</div>
<div id = 'container' class='clearfix'>
	<div class='col-sm-12 col-xs-12'>
		 <div class='col-sm-6 col-xs-12 clearfix'>
		 	<div id="DateAges" ></div>
		 </div>
		 <div class='col-sm-6 col-xs-12 clearfix'>
		 	<div id="MonthAges" ></div>
		 </div>
		 <div class='col-sm-6 col-xs-12 clearfix'>
		 	<div id="GenderChart"></div>
		 </div>
		 <div class='col-sm-6 col-xs-12 clearfix'>
		 	<div id="WeekChart"></div>
		 </div>
		 <div class='col-sm-12 col-xs-12 clearfix'>
		 	<div id="MonthAmount" ></div>
		 </div>
	</div>
	<br><br>
	<div class='row col-sm-12 col-xs-12'>
	</div>
	<button id='test'>test</button>
</div>

</body>
</html>