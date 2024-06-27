package com.pms.Student;

import java.io.*;
import java.sql.*;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.pms.Coordinator.UploadJob;
import com.pms.FetchSchool;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "updateProfile", value = "/updateProfile")
public class UpdateProfile extends HttpServlet {

    private static Properties getConnectionData() {
        Properties props = new Properties();
        String fileName = "db.properties";
        try (InputStream in = FetchSchool.class.getClassLoader().getResourceAsStream(fileName)) {
            props.load(in);
        } catch (IOException ex) {
            Logger lgr = Logger.getLogger(UploadJob.class.getName());
            lgr.log(Level.SEVERE, ex.getMessage(), ex);
        }
        return props;
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("userEmail"); // Get email from session

        // Extract form data (excluding email and ID number)
        String contactNumber = request.getParameter("contactNumber");
        String departmentName = request.getParameter("department");
        String schoolName = request.getParameter("school");
        String gender = request.getParameter("gender");
        double averageCGPA = Double.parseDouble(request.getParameter("averageCGPA"));
        String course = request.getParameter("course");
        int startYear = Integer.parseInt(request.getParameter("startYear"));
        int endYear = Integer.parseInt(request.getParameter("endYear"));

        Properties props = getConnectionData();
        String url = props.getProperty("db.url");
        String user = props.getProperty("db.user");
        String passwd = props.getProperty("db.passwd");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try (Connection conn = DriverManager.getConnection(url, user, passwd)) {
            // Retrieve DepartmentID based on department name
            int departmentID = getDepartmentID(conn, departmentName);

            // Retrieve SchoolID based on school name
            int schoolID = getSchoolID(conn, schoolName);

            // Update student information (excluding email and ID number)
            PreparedStatement updateStmt = conn.prepareStatement(
                    "UPDATE Student SET ContactNumber = ?, DepartmentID = ?, SchoolID = ?, Gender = ?, AverageCGPA = ?, Course = ?, StartYear = ?, EndYear = ? WHERE Email = ?");
            updateStmt.setString(1, contactNumber);
            updateStmt.setInt(2, departmentID);
            updateStmt.setInt(3, schoolID);
            updateStmt.setString(4, gender);
            updateStmt.setDouble(5, averageCGPA);
            updateStmt.setString(6, course);
            updateStmt.setInt(7, startYear);
            updateStmt.setInt(8, endYear);
            updateStmt.setString(9, email); // Use email from session for WHERE clause

            int rowsAffected = updateStmt.executeUpdate();
            if (rowsAffected > 0) {
                response.setStatus(HttpServletResponse.SC_OK); // 200 OK
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500 Internal Server Error
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            out.write("Error: " + ex.getMessage());
        }
    }

    // Retrieve DepartmentID based on department name
    private int getDepartmentID(Connection conn, String departmentName) throws SQLException {
        int departmentID = -1;
        PreparedStatement deptStmt = conn.prepareStatement("SELECT DepartmentID FROM Department WHERE DepartmentName = ?");
        deptStmt.setString(1, departmentName);
        ResultSet deptRs = deptStmt.executeQuery();
        if (deptRs.next()) {
            departmentID = deptRs.getInt("DepartmentID");
        }
        return departmentID;
    }

    // Retrieve SchoolID based on school name
    private int getSchoolID(Connection conn, String schoolName) throws SQLException {
        int schoolID = -1;
        PreparedStatement schoolStmt = conn.prepareStatement("SELECT SchoolID FROM School WHERE SchoolName = ?");
        schoolStmt.setString(1, schoolName);
        ResultSet schoolRs = schoolStmt.executeQuery();
        if (schoolRs.next()) {
            schoolID = schoolRs.getInt("SchoolID");
        }
        return schoolID;
    }
}