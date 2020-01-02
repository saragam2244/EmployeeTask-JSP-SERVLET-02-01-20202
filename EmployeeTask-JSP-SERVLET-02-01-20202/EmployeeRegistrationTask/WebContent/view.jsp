<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
	<title>EmployeeRedistration</title>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="css/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap/bootstrap-theme.min.css">
    <link rel="stylesheet" type="text/css" href="css/custome/insertform.css">
    <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<div class="row" style="margin-top: 50px;">
<div class="col-md-1"></div>
<div class="col-md-10">
	<div class="row"  style="margin :30px;">
		<div class="col-md-2"></div>
		<div class="col-md-8"><h3 class="modal-title">Employee Detail</h3></div>
		<div class="col-md-2"></div>
	</div>
	<div class="row">
   		<div class="form-group col-md-2">
    		<label  >Email</label>
       	</div>
       	<div class="form-group col-md-4">
     		<input type="text" class="form-control" value="${email}" id="vemail" readonly="readonly">
     	</div>
       	<div class="form-group col-md-2">
    		<label >FirstName</label>
       </div>
       <div class="form-group col-md-4">
     		<input type="text" class="form-control" id="vfname" value='${firstName}' readonly="readonly">
       </div>
 	</div>
    <div class="row">
       	<div class="form-group col-md-2">
      	 	<label >LastName</label>
       	</div>
     	<div class="form-group col-md-4">
      		<input type="text" class="form-control" id="vlname"  value='${lastName}' readonly="readonly">
      	</div>
       	<div class="form-group col-md-2">
     		<label  >Contact</label>
       	</div>
      	<div class="form-group col-md-4">
      		<input type="text" class="form-control" value="${contact}"  id="vcontact" readonly="readonly">
      	</div>
   </div>
	<div class="row">
   		<div class="form-group col-md-2">
    		<label  >User Type</label>
      	</div>
     	<div class="form-group col-md-4">
     		<input type="text" class="form-control" value='${userType}' id="vuser" readonly="readonly">
     	</div>
     	<div class="form-group col-md-2">
    		<label  >Country</label>
      	</div>
     	<div class="form-group col-md-4">
     		<input type="text" class="form-control" value="${country}" id="vcountry" readonly="readonly">
     	</div>
   	</div>
   	<div class="row">
       	<div class="form-group col-md-2">
        	<label  >State</label>
        </div>
        <div class="form-group col-md-4">
        	<input type="text" class="form-control" value='${state}' id="vstate" readonly="readonly">
        </div>
        <div class="form-group col-md-2">
        	<label  >City</label>
        </div>
        <div class="form-group col-md-4">
        	<input type="text" class="form-control"  value="${city}" id="vcity" readonly="readonly">
        </div>
     </div>
	<div class="row">
    	<div class="form-group col-md-2">
     		<label  >CreatedOn</label>
       	</div>
      	<div class="form-group col-md-4">
      		<input type="text" class="form-control" value='${createdon}' id="vcreatedon" readonly="readonly">
      	</div>
       	<div class="form-group col-md-2">
     		<label  >UpdatedOn</label>
       	</div>
      	<div class="form-group col-md-4">
      		<input type="text" class="form-control" value='${updatedon}' id="vupdatedon" readonly="readonly">
      	</div>
  	</div>
	<div class="row">
		<div class="col-md-2">Language:</div>
		<div class="col-md-7" id="vlang"><input type="text" class="form-control" value='${language}' id="vlanguage" readonly="readonly" style="display: none;"></div>
		<div class="col-md-1"></div>	        
   </div>
	<div class="row">
		<input type="text" style="display :none;" value='${exp}' name="exp"  id="expjob">
    	<table class="table table-bordered table-responsive">
    		<thead>
     		<tr>
     			<th>Sr.No</th>
             	<th>NO OF YEAR</th>
             	<th>Company name</th>
             	<th>Job Description</th>
         	</tr>
    		</thead>
        	<tbody id="vexp"></tbody>
    	</table>
	</div>
	<div class="row">
		<div class="col-md-10"></div>
		<div class="col-md-2">
			<a href="index.jsp" class="btn btn-default">Home Page</a>
		</div>
	</div>
</div>
<div class="col-md-1"></div>
</div>
</body>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/bootstrap/bootstrap.min.js"></script>
<script src="js/custom/jquery.validate.min.js"></script>
<script src="js/custom/view.js"></script>
</html>