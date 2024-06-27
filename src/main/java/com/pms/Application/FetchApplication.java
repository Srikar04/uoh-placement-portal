package com.pms.Application;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
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

@WebServlet(name = "fetchApplication", value = "/fetchApplication")
public class FetchApplication extends HttpServlet {

    private static Properties getConnectionData() {
        Properties props = new Properties();

        String fileName = "db.properties";

        // Use the ClassLoader to load the file from the resources directory
        try (InputStream in = FetchApplication.class.getClassLoader().getResourceAsStream(fileName)) {
            props.load(in);
        } catch (IOException ex) {
            Logger lgr = Logger.getLogger(FetchApplication.class.getName());
            lgr.log(Level.SEVERE, ex.getMessage(), ex);
        }
        return props;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("userEmail") != null) {
            try {
                String email = (String) session.getAttribute("userEmail");
                String studentId = getStudentId(email);
                JsonArray applications = getApplicationsByStudent(studentId);

                JsonObject responseObject = new JsonObject();
                responseObject.add("applications", applications);
                String finalResponse = responseObject.toString();
                response.setStatus(HttpServletResponse.SC_OK);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(finalResponse);
            } catch (Exception ex) {
                ex.printStackTrace();  // Log the exception for debugging
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                JsonObject errorObject = new JsonObject();
                errorObject.addProperty("error", ex.getMessage());
                response.getWriter().write(errorObject.toString());
            }
        } else {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            JsonObject errorObject = new JsonObject();
            errorObject.addProperty("error", "Session is null or userEmail is not available.");
            response.getWriter().write(errorObject.toString());
        }
    }

    private JsonArray getApplicationsByStudent(String studentId) {
        JsonArray applicationsArray = new JsonArray();

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
            String query = "SELECT * FROM Application WHERE StudentID= ?";
            try (PreparedStatement preparedStatement = con.prepareStatement(query)) {
                preparedStatement.setString(1, studentId);

                // Execute the query
                ResultSet resultSet = preparedStatement.executeQuery();

                // Iterate through the result set and add applications to the JSON array
                while (resultSet.next()) {
                    JsonObject applicationObject = new JsonObject();
                    applicationObject.addProperty("ApplicationID", resultSet.getInt("ApplicationID"));
                    applicationObject.addProperty("StudentID", resultSet.getString("StudentID"));
                    applicationObject.addProperty("JobID", resultSet.getInt("JobID"));
                    applicationObject.addProperty("AppliedOn", resultSet.getDate("AppliedOn").toString());
                    applicationObject.addProperty("URL", resultSet.getString("URL"));
                    applicationObject.addProperty("Status", resultSet.getString("Status"));

                    int jobId = resultSet.getInt("JobID");
                    JsonObject jobDetails = getJobDetails(jobId);
                    applicationObject.add("JobDetails", jobDetails);

                    applicationsArray.add(applicationObject);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();  // Log the exception for debugging
        }

        return applicationsArray;
    }

    private JsonObject getJobDetails(int jobId) {
        JsonObject jobDetails = new JsonObject();

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
            String query = "SELECT JobID, OrgName, JobName FROM Jobs WHERE JobID= ?";
            try (PreparedStatement preparedStatement = con.prepareStatement(query)) {
                preparedStatement.setInt(1, jobId);

                // Execute the query
                ResultSet resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) {
                    jobDetails.addProperty("JobID",resultSet.getInt("JobID"));
                    jobDetails.addProperty("OrgName", resultSet.getString("OrgName"));
                    jobDetails.addProperty("JobName", resultSet.getString("JobName"));
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();  // Log the exception for debugging
        }

        return jobDetails;
    }


    private String getStudentId(String email) {
        String studId = "";

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
            String query = "SELECT StudentID FROM Student WHERE Email= ?";
            try (PreparedStatement preparedStatement = con.prepareStatement(query)) {
                preparedStatement.setString(1, email); // Set email as parameter
                ResultSet rs = preparedStatement.executeQuery();
                if (rs.next()) {
                    studId = rs.getString("StudentID");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();  // Log the exception for debugging
        }

        return studId;
    }
}