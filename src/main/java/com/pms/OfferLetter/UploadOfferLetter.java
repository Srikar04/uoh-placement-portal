package com.pms.Application;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/uploadOfferLetter")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class UploadOfferLetter extends HttpServlet {

    private static Properties getConnectionData() {
        Properties props = new Properties();

        String fileName = "db.properties";

        // Use the ClassLoader to load the file from the resources directory
        try (InputStream in = UploadOfferLetter.class.getClassLoader().getResourceAsStream(fileName)){
            props.load(in);
        } catch (IOException ex) {
            Logger lgr = Logger.getLogger(UploadOfferLetter.class.getName());
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
        Part filePart = request.getPart("offerLetter");

        String SAVE_DIR = "/path/to/your/offer/letters/directory"; // Replace with your actual directory path

        File fileSaveDir = new File(SAVE_DIR);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }

        String fileURL = studentId + "_" + jobId + "_offerLetter.pdf";

        InputStream fileContent = filePart.getInputStream();

        FileOutputStream fos = new FileOutputStream(SAVE_DIR + File.separator + fileURL);

        byte[] buffer = new byte[1024];
        int bytesRead;
        while ((bytesRead = fileContent.read(buffer)) != -1) {
            fos.write(buffer, 0, bytesRead);
        }
        fos.close();
        fileContent.close();

        // ... (You might want to add database logic here to store the fileURL if needed)

        response.getWriter().write("Offer letter uploaded successfully!");
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