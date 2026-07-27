<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty room ? 'Cập nhật Phòng' : 'Thêm phòng mới'} | Luxury Hotel</title>
    <!-- Google Fonts - Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8f9fa;
        }
        .navbar-brand {
            font-weight: 700;
            letter-spacing: 1px;
            color: #D4AF37 !important;
        }
        .sidebar {
            min-height: calc(100vh - 56px);
            background-color: #212529;
            color: #fff;
        }
        .sidebar .nav-link {
            color: #adb5bd;
            font-weight: 500;
            padding: 12px 20px;
            transition: all 0.2s ease;
        }
        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            color: #fff;
            background-color: rgba(255,255,255,0.1);
        }
        .sidebar .nav-link i {
            margin-right: 10px;
        }
        .main-content {
            padding: 30px;
        }
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        }
        .image-preview-card {
            position: relative;
            border-radius: 10px;
            overflow: hidden;
            border: 1px solid #dee2e6;
        }
        .image-preview-card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }
        .image-delete-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: rgba(220, 53, 69, 0.9);
            color: #fff;
            border: none;
            border-radius: 50%;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .image-delete-btn:hover {
            background-color: #dc3545;
        }
        .main-badge {
            position: absolute;
            bottom: 10px;
            left: 10px;
            background-color: rgba(25, 135, 84, 0.9);
            color: white;
            font-size: 0.75rem;
            padding: 4px 8px;
            border-radius: 5px;
            font-weight: 600;
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="#"><i class="bi bi-houses-fill me-2"></i>LUXURY HOTEL</a>
        <button class="navbar-expand-toggle navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav align-items-center">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-light" href="#" role="button" data-bs-toggle="dropdown">
                        <i class="bi bi-person-circle me-1"></i> ${currentUser.fullName} (${currentUser.roleName})
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-menu-item dropdown-item" href="#"><i class="bi bi-person me-2"></i>Thông tin cá nhân</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-menu-item dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse" id="navbarNav">
            <div class="position-sticky pt-3">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                            <i class="bi bi-speedometer2"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                            <i class="bi bi-people"></i> Quản lý User
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/roles">
                            <i class="bi bi-shield-lock"></i> Quản lý Vai trò
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/room-categories">
                            <i class="bi bi-grid-3x3-gap"></i> Quản lý Loại phòng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/rooms">
                            <i class="bi bi-door-closed"></i> Quản lý Phòng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="bi bi-calendar-check"></i> Quản lý Đặt phòng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="bi bi-receipt"></i> Quản lý Hóa đơn
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Main Content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">${not empty room ? 'Cập nhật Phòng' : 'Thêm phòng mới'}</h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <a href="${pageContext.request.contextPath}/admin/rooms" class="btn btn-outline-secondary">
                        <i class="bi bi-arrow-left me-1"></i> Quay lại danh sách
                    </a>
                </div>
            </div>

            <!-- Notifications -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert" style="border-radius: 10px;">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert" style="border-radius: 10px;">
                    <i class="bi bi-check-circle-fill me-2"></i> ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="row g-4">
                <!-- Basic Room Form -->
                <div class="col-lg-7">
                    <div class="card p-4">
                        <h5 class="card-title mb-4">Thông tin cơ bản</h5>
                        <form action="${pageContext.request.contextPath}/admin/rooms" method="POST" id="roomForm">
                            <input type="hidden" name="roomId" value="${room.roomId}">

                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="roomNumber" class="form-label">Số phòng <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="roomNumber" name="roomNumber" value="${room.roomNumber}" required placeholder="Ví dụ: 101">
                                </div>

                                <div class="col-md-6">
                                    <label for="roomName" class="form-label">Tên phòng</label>
                                    <input type="text" class="form-control" id="roomName" name="roomName" value="${room.roomName}" placeholder="Ví dụ: Standard Room 101">
                                </div>

                                <div class="col-md-6">
                                    <label for="categoryId" class="form-label">Loại phòng <span class="text-danger">*</span></label>
                                    <select class="form-select" id="categoryId" name="categoryId" required>
                                        <option value="">-- Chọn loại phòng --</option>
                                        <c:forEach var="cat" items="${categoryList}">
                                            <option value="${cat.categoryId}" <c:if test="${room.categoryId == cat.categoryId}">selected</c:if>>
                                                ${cat.categoryName} (Gợi ý: ${cat.basePrice}đ)
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label for="price" class="form-label">Giá một đêm (VND) <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="price" name="price" value="${room.price}" min="0" required placeholder="Ví dụ: 500000">
                                </div>

                                <div class="col-md-4">
                                    <label for="acreage" class="form-label">Diện tích (m²)</label>
                                    <input type="number" class="form-control" id="acreage" name="acreage" value="${room.acreage}" min="0" step="0.1" placeholder="Ví dụ: 25">
                                </div>

                                <div class="col-md-4">
                                    <label for="bed" class="form-label">Số giường</label>
                                    <input type="number" class="form-control" id="bed" name="bed" value="${room.bed}" min="1" placeholder="Ví dụ: 1">
                                </div>

                                <div class="col-md-4">
                                    <label for="area" class="form-label">Vị trí (Khu vực / Tầng)</label>
                                    <input type="text" class="form-control" id="area" name="area" value="${room.area}" placeholder="Ví dụ: Tầng 1">
                                </div>

                                <div class="col-md-12">
                                    <label for="description" class="form-label">Mô tả chi tiết</label>
                                    <textarea class="form-control" id="description" name="description" rows="4" placeholder="Nhập tiện nghi, hướng view phòng...">${room.description}</textarea>
                                </div>

                                <div class="col-md-12">
                                    <label class="form-label">Trạng thái phòng</label>
                                    <div class="form-check form-switch mt-1">
                                        <input class="form-check-input" type="checkbox" id="status" name="status" value="true"
                                               <c:if test="${empty room || room.status}">checked</c:if>>
                                        <label class="form-check-label" for="status">Kích hoạt hoạt động (Sẵn sàng cho đặt phòng)</label>
                                    </div>
                                </div>

                                <div class="col-12 mt-4">
                                    <button type="submit" class="btn btn-primary px-4 py-2 me-2">
                                        <i class="bi bi-save me-1"></i> Lưu thông tin
                                    </button>
                                    <a href="${pageContext.request.contextPath}/admin/rooms" class="btn btn-outline-secondary px-4 py-2">
                                        Hủy bỏ
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Images Gallery Form (Enabled only when Room is created) -->
                <div class="col-lg-5">
                    <div class="card p-4 h-100">
                        <h5 class="card-title mb-4">Bộ sưu tập ảnh phòng</h5>

                        <c:choose>
                            <c:when test="${empty room}">
                                <div class="alert alert-info" role="alert" style="border-radius: 10px;">
                                    <i class="bi bi-info-circle-fill me-2"></i> Bạn cần lưu thông tin cơ bản của phòng trước khi thêm bộ ảnh phòng.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <!-- Form to Add Image -->
                                <form action="${pageContext.request.contextPath}/admin/rooms" method="POST" class="mb-4 pb-4 border-bottom">
                                    <input type="hidden" name="subAction" value="add-image">
                                    <input type="hidden" name="roomId" value="${room.roomId}">

                                    <div class="mb-3">
                                        <label for="imageUrl" class="form-label">Đường dẫn ảnh (URL hoặc Tên file) <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="imageUrl" name="imageUrl" required placeholder="Ví dụ: deluxe_room_201.jpg hoặc https://example.com/img.jpg">
                                    </div>

                                    <div class="row g-2 mb-3">
                                        <div class="col-sm-6">
                                            <label for="sortOrder" class="form-label">Thứ tự hiển thị</label>
                                            <input type="number" class="form-control" id="sortOrder" name="sortOrder" value="1" min="1">
                                        </div>
                                        <div class="col-sm-6 d-flex align-items-end">
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="checkbox" id="isMain" name="isMain" value="true">
                                                <label class="form-check-label" for="isMain">Đặt làm ảnh chính</label>
                                            </div>
                                        </div>
                                    </div>

                                    <button type="submit" class="btn btn-outline-primary btn-sm w-100">
                                        <i class="bi bi-image-fill me-1"></i> Thêm ảnh vào phòng
                                    </button>
                                </form>

                                <!-- Gallery List -->
                                <div class="row g-3">
                                    <c:forEach var="img" items="${imagesList}">
                                        <div class="col-sm-6">
                                            <div class="image-preview-card">
                                                <!-- If it's a relative image name, we can prefix it or show placeholder, let's just use it as src -->
                                                <img src="${img.imageUrl.startsWith('http') ? img.imageUrl : pageContext.request.contextPath.concat('/assets/img/').concat(img.imageUrl)}" 
                                                     onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?auto=format&fit=crop&w=400&q=80';"
                                                     alt="Room Image">
                                                
                                                <c:if test="${img.isMain}">
                                                    <span class="main-badge">Ảnh chính</span>
                                                </c:if>
                                                
                                                <a href="${pageContext.request.contextPath}/admin/rooms?action=delete-image&id=${img.imageId}&roomId=${room.roomId}" 
                                                   class="image-delete-btn"
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa ảnh này?');"
                                                   title="Xóa ảnh">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </div>
                                            <div class="text-center mt-1"><small class="text-muted">Thứ tự: ${img.sortOrder}</small></div>
                                        </div>
                                    </c:forEach>
                                    <c:if test="${empty imagesList}">
                                        <div class="col-12 text-center text-muted py-4">Chưa có ảnh nào được thêm vào.</div>
                                    </c:if>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Room validation -->
<script>
    const rForm = document.getElementById('roomForm');
    rForm.addEventListener('submit', function (event) {
        const price = parseFloat(document.getElementById('price').value);
        const acreage = parseFloat(document.getElementById('acreage').value || 0);
        const bed = parseInt(document.getElementById('bed').value || 1);

        if (price < 0) {
            alert('Giá phòng phải lớn hơn hoặc bằng 0.');
            event.preventDefault();
        } else if (acreage < 0) {
            alert('Diện tích phòng phải lớn hơn hoặc bằng 0.');
            event.preventDefault();
        } else if (bed <= 0) {
            alert('Số giường phải lớn hơn 0.');
            event.preventDefault();
        }
    });
</script>
</body>
</html>
