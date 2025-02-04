package bean;

public class Adminbean {
    private int id;
    private String fileName;
    private String filePath;
    private String uploadTime;

    // Default constructor
    public Adminbean() {
        super();
    }

    // Parameterized constructor
    public Adminbean(int id, String fileName, String filePath, String uploadTime) {
        super();
        this.id = id;
        this.fileName = fileName;
        this.filePath = filePath;
        this.uploadTime = uploadTime;
    }

    // Getter and Setter for id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Getter and Setter for fileName
    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    // Getter and Setter for filePath
    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    // Getter and Setter for uploadTime
    public String getUploadTime() {
        return uploadTime;
    }

    public void setUploadTime(String uploadTime) {
        this.uploadTime = uploadTime;
    }
}
