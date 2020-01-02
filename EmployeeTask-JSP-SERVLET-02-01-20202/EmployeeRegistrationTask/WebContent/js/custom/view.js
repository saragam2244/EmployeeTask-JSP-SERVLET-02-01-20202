var expCount=0;
$(document).ready(function(){
	var expjob=$('#expjob').val();
	var lang=$('#vlanguage').val();
	if(lang!=""){
		var data=JSON.parse(lang);
		for(i=0;i<data.length;i++){
			$("#vlang").append(data[i]+"&nbsp;&nbsp;&nbsp;");
		}
	}
	if(expjob!=""){
		var data=JSON.parse(expjob);
		for(i=0;i<data.length;i++){
			var year=data[i]["noOfYear"];
			var name=data[i]["company"];
			var des=data[i]["des"];
			expCount=expCount+1;
			$("#vexp").append("<tr id='exp"+expCount+"'><td>"+expCount+"</td><td>"+year+"</td><td>"+name+"</td><td>"+des+"</td></tr>");
		}
	}
});