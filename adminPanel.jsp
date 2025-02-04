<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        /* General Styles */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            background-color: #f8f9fa;
            color: #212529;
        }

        /* Sidebar Styles */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 250px;
            background-color: #343a40;
            color: white;
            transition: width 0.3s;
            z-index: 1000;
            padding-top: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.2);
        }

        .sidebar h4 {
            font-size: 1.5rem;
            text-align: center;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            color: #ddd;
            text-decoration: none;
            padding: 10px 20px;
            margin-bottom: 5px;
            transition: background-color 0.3s, color 0.3s;
        }

        .sidebar a:hover, .sidebar a.active {
            background-color: #495057;
            color: white;
        }

        .sidebar a i {
            margin-right: 10px;
            font-size: 1.2rem;
        }

        .sidebar.collapsed {
            width: 80px;
        }

        .sidebar.collapsed a span {
            display: none;
        }

        .sidebar.collapsed h4 {
            font-size: 1rem;
        }

        /* Content Styles */
        .content {
            margin-left: 250px;
            padding: 20px;
            transition: margin-left 0.3s;
        }

        .content.collapsed {
            margin-left: 80px;
        }

        /* Navbar */
        .navbar {
            background-color: white;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 10px 20px;
            display: flex;
            align-items: center;
        }

        .navbar button {
            background-color: transparent;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
        }

        /* Upload Section */
        .upload-container {
            border: 2px dashed #6c757d;
            border-radius: 10px;
            padding: 30px;
            text-align: center;
            background-color: #f8f9fa;
            cursor: pointer;
            transition: border-color 0.3s;
        }

        .upload-container:hover {
            border-color: #343a40;
        }

        .upload-container.dragover {
            border-color: #007bff;
        }

        .upload-container i {
            font-size: 2.5rem;
            color: #6c757d;
        }

        .upload-container p {
            margin: 10px 0;
            color: #6c757d;
            font-size: 1.1rem;
        }

        .upload-container .text-primary {
            font-weight: bold;
            color: #007bff;
        }

        .upload-preview img {
            max-width: 100%;
            margin-top: 10px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        /* Card Styles */
        .card {
            margin-bottom: 20px;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .card-title {
            font-size: 1.2rem;
            font-weight: bold;
        }

        /* Buttons */
        .upload-btn {
            width: 100%;
            font-size: 1rem;
            padding: 10px;
            font-weight: bold;
            background-color: #28a745;
            border: none;
            color: white;
            transition: background-color 0.3s;
        }

        .upload-btn:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <div class="sidebar" id="sidebar">
        <h4 class="text-center text-white">Admin Panel</h4>
        <a href="#" class="active"><i class="bi bi-house-door"></i> <span>Dashboard</span></a>
        <a href="#"><i class="bi bi-people"></i> <span>Users</span></a>
        <a href="#"><i class="bi bi-bar-chart-line"></i> <span>Reports</span></a>
        <a href="#"><i class="bi bi-gear"></i> <span>Settings</span></a>
        <a href="#"><i class="bi bi-box-arrow-right"></i> <span>Logout</span></a>
    </div>

    <div class="content" id="content">
        <nav class="navbar">
            <button class="btn btn-outline-secondary" id="toggleSidebar">
                <i class="bi bi-list"></i>
            </button>
            <span class="ms-3">Admin Dashboard</span>
        </nav>

        <div class="container mt-4">
            <div class="row">
                <div class="col-lg-8">
                    <h3 class="mb-3">Image Upload</h3>
                    <form action="adminAction.jsp" method="post" enctype="multipart/form-data">
                        <div class="upload-container" id="uploadContainer">
                            <i class="bi bi-cloud-upload-fill"></i>
                            <p>Drag & Drop your image here, or <span class="text-primary">browse</span></p>
                            <input type="file" id="fileInput" class="form-control d-none" accept="image/*" name="file">
                        </div>
                        <div class="upload-preview" id="uploadPreview"></div>
                        <button type="submit" class="btn btn-success mt-3 upload-btn">Upload Image</button>
                    </form>
                </div>
                <div class="col-lg-4">
                    <div class="card">
                        <h5 class="card-title">Live Content</h5>
                        <p class="card-text">This section can display live updates, charts, or other relevant information for your admin dashboard.</p>
                    </div>
                    <div class="card">
                        <h5 class="card-title">Quick Stats</h5>
                        <p class="card-text">Show quick metrics here, such as user count, revenue, or other KPIs.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const sidebar = document.getElementById('sidebar');
        const content = document.getElementById('content');
        const toggleSidebar = document.getElementById('toggleSidebar');
        const uploadContainer = document.getElementById('uploadContainer');
        const fileInput = document.getElementById('fileInput');
        const uploadPreview = document.getElementById('uploadPreview');

        // Sidebar Toggle
        toggleSidebar.addEventListener('click', () => {
            sidebar.classList.toggle('collapsed');
            content.classList.toggle('collapsed');
        });

        // Drag and Drop Events
        uploadContainer.addEventListener('dragover', (e) => {
            e.preventDefault();
            uploadContainer.classList.add('dragover');
        });

        uploadContainer.addEventListener('dragleave', () => {
            uploadContainer.classList.remove('dragover');
        });

        uploadContainer.addEventListener('drop', (e) => {
            e.preventDefault();
            uploadContainer.classList.remove('dragover');
            const files = e.dataTransfer.files;
            if (files.length > 0) {
                handleFileUpload(files[0]);
            }
        });

        // Open File Dialog on Click
        uploadContainer.addEventListener('click', () => {
            fileInput.click();
        });

        fileInput.addEventListener('change', () => {
            if (fileInput.files.length > 0) {
                handleFileUpload(fileInput.files[0]);
            }
        });

        // Handle File Upload and Preview
        function handleFileUpload(file) {
            if (file && file.type.startsWith('image/')) {
                const reader = new FileReader();
                reader.onload = (e) => {
                    uploadPreview.innerHTML = `<img src="${e.target.result}" alt="Uploaded Image" class="img-fluid">`;
                };
                reader.readAsDataURL(file);
            } else {
                alert('Please upload a valid image file.');
            }
        }
    </script>
</body>
</html>
