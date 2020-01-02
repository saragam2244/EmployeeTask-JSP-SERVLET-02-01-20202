package com.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.operation.UserOperation;

@WebServlet("/HomeController")
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public HomeController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type=request.getParameter("type");
		switch (type) {
		case "search":
			response.sendRedirect("search.jsp");
			break;
		case "report":
			request.setAttribute("report",new UserOperation().reportData());
			request.getRequestDispatcher("report.jsp").include(request, response);
			break;
		case "register":
			request.setAttribute("data",new UserOperation().loadCountryLangUser());
			request.getRequestDispatcher("register.jsp").include(request, response);
			break;
		case "view":
			request=new UserOperation().employeeData(request, new UserOperation().viewEmployee(request.getParameter("value")));
			request.getRequestDispatcher("view.jsp").include(request, response);
			break;
		case "update":
			request.setAttribute("type", "updateForm");
			request.setAttribute("value", "update");
			request.setAttribute("id",request.getParameter("value"));
			request.getRequestDispatcher("/CurdEmployee").forward(request, response);
			break;
		case "delete":
			String deleteId=request.getParameter("value");
			String status=request.getParameter("status");
			if(new UserOperation().deleteEmployee(deleteId,status)==true) {
				response.sendRedirect("search.jsp");
			}
			break;
		default:
			break;
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type=request.getParameter("type");
		switch (type) {
		case "loadState":
			response.getWriter().write(new UserOperation().loadState(request.getParameter("id")).toString());
			break;
		case "submit":
			request.setAttribute("type","insertData");
			request.setAttribute("value", "insert");
			request.getRequestDispatcher("/CurdEmployee").forward(request, response);
			break;
		case "loadData":
			final String firstRow=null !=  request.getParameter("start") ? request.getParameter("start") : "0";
			final String lastRow=null !=  request.getParameter("length") ? request.getParameter("length") : "5";
			final String search= null != request.getParameter("search[value]")? request.getParameter("search[value]"):"";
//			final String columNumber=request.getParameter("order[0][column]");
			final String order=request.getParameter("order[0][dir]");

			JSONObject jsonEmployeeObj=new UserOperation().loadData(search,order,firstRow,lastRow);
			JSONObject jsonObj=new JSONObject();
			jsonObj.put("data",jsonEmployeeObj.get("data"));
			jsonObj.put("recordsTotal", jsonEmployeeObj.get("total"));
			jsonObj.put("recordsFiltered",jsonEmployeeObj.get("total"));
			
			response.getWriter().write(jsonObj.toString());
			break;
		default:
			break;
		}
	}

}
