<%@ page import="java.io.File, org.apache.commons.fileupload.FileItem, org.apache.commons.fileupload.disk.DiskFileItemFactory, org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="bean.Adminbean, dao.Admindao" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin File Upload</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">File Upload</h2>
        <div class="card mt-4">
            <div class="card-body">
                <%
                    String message = "";
                    boolean isMultipart = ServletFileUpload.isMultipartContent(request);

                    if (isMultipart) {
                        String uploadDir = application.getRealPath("/") + "uploads";
                        File dir = new File(uploadDir);
                        if (!dir.exists()) {
                            dir.mkdir();
                        }

                        try {
                            DiskFileItemFactory factory = new DiskFileItemFactory();
                            ServletFileUpload upload = new ServletFileUpload(factory);

                            // Process uploaded items
                            for (FileItem item : upload.parseRequest(request)) {
                                if (!item.isFormField()) {
                                    String fileName = new File(item.getName()).getName();
                                    String filePath = "uploads/" + fileName;

                                    // Save the file to the server
                                    File uploadedFile = new File(uploadDir, fileName);
                                    item.write(uploadedFile);

                                    // Save file details to the database
                                    Adminbean fileBean = new Adminbean();
                                    fileBean.setFileName(fileName);
                                    fileBean.setFilePath(filePath);

                                    Admindao dao = new Admindao();
                                    boolean isSaved = dao.saveFile(fileBean);

                                    if (isSaved) {
                                        message = "File uploaded and saved to database successfully!";
                                    } else {
                                        message = "Error: Failed to save file details to the database.";
                                    }
                                }
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            message = "Error: " + e.getMessage();
                        }
                    } else {
                        message = "Invalid request. Please use the file upload form.";
                    }
                %>
                <div class="alert alert-info"><%= message %></div>
                <a href="adminPanel.jsp" class="btn btn-primary">Back to Admin Panel</a>
            </div>
        </div>
    </div>
</body>
</html>
