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

@WebServlet(name = "signUp", value = "/signUp")
public class SignUp extends HttpServlet {
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
        response.setContentType("text/html");

        // Hello
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>" + message + "</h1>");
        out.println("</body></html>");
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        System.out.println("hello");

        // Extract form data
        String idNumber = request.getParameter("idNumber").toUpperCase();
        String contactNumber = request.getParameter("contactNumber");
        String email = request.getParameter("email");
        String departmentName = request.getParameter("department"); // Assuming department name is submitted
        String schoolName = request.getParameter("school"); // Assuming school name is submitted
        String gender = request.getParameter("gender");
        double averageCGPA = Double.parseDouble(request.getParameter("averageCGPA"));
        String course = request.getParameter("course");
        String password = request.getParameter("password");
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

        try(Connection conn = DriverManager.getConnection(url, user, passwd)){
            // Retrieve DepartmentID based on department name
            int departmentID = getDepartmentID(conn, departmentName);

            // Retrieve SchoolID based on school name
            int schoolID = getSchoolID(conn, schoolName);

            PreparedStatement checkStmt = conn.prepareStatement("SELECT COUNT(*) FROM Student WHERE StudentID = ?");
            checkStmt.setString(1, idNumber);
            ResultSet rs = checkStmt.executeQuery();
            rs.next();
            int count = rs.getInt(1);
            if (count > 0) {
                out.write("User with ID " + idNumber + " already exists.");
            } else {
                // Insert new user into Student table
                PreparedStatement insertStmt = conn.prepareStatement(
                        "INSERT INTO Student (StudentID, ContactNumber, Email, DepartmentID, Password, SchoolID, Gender, AverageCGPA, Course, StartYear, EndYear) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                insertStmt.setString(1, idNumber);
                insertStmt.setString(2, contactNumber);
                insertStmt.setString(3, email);
                insertStmt.setInt(4, departmentID);
                insertStmt.setString(5, password);
                insertStmt.setInt(6, schoolID);
                insertStmt.setString(7, gender);
                insertStmt.setDouble(8, averageCGPA);
                insertStmt.setString(9, course);
                insertStmt.setInt(10, startYear);
                insertStmt.setInt(11, endYear);
                int rowsAffected = insertStmt.executeUpdate();
                if (rowsAffected > 0) {
                    out.write("User with ID " + idNumber + " successfully added.");
                    System.out.println("hello");
                } else {
                    out.write("Failed to add user with ID " + idNumber + ".");
                }
            }
        }catch (SQLException ex) {
            ex.printStackTrace();  // Log the exception for debugging
            String errorMessage = "Some error has occurred";
            response.getWriter().write("error "+ex.getMessage());
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

    public void destroy() {
    }
}