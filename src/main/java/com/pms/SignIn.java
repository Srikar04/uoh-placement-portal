package com.pms;

import java.io.*;
import java.sql.*;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "signIn", value = "/signIn")
public class SignIn extends HttpServlet {


    private static Properties getConnectionData() {
        Properties props = new Properties();
        String fileName = "db.properties";

        // Use the ClassLoader to load the file from the resources directory
        try (InputStream in = SignIn.class.getClassLoader().getResourceAsStream(fileName)){
            props.load(in);
        } catch (IOException ex) {
            Logger lgr = Logger.getLogger(SignIn.class.getName());
            lgr.log(Level.SEVERE, ex.getMessage(), ex);
        }
        return props;
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Extract form data
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");

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
            PreparedStatement statement;
            if ("Student".equals(userType)) {
                statement = conn.prepareStatement("SELECT Password FROM Student WHERE Email = ?");
            } else if ("Coordinator".equals(userType)) {
                statement = conn.prepareStatement("SELECT Password FROM Coordinator WHERE Email = ?");
            } else if ("TPO".equals(userType)) {
                statement = conn.prepareStatement("SELECT Password FROM TPO WHERE Email = ?");
            } else if ("Chairman".equals(userType)) {
                statement = conn.prepareStatement("SELECT Password FROM Chairman WHERE Email = ?");
            } else {
                out.println("Invalid User Type");
                return;
            }

            statement.setString(1, email);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String storedPassword = resultSet.getString("Password");
                if (password.equals(storedPassword)) {
                    // Create session and set userType and userId attributes
                    HttpSession session = request.getSession();
                    session.setAttribute("userType", userType);
                    session.setAttribute("userEmail", email); // Storing email as userId
                    out.println("Success");
                } else {
                    out.println("Incorrect Password! Please try again.");
                }
            } else {
                out.println("Error: User not found!");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            out.println("Error: An error occurred while processing your request.");
        }
    }

    public void destroy() {
    }
}
