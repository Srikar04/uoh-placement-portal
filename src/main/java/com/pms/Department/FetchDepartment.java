package com.pms.Department;

import java.io.*;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.pms.Coordinator.UploadJob;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import com.google.gson.Gson;

@WebServlet(name = "fetchDepartment", value = "/fetchDepartment")
public class FetchDepartment extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    private static Properties getConnectionData() {
        Properties props = new Properties();

        String fileName = "db.properties";

        // Use the ClassLoader to load the file from the resources directory
        try (InputStream in = FetchDepartment.class.getClassLoader().getResourceAsStream(fileName)){
            props.load(in);
        } catch (IOException ex) {
            Logger lgr = Logger.getLogger(UploadJob.class.getName());
            lgr.log(Level.SEVERE, ex.getMessage(), ex);
        }
        return props;
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String schoolName = request.getParameter("schoolName"); // Retrieve schoolName parameter from request
        int schoolID = -1; // Initialize schoolID to -1

        // Fetch schoolID corresponding to the provided schoolName
        if (schoolName != null && !schoolName.isEmpty()) {
            schoolID = getSchoolID(schoolName);
        }

        if (schoolID == -1) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Set response status to 400 Bad Request if schoolID is not found
            response.getWriter().write("Invalid school name"); // Send error message
            return;
        }

        List<String> departments = new ArrayList<>();

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
            String query = "SELECT DepartmentName FROM Department WHERE SchoolID = ?";
            try (PreparedStatement preparedStatement = con.prepareStatement(query)) {
                preparedStatement.setInt(1, schoolID); // Set schoolID as parameter
                ResultSet rs = preparedStatement.executeQuery();
                while (rs.next()) {
                    departments.add(rs.getString("DepartmentName"));
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();  // Log the exception for debugging
            String errorMessage = "Some error has occurred";
            response.getWriter().write("error "+ex.getMessage());
        }

        // Convert departments to JSON and send as response
        String jsonResponse = new Gson().toJson(departments);

        // Wrap the JSON response in an object with a "schools" property
        String finalResponse = "{\"departments\":" + jsonResponse + "}";

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(finalResponse);
    }

    // Method to retrieve schoolID based on schoolName
    private int getSchoolID(String schoolName) {
        int schoolID = -1;

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
            String query = "SELECT SchoolID FROM School WHERE SchoolName = ?";
            try (PreparedStatement preparedStatement = con.prepareStatement(query)) {
                preparedStatement.setString(1, schoolName); // Set schoolName as parameter
                ResultSet rs = preparedStatement.executeQuery();
                if (rs.next()) {
                    schoolID = rs.getInt("SchoolID");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();  // Log the exception for debugging
        }

        return schoolID;
    }

    public void destroy() {
    }
}
