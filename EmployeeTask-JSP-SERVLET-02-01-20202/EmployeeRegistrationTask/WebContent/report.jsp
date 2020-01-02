<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Employee Report</title>
	
	<link rel="stylesheet" type="text/css" href="css/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap/bootstrap-theme.min.css">
    <link rel="stylesheet" type="text/css" href="css/custome/insertform.css">
    
</head>
<body>
	<div class="row">
		<div class="col-md-1"></div>
		<div class="btn col-md-5" style="background-color: red; color: white; height: 150px; margin-top: 30px;" >
			<h1>Manager</h1>
			<h1><span class="label label-default">${report.manager}</span></h1>
		</div>
		<div class="btn col-md-5" style="background-color: green; color: white; height: 150px; margin-top: 30px; margin-left:10px; ">
			<h1>Dy. Manager</h1>
			<h1><span class="label label-default">${report.dyManager}</span></h1>		
		</div>
	</div>
	<div class="row">
		<div class="col-md-1"></div>
		<div class="btn col-md-5" style="background-color: blue; color: white; height: 150px; margin-top: 10px;">
			<h1>Executive</h1>
			<h1><span class="label label-default">${report.executive}</span></h1>
		</div>
		<a class=" btn col-md-5" href="index.jsp" style="background-color: Orange; font-size:40px; color: white; height: 150px; margin-top: 10px; margin-left:10px;">
			HomePage
		</a>
	</div>
</body>
</html>