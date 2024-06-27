package com.pms.Application;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;


@WebServlet("/downloadResume")
public class DownloadResume extends HttpServlet {

    private static final String SAVE_DIR = "/home/srikar/IdeaProjects/PMS/src/main/webapp/resources/resumes";


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fileURL = request.getParameter("fileURL");

        if (fileURL == null || fileURL.isEmpty()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Resume not found.");
            return;
        }

        File file = new File(SAVE_DIR + File.separator + fileURL);

        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Resume not found.");
            return;
        }

        response.setContentType("application/pdf");
        response.setContentLength((int) file.length());
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileURL + "\"");

        FileInputStream fis = new FileInputStream(file);

        OutputStream out = response.getOutputStream();


        byte[] buffer = new byte[4096];
        int bytesRead;
        while ((bytesRead = fis.read(buffer)) != -1) {
            out.write(buffer, 0, bytesRead);
        }

        out.flush();

        fis.close();
        out.close();
    }
}