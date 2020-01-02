<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Home Page</title>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="css/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap/bootstrap-theme.min.css">
    <link rel="stylesheet" type="text/css" href="css/custome/insertform.css">
    <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<div class="container">
		<div class="row">
			<a class="btn btn-info" href="/EmployeeRegistrationTask/HomeController?type=register">Employee Registration</a>
		</div>
		<div class="row">
			<a class="btn btn-info" href="/EmployeeRegistrationTask/HomeController?type=search">Employee Search</a>
		</div>
		<div class="row">
			<a class="btn btn-info" href="/EmployeeRegistrationTask/HomeController?type=report">Employee Report</a>
		</div>
</div>
</body>
</html>