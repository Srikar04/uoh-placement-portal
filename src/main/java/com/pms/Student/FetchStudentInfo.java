package com.pms.Student;

import java.io.*;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.pms.Coordinator.UploadJob;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import com.google.gson.Gson;

@WebServlet(name = "fetchStudentInfo", value = "/fetchStudentInfo")
public class FetchStudentInfo extends HttpServlet {
    private static Properties getConnectionData() {
        Properties props = new Properties();

        String fileName = "db.properties";

        // Use the ClassLoader to load the file from the resources directory
        try (InputStream in = FetchStudentInfo.class.getClassLoader().getResourceAsStream(fileName)){
            props.load(in);
        } catch (IOException ex) {
            Logger lgr = Logger.getLogger(UploadJob.class.getName());
            lgr.log(Level.SEVERE, ex.getMessage(), ex);
        }
        return props;
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("userEmail");

        JsonArray studentInfo= new JsonArray();

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
            String query = "SELECT * FROM Student WHERE email = ?";
            try (PreparedStatement preparedStatement = con.prepareStatement(query)) {
                preparedStatement.setString(1, email); // Set schoolID as parameter
                ResultSet rs = preparedStatement.executeQuery();
                while (rs.next()) {
                    JsonObject studentObject = new JsonObject();
                    String departmentName = getDepartmentName(rs.getInt("DepartmentID"));
                    String schoolName = getSchoolName(rs.getInt("SchoolId"));
                    studentObject.addProperty("StudentID", rs.getString("StudentID"));
                    studentObject.addProperty("ContactNumber", rs.getString("ContactNumber"));
                    studentObject.addProperty("Email", rs.getString("Email"));
                    studentObject.addProperty("DepartmentName", departmentName);
                    studentObject.addProperty("Password", rs.getString("Password"));
                    studentObject.addProperty("SchoolName", schoolName);
                    studentObject.addProperty("Gender", rs.getString("Gender"));
                    studentObject.addProperty("AverageCGPA", rs.getFloat("AverageCGPA"));
                    studentObject.addProperty("Course", rs.getString("Course"));
                    studentObject.addProperty("StartYear", rs.getInt("StartYear"));
                    studentObject.addProperty("EndYear", rs.getInt("EndYear"));
                    studentInfo.add(studentObject);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();  // Log the exception for debugging
            response.getWriter().write("error "+ex.getMessage());
        }

        JsonObject responseObject = new JsonObject();
        responseObject.add("studentInfo", studentInfo);
        String finalResponse = responseObject.toString();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(finalResponse);
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

    private String getSchoolName(int schoolId){
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
            String query = "SELECT SchoolName FROM School WHERE SchoolID= ?";
            try (PreparedStatement preparedStatement = con.prepareStatement(query)) {
                preparedStatement.setInt(1, schoolId); // Set schoolName as parameter
                ResultSet rs = preparedStatement.executeQuery();
                if (rs.next()) {
                    name = rs.getString("SchoolName");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();  // Log the exception for debugging
        }

        return name;
    }


    public void destroy() {
    }
}
