package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Adminbean;
import dbConnection.DBconnection;

public class Admindao {
    
    // Method to save file details into the database
    public boolean saveFile(Adminbean adminbean) {
        boolean status = false;
        try (Connection conn = DBconnection.getConnection()) {
            String query = "INSERT INTO uploaded_files (file_name, file_path) VALUES (?, ?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, adminbean.getFileName());
            ps.setString(2, adminbean.getFilePath());
            status = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
    
    // Method to retrieve all file details from the database
    public List<Adminbean> getAllFiles() {
        List<Adminbean> fileList = new ArrayList<>();
        try (Connection conn = DBconnection.getConnection()) {
            String query = "SELECT * FROM uploaded_files ORDER BY upload_time DESC";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Adminbean file = new Adminbean();
                file.setId(rs.getInt("id"));
                file.setFileName(rs.getString("file_name"));
                file.setFilePath(rs.getString("file_path"));
                file.setUploadTime(rs.getString("upload_time"));
                fileList.add(file);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fileList;
    }
}
