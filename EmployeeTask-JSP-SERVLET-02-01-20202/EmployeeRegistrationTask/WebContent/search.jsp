<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Employee Information</title>
	
	<link rel="stylesheet" type="text/css" href="css/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap/bootstrap-theme.min.css">
    <link rel="stylesheet" type="text/css" href="css/custome/insertform.css">
    
    <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" rel="stylesheet"/>
</head>
<body>
<div class="container">
	<table id="table">
		<thead>
			<tr>
				<th>First Name</th>
				<th>Last Name</th>
				<th>Email</th>
				<th>Contact</th>
				<th>Created On</th>
				<th>Updated On</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>
		 
		</tbody>
	</table>
	<a class="btn btn-default" href="index.jsp">HomePage</a>
</div>
</body>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/custom/search.js"></script>
<script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
</html>