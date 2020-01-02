var expCount;
$(document).ready(function(){
	var country=$('#country').val();
	var expjob=$('#expjob').val();
	var message=$('#message').val();
	if(country!=null){
		setTimeout(function(){ loadState(); }, 10);
	}
	if(expjob!=""){
		var data=JSON.parse(expjob);
		for(i=0;i<data.length;i++){
			var year=data[i]["noOfYear"];
			var name=data[i]["company"];
			var des=data[i]["des"];
			expCount=expCount+1;
			$("#exp").append("<tr id='exp"+expCount+"'><td>"+year+"</td><td>"+name+"</td><td>"+des+"</td> <td><center>  <button class='btn btn-danger' id='expDelete' value='"+expCount+"'><i class='fa fa-trash'></i></button></center></td></tr>");
		}
	}
	
	if(message!=""){
		var messageData=JSON.parse(message);
		for(i=0;i<messageData.length;i++){
			$("#"+messageData[i]["1"]).text(messageData[i]["2"]);
		}
		$('#message').val();
	}
});
window.onbeforeunload = function ()
{
    return false;
}
$.validator.addMethod('regex', function(value, element, param) {
    var temp=new RegExp(param);
	return this.optional(element) ||  temp.test(value);
});
$(function() {
	 $("form[name='EmployeeForm']").validate({
		    rules: {
		      firstName:{	
		    	  required:true,
		    	  maxlength:50,
		    	  regex:name
		      },
		      lastName:{	
		    	  required:true,
		    	  maxlength:50,
		    	  regex:name
		      },
		      contact:{	
		    	  required:true,  
		    	  regex:number
		      },
		      email: {      
		    	  required: true,
		    	  regex: emailId	
		      },
		      country: {
		    	  required: {
		    		  depends: function(element) {
		    			  return $("#country").val() != "0";	
		    			  }
		    	  }
		      },
		      state: {  
		    	  required: {	
		    		  depends: function(element) {
		    			  return $("#state").val() != "0";
		    			  }
		    	  }
		      },
		      city:{
		    	  required:true,
		    	  maxlength:50,
		    	  regex:name
		      },
		      userType: {
		    	  required: {   
		    		  depends: function(element) {
		    			  return $("#userType").val() != "0";
		    			  }
		    	  }
		      },
		      password: {  
		    	  required: true,
		    	  minlength:8,
		    	  maxlength:16 
		      },
		      confirmPassword:{
		    	  equalTo: "#password"
		      },
		      "language[]":{ 
		    	  	required: true,
		    	  	minlength:1
		      }              
		    },
		    messages: {
		    	firstName:{
		    		required:"Enter The Name",
		    		maxlength:"Enter Maximum Length 50",
		    		regex:"Enter Valid Name"
		    	},
		    	lastName: {
		    		required:"Enter The Name",
		    		maxlength:"Enter Maximum Length 50",
		    		regex:"Enter Valid Name"
		      	},
		      	contact:{
		      		required:"Enter The Contact",
		      		regex:"Enter Valid Contact"
		      	},
		      	email:{
		      		required:"Enter The Email ID",
		      		regex: "Enter Valid Emial ID"
		      	},
		      	country: {
		      		required: "Select Country ",
		      	},
		      	state: {
		      		required: "Select State ",
		      	},
		      	city:{
		      		required:"Enter The City",
			    	maxlength:"Enter Maximum Length 50",
			    	regex:"Enter Valid Name"
		      	},
		      	userType: {
		      		required: "Select UserType ",
		      	},
		      	"language[]":{
		      		required: "Select Language "
		      	},
		      	password: {
		      		required: "Enter The Password",
		      		minlength:"Enter Minimum Length 8",
		      		maxlength:"Enter Maximum Length 16"
		      	},
		      	confirmPassword:{
		      		equalTo:"Confirm Password Not Match"
		      	}
		    },
		    errorPlacement: function(error, element) {
		    	var id=element.attr("id");
		    	$("#"+id+"1").text("");
		    	if(id==undefined){
		    		$('#Language1').text("Select Language");
		    	}
		    	error.appendTo("#"+id+"1");
		        
		     },
		    submitHandler: function(form) {
		    	$('#type').val("submit");
		    	var language=$("input[type='checkbox']:checked");
		    	var arrlanguage=new Array();
		    	for(i=0;i<language.length;i++){
		    		arrlanguage[i]=language[i].value;
		    	}
		    	$('#language12').val(arrlanguage)
		    	$('#expjob').val(JSON.stringify(getExp()));
		    	form.submit();
		    }
	  });
});
function loadState(){
	  var data=$("#country").val();
	  $("#state").html("");
	  $.ajax({
		  url: "/EmployeeRegistrationTask/HomeController",
		  method:"POST",
		  data:{type:"loadState",id:data},
		  success: function(result){
			  $("#state").append("<option value='0' disabled selected>select State</option>");
			  var data=JSON.parse(result);
			  for(i=0;i<data.length;i++){
				  $("#state").append("<option value='"+data[i].id+"'>"+data[i].name+"</option>");  
			  }
			  $("#state [value=0]").prop("selected",true);
			  var stateid=$("#stateid").val()	;
			  if(stateid!=""){
				  $("#state [value="+stateid+"]").prop("selected",true);
			  }
		  }
	  });
}
function addExp(){
	var year=$("#noOfYear").val();
	var name=$("#companyName").val();
	var des=$("#jobDes").val();
	$('#noOfYear1 , #companyName1 , #jobDes1').empty();
	if (year==""){
		$("#noOfYear1").text("Enter No Of Year");
	}else if(name == ""){
		$("#companyName1").text("Enter Company Name");
	}else if(des == ""){
		$('#jobDes1').text("Enter The Job Description");
	}else{
		expCount=expCount+1;
		$("#exp").append("<tr id='exp"+expCount+"'><td>"+year+"</td><td>"+name+"</td><td>"+des+"</td> <td><center>  <button class='btn btn-danger' id='expDelete' value='"+expCount+"'><i class='fa fa-trash'></i></button></center></td></tr>");
		$("#noOfYear,#companyName,#jobDes").val("");
	}
}
function getExp(){
	  var table = $('#exp');
	  var data = [];
		  table.find('tr').each(function (i, el) {
			    if( i != -1){ 
			      var $tds = $(this).find('td');
			      var row = {};
			      $tds.each(function (i, el){
			    	  row[i]=$(this).text();
			      });
			      data.push(row);
			    }
			  });  
	  return data;
}
$(document).on("click","#expDelete",function(){
	var count=$(this).val();
	$( "#exp"+count ).remove();
});