package com.pms;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.google.gson.Gson;
import com.pms.Coordinator.UploadJob;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "fetchSchool", value = "/fetchSchool")
public class FetchSchool extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

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

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<String> schools = new ArrayList<String>();

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
            String query = "SELECT SchoolName FROM School";
            try (PreparedStatement preparedStatement = con.prepareStatement(query)) {
                ResultSet rs = preparedStatement.executeQuery(query);
                while (rs.next()) {
                    schools.add(rs.getString("SchoolName"));
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();  // Log the exception for debugging
            String errorMessage = "Some error has occurred";
            response.getWriter().write("error "+ex.getMessage());
        }

        // Convert departments to JSON and send as response
        String jsonResponse = new Gson().toJson(schools);

        // Wrap the JSON response in an object with a "schools" property
        String finalResponse = "{\"schools\":" + jsonResponse + "}";

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(finalResponse);
    }

    public void destroy() {
    }
}