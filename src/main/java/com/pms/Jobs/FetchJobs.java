package com.pms.Jobs;


import com.pms.Coordinator.UploadJob;
import com.pms.FetchSchool;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.InputStream;

import java.sql.*;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@WebServlet(name = "fetchJobs", value = "/fetchJobs")
public class FetchJobs extends HttpServlet {

    private static Properties getConnectionData() {
        Properties props = new Properties();

        String fileName = "db.properties";

        // Use the ClassLoader to load the file from the resources directory
        try (InputStream in = FetchSchool.class.getClassLoader().getResourceAsStream(fileName)){
            props.load(in);
        } catch (IOException ex) {
            Logger lgr = Logger.getLogger(UploadJob.class.getName());
            lgr.log(Level.SEVERE, ex.getMessage(), ex);
        }
        return props;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("userEmail") != null) {
            try {
                String email = (String) session.getAttribute("userEmail");
                int departmentId = getDepartmentId(email);
                String departmentName = getDepartmentName(departmentId);
                JsonArray jobs = getJobsByDepartment(departmentName);

                JsonObject responseObject = new JsonObject();
                responseObject.add("jobs", jobs);
                String finalResponse = responseObject.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(finalResponse);
            } catch (Exception ex) {
                ex.printStackTrace();  // Log the exception for debugging
                response.getWriter().write("error "+ex.getMessage());
            }
        } else {
            response.getWriter().write("session is null.");
        }
    }

    private JsonArray getJobsByDepartment(String departmentName){
        JsonArray jobsArray = new JsonArray();

        Properties props = getConnectionData();
        String url = props.getProperty("db.url");
        String user = props.getProperty("db.user");
        String passwd = props.getProperty("db.passwd");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try (Connection con = DriverManager.getConnection(url, user, passwd)) {
            String query = "SELECT * FROM Jobs WHERE FIND_IN_SET(?, Departments)";
            try (PreparedStatement preparedStatement = con.prepareStatement(query)) {
                preparedStatement.setString(1, departmentName);

                // Execute the query
                ResultSet resultSet = preparedStatement.executeQuery();

                // Iterate through the result set and add jobs to the JSON array
                while (resultSet.next()) {
                    JsonObject jobObject = new JsonObject();
                    jobObject.addProperty("JobID", resultSet.getInt("JobID"));
                    jobObject.addProperty("OrgName", resultSet.getString("OrgName"));
                    jobObject.addProperty("OrgDesc", resultSet.getString("OrgDesc"));
                    jobObject.addProperty("JobName", resultSet.getString("JobName"));
                    jobObject.addProperty("JobDesc", resultSet.getString("JobDesc"));
                    jobObject.addProperty("Qualification", resultSet.getString("Qualification"));
                    jobObject.addProperty("JobLocation", resultSet.getString("JobLocation"));
                    jobObject.addProperty("NumberOfOpenings", resultSet.getInt("NumberOfOpenings"));
                    jobObject.addProperty("SkillsRequired", resultSet.getString("SkillsRequired"));
                    jobObject.addProperty("LastDateToApply", resultSet.getDate("LastDateToApply").toString());
                    jobObject.addProperty("GraduationYear", resultSet.getInt("GraduationYear"));
                    jobObject.addProperty("Departments", resultSet.getString("Departments"));

                    jobsArray.add(jobObject);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();  // Log the exception for debugging
        }

        return jobsArray;
    }

    private String getDepartmentName(int deptId){
        String name = "";

        Properties props = getConnectionData();
        String url = props.getProperty("db.url");
        String user = props.getProperty("db.user");
        String passwd = props.getProperty("db.passwd");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try (Connection con = DriverManager.getConnection(url, user, passwd)) {
            String query = "SELECT DepartmentName FROM Department WHERE DepartmentID= ?";
            try (PreparedStatement preparedStatement = con.prepareStatement(query)) {
                preparedStatement.setInt(1, deptId); // Set schoolName as parameter
                ResultSet rs = preparedStatement.executeQuery();
                if (rs.next()) {
                    name = rs.getString("DepartmentName");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();  // Log the exception for debugging
        }

        return name;
    }

    private int getDepartmentId(String email) {
        int deptID = -1;

        Properties props = getConnectionData();
        String url = props.getProperty("db.url");
        String user = props.getProperty("db.user");
        String passwd = props.getProperty("db.passwd");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try (Connection con = DriverManager.getConnection(url, user, passwd)) {
            String query = "SELECT DepartmentID FROM Student WHERE  Email= ?";
            try (PreparedStatement preparedStatement = con.prepareStatement(query)) {
                preparedStatement.setString(1, email); // Set schoolName as parameter
                ResultSet rs = preparedStatement.executeQuery();
                if (rs.next()) {
                    deptID = rs.getInt("DepartmentID");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();  // Log the exception for debugging
        }

        return deptID;
    }
}
