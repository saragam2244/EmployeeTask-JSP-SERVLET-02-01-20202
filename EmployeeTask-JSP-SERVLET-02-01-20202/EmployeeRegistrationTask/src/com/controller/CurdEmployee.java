package com.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import com.modal.Employee;
import com.operation.UserOperation;


@WebServlet("/CurdEmployee")
public class CurdEmployee extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public CurdEmployee() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type=(String) request.getAttribute("type");
		try {
			switch (type) {
			case "updateForm":
				Employee employee=new UserOperation().updateFormData((String)request.getAttribute("id"));
				System.out.println("update form=>>>>>>"+employee);
				request=new UserOperation().employeeData(request, employee);
				request.setAttribute("data",new UserOperation().loadCountryLangUser());
				request.getRequestDispatcher("register.jsp").forward(request, response);
				break;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type=(String) request.getAttribute("type");
		try {
			switch (type) {
			case "insertData":
				Employee emp=new Employee();
				String value=(String)request.getAttribute("value");
				if(value.equalsIgnoreCase("insert")) {
				}else {
				}
				emp.setId(request.getParameter("id").trim());
				emp.setFirstName(request.getParameter("firstName").trim());
				emp.setLastName(request.getParameter("lastName").trim());
				emp.setEmail(request.getParameter("email").trim());
				emp.setConatct(request.getParameter("contact").trim());
				emp.setCountry(request.getParameter("country"));
				emp.setState(request.getParameter("state"));
				emp.setCity(request.getParameter("city").trim());
				emp.setUserType(request.getParameter("userType"));
				emp.setPassword(request.getParameter("password").trim());
				String lang=request.getParameter("language").trim();
				if(lang.length() !=0){
					JSONArray langArray=new JSONArray("["+lang+"]");
					emp.setLanguage(langArray);
				}else {
					emp.setLanguage(new JSONArray());
				}
				String expTest=request.getParameter("exp");
				if(expTest!="" || expTest.length()!=0) {
					JSONArray exp=new JSONArray(expTest);
					emp.setExp(exp);
				}else {
					emp.setExp(new JSONArray());
				}
				System.out.println("validation=====>>>>>>>>>>>"+emp);
				UserOperation user=new UserOperation();
				String status=user.validateEmployee(emp, "insert");
				if(status.equalsIgnoreCase("valid")) {
					if(emp.getId().isEmpty() ) {
						if(user.validEmail(emp.getEmail(),"insert",emp.getId())) {
							user.insertEmployee(emp);
							response.sendRedirect("index.jsp");
						}else {
							request.setAttribute("data",new UserOperation().loadCountryLangUser());
							request=new UserOperation().employeeData(request, emp);
							request.setAttribute("message","[{\"1\":\"email1\",\"2\":\"Duplicate Email id\"}]");
							request.getRequestDispatcher("register.jsp").include(request, response);
						}
					}else {
						if(user.validEmail(emp.getEmail(),"update",emp.getId())) {
							user.updateEmployee(emp);
							response.sendRedirect("index.jsp");
						}else {
							request.setAttribute("data",new UserOperation().loadCountryLangUser());
							request=new UserOperation().employeeData(request, emp);
							request.setAttribute("message","[{\"1\":\"email1\",\"2\":\"Duplicate Email id\"}]");
							request.getRequestDispatcher("register.jsp").include(request, response);
						}
					}
				}
				else {
					request.setAttribute("data",new UserOperation().loadCountryLangUser());
					request=new UserOperation().employeeData(request, emp);
					request.setAttribute("message",status);
					request.getRequestDispatcher("register.jsp").include(request, response);
				}
				break;
			default:
				break;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
