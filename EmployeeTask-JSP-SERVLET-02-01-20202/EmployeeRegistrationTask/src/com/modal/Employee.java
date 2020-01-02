package com.modal;

import org.json.JSONArray;

public class Employee {
	private String id;
	private String email;
	private String password;
	private String createdon;
	private String updatedon;
	private String firstName;
	private String lastName;
	private String conatct;
	private String country;
	private String state;
	private String city;
	private String userType;
	private JSONArray language;
	private JSONArray exp;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getCreatedon() {
		return createdon;
	}
	public void setCreatedon(String createdon) {
		this.createdon = createdon;
	}
	public String getUpdatedon() {
		return updatedon;
	}
	public void setUpdatedon(String updatedon) {
		this.updatedon = updatedon;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getConatct() {
		return conatct;
	}
	public void setConatct(String conatct) {
		this.conatct = conatct;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public JSONArray getLanguage() {
		return language;
	}
	public void setLanguage(JSONArray language) {
		this.language = language;
	}
	public JSONArray getExp() {
		return exp;
	}
	public void setExp(JSONArray exp) {
		this.exp = exp;
	}
	@Override
	public String toString() {
		return "Employee [id=" + id + ", email=" + email + ", password=" + password + ", createdon=" + createdon
				+ ", updatedon=" + updatedon + ", firstName=" + firstName + ", lastName=" + lastName + ", conatct="
				+ conatct + ", country=" + country + ", state=" + state + ", city=" + city + ", userType=" + userType
				+ ", language=" + language + ", exp=" + exp + "]";
	}
	
	
}
