$(document).ready(function (){
	loadData();
});
function loadData(){
	$('#table').DataTable( {
	    scrollCollapse: true,
	    "processing": true, 
		serverSide: true,
		destroy:true,
		lengthMenu: [5,10,15,20],
		displayLength:10,
		order:[[1,"asc"]],
//		stateSave:false,
		searching: true,
//		 "search": {
//			    "regex": true
//			  },
	ajax:{
		  url: "/EmployeeRegistrationTask/HomeController",
		  method:"POST",
		  data:{type:"loadData"},
		  dataSrc: function (data){
			  return data.data;
		  }
		},
		 columns: [
		        { 'data': 'fname'},
		        { 'data': 'lname'},
		        { 'data': 'email'},
		        { 'data': 'contact'},
		        { 'data': 'createdon'},
		        { 'data': 'updatedon'},
		        { 'data': 'userid', 
		        	'render' :function (data,type,row) {
		        		var activeRow=row.active;
		        		var active=activeRow==1?"<a class='btn btn-danger' href='/EmployeeRegistrationTask/HomeController?type=delete&value="+data+"&status=1'><i class='fa fa-trash'></i></a>":"<a class='btn' href='/EmployeeRegistrationTask/HomeController?type=delete&value="+data+"&status=0'>Active</a>";
	        	      return	"<a class='btn btn-success' href='/EmployeeRegistrationTask/HomeController?type=update&value="+data+"'><i class='fa fa-edit'></i></a> " +
      	      		"  			<a class='btn btn-info' href='/EmployeeRegistrationTask/HomeController?type=view&value="+data+"'><i class='fa fa-eye'></i></a>" + active ;
	          
		        	}
		        }
		]
	});
}