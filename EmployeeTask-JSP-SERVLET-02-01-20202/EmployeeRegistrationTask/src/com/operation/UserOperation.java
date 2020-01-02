package com.operation;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;

import com.connection.DBConnection;
import com.modal.Employee;

public class UserOperation {
	static Connection con=null;
	static Statement st=null;
	static ResultSet rs=null;
	public UserOperation(){
		try {
			con=new DBConnection().getConnection();
			con.setAutoCommit(false);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public String validateEmployee(Employee emp,String operation) {
		JSONArray message=new JSONArray();
		try {
			String nameRegex="^[a-zA-Z]*[^0-9#&<>\\\"~;$^%{}?]*$";
			String numberRegex="[\\d{10}]+";
			String emailRegex="^\\w+([\\.-]?\\w+)*@\\w+([\\.-]?\\w+)*(\\.\\w{2,3})+$";
			
			JSONObject firstName=new JSONObject();
			firstName.put("1", "firstName1");
			if( emp.getFirstName()== null || emp.getFirstName().isEmpty()) {message.put(firstName.put("2", "Enter First Name"));}
			else if(!Pattern.matches(nameRegex, emp.getFirstName()) ) {message.put(firstName.put("2", "Enter Valid Name"));}
			else if(emp.getFirstName().length() > 50 ) {message.put(firstName.put("2", "Enter Maximum Length 50"));}
			
			JSONObject lastName=new JSONObject();
			lastName.put("1","lastName1");
			if(emp.getLastName()== null || emp.getLastName().isEmpty()) {message.put(lastName.put("2", "Enter Last Name"));}
			else if(!Pattern.matches(nameRegex, emp.getLastName())) {message.put(lastName.put("2","Enter Valid Name"));}
			else if(emp.getLastName().length() > 50 ) {message.put(lastName.put("2","Enter Maximum Length 50"));}
			
			JSONObject email=new JSONObject();
			email.put("1","email1");
			if(emp.getEmail()== null || emp.getEmail().isEmpty()) {message.put(email.put("2","Enter Email ID"));}
			else if (!Pattern.matches(emailRegex, emp.getEmail())) {message.put(email.put("2","Enter Valid Emial ID"));}//[\\w]+[@][\\w]+
			else if(emp.getEmail().length() > 50 ) {message.put(email.put("2","Enter Maximum Length 50"));}
			
			JSONObject contact=new JSONObject();
			contact.put("1", "contact1");
			if(emp.getConatct()== null || emp.getConatct().isEmpty()) {message.put(contact.put("2","Enter Contact"));}
			else if (!Pattern.matches(numberRegex, emp.getConatct())) {message.put(contact.put("2","Enter Valid Contact"));}
			
			JSONObject country=new JSONObject();
			country.put("1","country1");
			if(emp.getCountry()==null) {
				message.put(country.put("2","Select Country"));
			}
			
			JSONObject state=new JSONObject();
			state.put("1","state1");
			if(emp.getState()==null) {
				message.put(state.put("2","Select State"));
			}
			
			JSONObject city=new JSONObject();
			city.put("1","city1");
			if(emp.getCity()== null || emp.getCity().isEmpty()) {message.put(city.put("2","Enter City"));}
			else if(!Pattern.matches(nameRegex, emp.getCity()) ) {message.put(city.put("2","Enter Valid Name"));}
			else if(emp.getCity().length() > 50 ) {message.put(city.put("2","Enter Maximum Length 50"));}
			
			JSONObject userType=new JSONObject();
			userType.put("1","userType1");
			if(emp.getUserType()==null) {
				message.put(userType.put("2","Select UserType"));
			}
			
			JSONObject lang=new JSONObject();
			lang.put("1", "Language1");
			if(emp.getLanguage().length()== 0) {message.put(lang.put("2","Select Language"));}
			
			JSONObject pass=new JSONObject();
			pass.put("1","password1");
			if(emp.getPassword()== null || emp.getPassword().isEmpty()) {message.put(pass.put("2","Enter Password"));}
			else if(emp.getPassword().length() < 8 ) {message.put(pass.put("2","Enter Maximum Length 8"));}
			else if(emp.getPassword().length() > 16 ) {message.put(pass.put("2","Enter Maximum Length 16"));}
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(message.length()>0) {
			return message.toString();
		}
		return "valid";
	}
	public boolean validEmail(String email,String type,String id) {
		try {
			st=con.createStatement();
			rs=st.executeQuery("select count(userid) from user_register where emailid='"+email+"'");
			int count=0;
			if(rs.next()) {
				count=rs.getInt(1);
			}
			if(count==0) {
				return true;
			}
			rs.close();
			if(type=="update") {
				String oldEmail="";
				st=con.createStatement();
				rs=st.executeQuery("select emailid from user_register where userid="+id);
				if(rs.next()) {
					oldEmail=rs.getString(1);
				}
				if(oldEmail.equalsIgnoreCase(email)) {
					return true;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	public synchronized String insertEmployee(Employee emp) {
		try {
			CallableStatement call=con.prepareCall("{call insertEmployee(?,?,?,?,?,?,?,?,?,?,?,?)}");
			call.setString(1, emp.getEmail());
			call.setString(2, emp.getPassword());
			call.setString(3, LocalDateTime.now().toString());
			call.setString(4, LocalDateTime.now().toString());
			call.setString(5, emp.getFirstName());
			call.setString(6, emp.getLastName());
			call.setString(7, emp.getConatct());
			call.setString(8, emp.getCountry());
			call.setString(9, emp.getState());
			call.setString(10, emp.getCity());
			call.setString(11, emp.getUserType());
			call.registerOutParameter(12, java.sql.Types.VARCHAR);
			call.execute();
			String id=call.getString(12);
			
			JSONArray lang=emp.getLanguage();
			PreparedStatement pslang = con.prepareStatement("insert into user_language (userid,languageid,createdon) values(?,?,?)");
			for(int i=0;i<lang.length();i++) {
				pslang.setInt(1,Integer.parseInt(id));
				pslang.setInt(2,lang.getInt(i));
				pslang.setString(3, LocalDateTime.now().toString());
				pslang.addBatch();
			}	
			pslang.executeBatch();
			PreparedStatement psexp=con.prepareStatement("insert into user_experiences (userid,noofyears,company_name,jobdescription,createdon) values(?,?,?,?,?)");
			int len=emp.getExp().length();
			if(len>0) {
				for(int i=0;i<emp.getExp().length();i++) {
					JSONObject jsonObj=emp.getExp().getJSONObject(i);
					psexp.setInt(1,Integer.parseInt(id));
					psexp.setInt(2,jsonObj.getInt("0"));
					psexp.setString(3, jsonObj.getString("1"));
					psexp.setString(4,jsonObj.getString("2"));
					psexp.setString(5, LocalDateTime.now().toString());
					psexp.addBatch();
				}
			}
			psexp.executeBatch();
			con.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "save";
	}
	public synchronized String updateEmployee(Employee emp) {
		try {
			CallableStatement call=con.prepareCall("{call updateEmployee(?,?,?,?,?,?,?,?,?,?,?)}");
			call.setString(1, emp.getId());
			call.setString(2, emp.getEmail());
			call.setString(3, emp.getPassword());
			call.setString(4, LocalDateTime.now().toString());
			call.setString(5, emp.getFirstName());
			call.setString(6, emp.getLastName());
			call.setString(7, emp.getConatct());
			call.setString(8, emp.getCountry());
			call.setString(9, emp.getState());
			call.setString(10, emp.getCity());
			call.setString(11, emp.getUserType());
			call.execute();
			
			PreparedStatement ps2Delete=con.prepareStatement("delete from user_language where userid=?");
			ps2Delete.setInt(1,Integer.parseInt(emp.getId()));
			ps2Delete.execute();
			
			JSONArray lang=emp.getLanguage();
			PreparedStatement pslang = con.prepareStatement("insert into user_language (userid,languageid,createdon) values(?,?,?)");
			for(int i=0;i<lang.length();i++) {
				pslang.setInt(1,Integer.parseInt(emp.getId()));
				pslang.setInt(2,lang.getInt(i));
				pslang.setString(3, LocalDateTime.now().toString());
				pslang.addBatch();
			}	
			
			PreparedStatement ps3Delete=con.prepareStatement("delete from user_experiences where userid=?");
			ps3Delete.setInt(1,Integer.parseInt(emp.getId()));
			ps3Delete.execute();
			
			pslang.executeBatch();
			PreparedStatement psexp=con.prepareStatement("insert into user_experiences (userid,noofyears,company_name,jobdescription,createdon) values(?,?,?,?,?)");
			int len=emp.getExp().length();
			if(len>0) {
				for(int i=0;i<emp.getExp().length();i++) {
					JSONObject jsonObj=emp.getExp().getJSONObject(i);
					psexp.setInt(1,Integer.parseInt(emp.getId()));
					psexp.setInt(2,jsonObj.getInt("0"));
					psexp.setString(3, jsonObj.getString("1"));
					psexp.setString(4,jsonObj.getString("2"));
					psexp.setString(5, LocalDateTime.now().toString());
					psexp.addBatch();
				}
			}
			psexp.executeBatch();
			con.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "save";
	}
	public synchronized boolean deleteEmployee(String id, String status) {
		try {
			st=con.createStatement();
			if(status.equalsIgnoreCase("0")) {
				st.executeUpdate("update user_register set active=1 where userid="+id);
			}else {
				st.executeUpdate("update user_register set 	active=0 where userid="+id);
			}
			con.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	public Employee updateFormData(String id) {
		Employee emp=new Employee();
		try {	
			st=con.createStatement();
			rs=st.executeQuery("select * from user_register as r ,user_details as d   where r.userid=d.userid and r.userid="+id);
			while (rs.next()) {
				emp.setId(rs.getString(1));
				emp.setEmail(rs.getString(2));
				emp.setPassword(rs.getString(3));
				emp.setFirstName(rs.getString(9));
				emp.setLastName(rs.getString(10));
				emp.setConatct(rs.getString(11));
				emp.setCountry(rs.getString(12));
				emp.setState(rs.getString(13));
				emp.setCity(rs.getString(14));
				emp.setUserType(rs.getString(15));
			}
			rs.close();
			
			st=con.createStatement();
			rs=st.executeQuery("select * from user_language where userid="+id);
			JSONArray lang=new JSONArray();
			while (rs.next()) {
				lang.put(rs.getString(3));
			}
			rs.close();
			emp.setLanguage(lang);
			
			rs=st.executeQuery("select * from user_experiences where userid="+id);
			JSONArray empExp=new JSONArray();
			while (rs.next()) {
				JSONObject obj=new JSONObject();	
				obj.put("noOfYear",rs.getString(3));
				obj.put("company",rs.getString(4));
				obj.put("des",rs.getString(5));
				empExp.put(obj);
			}
			rs.close();
			st.close();
			emp.setExp(empExp);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return emp;
	}
	public JSONObject loadData(String search,String order,String first,String last) {
		JSONObject objEmployee=new JSONObject();
		JSONArray student=new JSONArray();
		int counter=0;
		try {
			st=con.createStatement();
			rs=st.executeQuery("select r.userid,d.firstname,d.lastname,r.emailid,d.mobileno,DATE_FORMAT(r.createdon, '%d/%m/%Y %h:%i:%s'),DATE_FORMAT(r.updatedon, '%d/%m/%Y %h:%i:%s'),r.active from user_register as r left join user_details as d on r.userid=d.userid where (r.emailid like '%"+search+"%' or r.createdon like '%"+search+"%') and r.createdon between '2000-01-01' and '2020-12-31' order by r.updatedon desc limit "+first+","+last);
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("userid", rs.getString(1));
				obj.put("fname",rs.getString(2));
				obj.put("lname", rs.getString(3));
				obj.put("email",rs.getString(4));
				obj.put("contact", rs.getString(5));
				obj.put("createdon",rs.getString(6));
				obj.put("updatedon", rs.getString(7));
				obj.put("active",rs.getString(8));
				student.put(obj);
			}
			rs.close();
			rs=st.executeQuery("select r.userid,d.firstname,d.lastname,r.emailid,d.mobileno,DATE_FORMAT(r.createdon, '%d/%m/%Y %h:%i:%s'),DATE_FORMAT(r.updatedon, '%d/%m/%Y %h:%i:%s'),r.active from user_register as r left join user_details as d on r.userid=d.userid where (r.emailid like '%"+search+"%' or r.createdon like '%"+search+"%') and r.createdon between '2000-01-01' and '2020-12-31' order by r.updatedon desc ");
			while(rs.next()) {
				counter++;
			}
			st.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		objEmployee.put("data",student);
		objEmployee.put("total",""+counter+"");
		return objEmployee;
	}
	public synchronized HashMap<String, HashMap<String , String >> loadCountryLangUser() {
		HashMap<String, HashMap<String , String>> map=new HashMap<>();
		try {
			st=con.createStatement();
			rs=st.executeQuery("select * from master_country");
			HashMap<String , String> country=new HashMap<String, String>();
			while (rs.next()) {
				country.put(rs.getString(1),rs.getString(2));
			}
			rs.close();
			map.put("country",country);
			
			HashMap<String , String> language=new HashMap<String, String>();
			st=con.createStatement();
			rs=st.executeQuery("select * from master_language");
			while (rs.next()) {
				language.put(rs.getString(1),rs.getString(2));
			}
			rs.close();
			map.put("language",language);
			
			HashMap<String , String> userType=new HashMap<String, String>();
			st=con.createStatement();
			rs=st.executeQuery("select * from master_usertype");
			while (rs.next()) {
				userType.put(rs.getString(1),rs.getString(2));
			}
			map.put("userType",userType);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	public synchronized JSONArray loadState(String id) {
		JSONArray jsonArr=new JSONArray();
		try {
			st=con.createStatement();
			rs=st.executeQuery("select stateid,statename from master_state where countryid="+id);
			while (rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("id",rs.getString(1));
				obj.put("name",rs.getString(2));
				jsonArr.put(obj);
			}
			rs.close();
			st.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsonArr;
	}
	public HttpServletRequest employeeData(HttpServletRequest request ,Employee employee) {
		System.out.println("setDataInRequest"+employee);
		request.setAttribute("id",employee.getId());
		request.setAttribute("firstName",employee.getFirstName());
		request.setAttribute("lastName",employee.getLastName());
		request.setAttribute("email",employee.getEmail());
		request.setAttribute("city",employee.getCity());
		request.setAttribute("contact",employee.getConatct());
		request.setAttribute("country",employee.getCountry());
		request.setAttribute("state",employee.getState());
		request.setAttribute("userType",employee.getUserType());
		request.setAttribute("password",employee.getPassword());
		request.setAttribute("language",employee.getLanguage().toString());
		request.setAttribute("exp",employee.getExp());
		request.setAttribute("createdon",employee.getCreatedon());
		request.setAttribute("updatedon",employee.getUpdatedon());
		return request;
	} 
	public HashMap<String , String> reportData(){
		HashMap<String , String> report=new HashMap<String, String>();
		try {
			st=con.createStatement();
			rs=st.executeQuery("SELECT SUM(usertypeid=1) AS Manager,SUM(usertypeid=2) AS DyManager,SUM(usertypeid=3) AS Executive FROM `employee_registration`.`user_details`");
			while (rs.next()) {
				report.put("manager",rs.getString(1));
				report.put("dyManager",rs.getString(2));
				report.put("executive",rs.getString(3));
			}
			rs.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return report;
	}
	public Employee viewEmployee(String id) {
		Employee emp=new Employee();
		try {
			st=con.createStatement();
			rs=st.executeQuery("SELECT  r.emailid,d.firstname,d.lastname,d.mobileno,mu.usertype,mc.countryname,ms.statename,d.city,\n" + 
					"r.createdon,r.updatedon,GROUP_CONCAT(DISTINCT ml.language),\n" + 
					"GROUP_CONCAT(distinct  concat('{noOfYear:',e.noofyears,',company:',e.company_name,',des:',e.jobdescription,'}') separator',')\n" + 
					"FROM employee_registration.user_register as r \n" + 
					"left join employee_registration.user_details as d on r.userid=d.userid\n" + 
					"left join employee_registration.user_experiences as e on r.userid=e.userid\n" + 
					"left join employee_registration.user_language as l on r.userid=l.userid\n" + 
					"left join employee_registration.master_language as ml on l.languageid=ml.languageid\n" + 
					"left join employee_registration.master_country as mc on d.countryid=mc.countryid\n" + 
					"left join employee_registration.master_state as ms on d.stateid=ms.stateid\n" + 
					"left join employee_registration.master_usertype as mu on d.usertypeid=mu.usertypeid\n" + 
					"where r.userid=" +id+ 
					" group by r.emailid,d.firstname,d.lastname,d.mobileno,mu.usertype,mc.countryname,ms.statename,d.city;");
			while(rs.next()) {
				emp.setEmail(rs.getString(1));
				emp.setFirstName(rs.getString(2));
				emp.setLastName(rs.getString(3));
				emp.setConatct(rs.getString(4));
				emp.setUserType(rs.getString(5));
				emp.setCountry(rs.getString(6));
				emp.setState(rs.getString(7));
				emp.setCity(rs.getString(8));
				emp.setCreatedon(rs.getString(9));
				emp.setUpdatedon(rs.getString(10));
				JSONArray lang=new JSONArray("["+rs.getString(11)+"]");
				emp.setLanguage(lang);
				System.out.println(rs.getString(12));
				JSONArray exp=new JSONArray("["+rs.getString(12)+"]");
				emp.setExp(exp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return emp;
	}
}
