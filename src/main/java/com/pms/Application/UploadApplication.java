package com.pms.Application;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.FileOutputStream;
import java.sql.*;
import java.util.Date;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.pms.Coordinator.UploadJob;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/uploadApplication")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class UploadApplication extends HttpServlet {

    private static Properties getConnectionData() {
        Properties props = new Properties();

        String fileName = "db.properties";

        // Use the ClassLoader to load the file from the resources directory
        try (InputStream in = UploadJob.class.getClassLoader().getResourceAsStream(fileName)){
            props.load(in);
        } catch (IOException ex) {
            Logger lgr = Logger.getLogger(UploadJob.class.getName());
            lgr.log(Level.SEVERE, ex.getMessage(), ex);
        }
        return props;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String email = (String)session.getAttribute("userEmail");

        String studentId = getStudentId(email);

        int jobId = Integer.parseInt(request.getParameter("jobId"));
        Part filePart = request.getPart("resume");

        String SAVE_DIR = "/home/srikar/IdeaProjects/PMS/src/main/webapp/resources/resumes";

        File fileSaveDir = new File(SAVE_DIR);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }

        System.out.println(SAVE_DIR);

        String fileURL = studentId+"_"+jobId+"_resume.pdf";

        InputStream fileContent = filePart.getInputStream();

        FileOutputStream fos = new FileOutputStream(SAVE_DIR + File.separator + fileURL);

        byte[] buffer = new byte[1024];
        int bytesRead;
        while ((bytesRead = fileContent.read(buffer)) != -1) {
            fos.write(buffer, 0, bytesRead);
        }
        fos.close();
        fileContent.close();

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
            String query = "INSERT INTO Application (StudentID, JobID, AppliedOn, URL, Status) " +
                    "VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = con.prepareStatement(query)) {

                preparedStatement.setString(1, studentId); // Replace with actual student ID
                preparedStatement.setInt(2, jobId);
                preparedStatement.setDate(3, new java.sql.Date(new Date().getTime())); // Current date
                preparedStatement.setString(4, fileURL); // URL of the uploaded file
                preparedStatement.setString(5, "In Progress"); // Initial status


                int rowsInserted = preparedStatement.executeUpdate();
                if (rowsInserted > 0) {
                    System.out.println("Job information successfully added.");
                    response.getWriter().write("success");
                } else {
                    System.out.println("Some error has occurred.");
                    response.getWriter().write("error");
                }
            }catch (SQLException ex) {
                ex.printStackTrace();  // Log the exception for debugging
            }
        } catch (Exception ex) {
            ex.printStackTrace();  // Log the exception for debugging
            System.out.println("error");
            response.getWriter().write("error "+ex.getMessage());
        }
        // For this example, we'll just send a success response
        response.getWriter().write("File uploaded successfully!");
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
            String query = "SELECT StudentID FROM Student WHERE  Email= ?";
            try (PreparedStatement preparedStatement = con.prepareStatement(query)) {
                preparedStatement.setString(1, email); // Set schoolName as parameter
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