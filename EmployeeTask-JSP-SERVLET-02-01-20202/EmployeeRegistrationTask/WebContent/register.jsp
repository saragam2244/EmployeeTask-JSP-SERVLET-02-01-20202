<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
<head>
	<title>Employee Registration</title>
	
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <link rel="stylesheet" type="text/css" href="css/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap/bootstrap-theme.min.css">
    <link rel="stylesheet" type="text/css" href="css/custome/insertform.css">
    
    <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

</head>
<body>
<div class="row" style="margin-top :20px;">
	<div class="col-md-1"></div>
	<div class="col-md-10">
		<div class="row" style="margin-bottom :20px;" >
			<div class="col-md-2"></div>
			<div class="col-md-8"><h3 class="modal-title">Employee Registration</h3></div>
			<div class="col-md-2"></div>
		</div>
		<form name="EmployeeForm" method="post" action="HomeController" >
			<div class="row">
		    	<div class="form-group col-md-3" style="display:none;">
		        	<input type="text" class="form-control" id="id" value="${id}" placeholder="Enter First Name" name="id">
		        	<input type="text" value='${message}' name="massage" id="message">
		        </div>
				<div class="form-group col-md-3">
			        <div class="form-inline">
			        	<label for="firstName">FIRST NAME:</label>
			        </div>
			        <input type="text" class="form-control" id="firstName" value="${firstName}" placeholder="Enter First Name" name="firstName">
		        	<div class="form-inline">
			        	<label id="firstName1" class="custemLabale"></label>
			        </div>
		        </div>
		        <div class="form-group col-md-3">
			        <div class="form-inline">
		    	   		<label for="lastName">LAST NAME:</label>
		            </div>
		            <input type="text" class="form-control" id="lastName" placeholder="Enter Last Name" value="${lastName}" name="lastName">
		        	<div class="form-inline">
		    	   		<label id="lastName1" class="custemLabale"></label>
		            </div>
		        </div>
		        <div class="form-group col-md-3">
		        	<div class="form-inline">
		            	<label for="email">EMAIL:</label>
		            </div>
		            <input type="text" class="form-control" id="email" placeholder="Enter email" name="email"  value="${email}" >
		        	<div class="form-inline">
		            	<label id="email1" class="custemLabale"></label>
		            </div>
		        </div>
		        <div class="form-group col-md-3">
		        	<div class="form-inline">
		        		<label for="contact">MOBILE NUMBER:</label>
		            </div>
		            <input type="text" class="form-control" id="contact" placeholder="Enter Mobile Number" name="contact" value="${contact}" >
		        	<div class="form-inline">
		        		<label id="contact1" class="custemLabale"></label>
		            </div>
		        </div>
			</div>
		    <div class="row">
				<div class="form-group col-md-3">
		        	<div class="form-inline">
		            	<label for="country">COUNTRY:</label>
		            </div>
		            <select class="form-control" name="country" id="country" onchange="loadState();">
			            <option value='0'  disabled selected>Select Country</option>
			            <c:forEach var="country1" items='${data.country}' >
							<option value='${country1.key}'	${country1.key == country ? "selected" : "" } >${country1.value}</option>
			            </c:forEach>
		            </select>
		            <div class="form-inline">
		            	<label id="country1" class="custemLabale"></label>
		            </div>
		        </div>
		        <div class="form-group col-md-3">
		            <div class="form-inline">
		 		       	<label for="state">STATE:</label>
		           	</div>
		           	<div style="display:none;"> <input id="stateid" value='${state}'/> </div>
		            <select class="form-control" id="state" name="state">
		            	<option value='0' disabled selected>Select State</option>
		            </select>
		            <div class="form-inline">
		 		    	<label id="state1" class="custemLabale"></label>
		           	</div>
		        </div>
		        <div class="form-group col-md-3">
		        	<div class="form-inline">
		            	<label for="city">City:</label>
		            </div>
		            <input type="text" class="form-control" id="city" placeholder="Enter City" name="city" value="${city}">
		       		<div class="form-inline">
		            	<label id="city1" class="custemLabale"></label>
		            </div>
		       </div>
		       <div class="form-group col-md-3">
		       		<div class="form-inline">
		            	<label for="userform">USER:</label>
		            </div>
		            <select class="form-control" id="userType" name="userType">
			            <option value='0'  disabled selected>Select User Type</option>
			            <c:forEach var="userType1" items='${data.userType}' >
							<option value='${userType1.key}'	${userType1.key==userType ? "selected" : "" } >${userType1.value}</option> 
			            </c:forEach>
		            </select>
		            <div class="form-inline">
		            	<label id="userType1" class="custemLabale"></label>
		            </div>
		       </div>
		 	</div>
			<div class="row">
		    	<div class="form-group col-md-12">
		        	<div class="form-inline">
		     			<label for="Language">Language:</label>
		     			<input type="text" style="display :none;" value="" name="language" id="language12">
		    		</div>
		        	<div class="form-inline" id="Language" >
		        		<c:forEach var="language1" items='${data.language}' >
							<div class='checkbox'><label><input type='checkbox'  name='language[]' value='${language1.key}' ${fn:contains(language,language1.key) ? "checked" : "" } ><c:out value='${language1.value}'/></label></div>
			            </c:forEach>
		        	</div>
		        	<div class="form-inline">
		     			<label id="Language1" class="custemLabale"></label>
		    		</div>
		    	</div>
		    </div>
			<div class="row">
				<input type="text" style="display :none;" value='${exp}' name="exp"  id="expjob">
		        <table class="table table-bordered table-responsive">
		    	   	<thead>
		         	<tr>
		                 <th>NO OF YEAR</th>
		                 <th>Company name</th>
		                 <th>Job Description</th>
		                 <th>Action</th>
		             </tr>
		        	</thead>
		            <tbody id="exp"></tbody>
		        </table>
		    </div>
			<div class="row">
		    	<div class="form-group col-md-3">
		        	<div class="form-inline">
		     			<label for="no of year">NO OF YEAR:</label>
		    		</div>
		        	<input type="number" class="form-control" id="noOfYear" placeholder="enter the No Of Year" maxlength="3" name="noOfYear">
		    		<div class="form-inline">
		     			<label id="noOfYear1" class="custemLabale"></label>
		    		</div>
		    	</div>
		    	<div class="form-group col-md-3">
		        	<div class="form-inline">
		     			<label for="CompanyName">Company name:</label>
		    		</div>
		        	<input type="text" class="form-control" id="companyName" placeholder="Enter Company Name" maxlength="45" name="companyName">
		    		<div class="form-inline">
		     			<label id="companyName1" class="custemLabale"></label>
		    		</div>
		    	</div>
		    	<div class="form-group col-md-3">
		        	<div class="form-inline">
		     			<label for="jobDes">Job Description:</label>
		    		</div>
		        	<input type="text" class="form-control" id="jobDes" placeholder="Enter Job Description" maxlength="45" name="jobDes">
		    		<div class="form-inline">
		     			<label id="jobDes1" class="custemLabale"></label>
		    		</div>
		    	</div>
		   		<div class="form-group col-md-3">
		    		<label></label>
		        	<button type="button" class="btn form-control btn-info btn-group-lg" onclick="addExp();">Add Experience</button>
				</div>
			</div>
			<div class="row">
			    <div class="form-group col-md-6">
		    	   <div class="form-inline">
		    			<label for="password">Password:</label>
		    		</div>
		        	<input type="password" class="form-control" id="password" placeholder="Enter Password" name="password" value="${password}">
		    		<div class="form-inline">
		    			<label id="password1" class="custemLabale"></label>
		    		</div>
		    	</div>
			    <div class="form-group col-md-6">
		    	    <div class="form-inline">
		    			<label for="confirmPassword">confirm Password:</label>
		    		</div>
		        	<input type="password" class="form-control" id="confirmPassword" placeholder="Enter Confirm Password" value="${password}" name="confirmPassword">
		     		<div class="form-inline">
		    			<label id="confirmPassword1" class="custemLabale"></label>
		    		</div>
		     	</div>
			</div>
			<div class="row">
				<div class="col-md-10"></div>
				<div class="col-md-2">
					<a class="btn btn-default" href="index.jsp">Close</a>
		    		<input  type="submit" class="btn btn-success" value="submit" value="Save" name="type" id="type">		
				</div>
			</div>
		</form>
	</div>
	<div class="col-md-1"></div>
</div>
</body>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/bootstrap/bootstrap.min.js"></script>
<script src="js/custom/regex.js"></script>
<script src="js/custom/jquery.validate.min.js"></script>
<script src="js/custom/register.js"></script>
</html>