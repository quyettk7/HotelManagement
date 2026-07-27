<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bảng điều khiển Admin | Luxury Hotel</title>
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
        .stat-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            transition: transform 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-5px);
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
                        <a class="nav-link active" href="#">
                            <i class="bi bi-speedometer2"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="bi bi-people"></i> Quản lý User
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
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
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="bi bi-gear"></i> Thiết lập hệ thống
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Main Content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Dashboard</h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <button type="button" class="btn btn-sm btn-outline-secondary dropdown-toggle">
                        <i class="bi bi-calendar3"></i> Tuần này
                    </button>
                </div>
            </div>

            <!-- Welcome Alert -->
            <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert" style="border-radius: 12px;">
                <strong>Chào mừng quay trở lại, ${currentUser.fullName}!</strong> Bạn đã đăng nhập thành công với quyền <strong>${currentUser.roleName}</strong>.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>

            <!-- Dashboard Stats -->
            <div class="row g-4 mt-2">
                <div class="col-12 col-sm-6 col-xxl-3">
                    <div class="card stat-card bg-primary text-white h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-uppercase mb-1" style="font-size: 0.8rem; letter-spacing: 1px;">Phòng trống</h6>
                                    <h2 class="mb-0">12</h2>
                                </div>
                                <i class="bi bi-door-open" style="font-size: 2.5rem; opacity: 0.5;"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-xxl-3">
                    <div class="card stat-card bg-success text-white h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-uppercase mb-1" style="font-size: 0.8rem; letter-spacing: 1px;">Yêu cầu đặt phòng</h6>
                                    <h2 class="mb-0">5</h2>
                                </div>
                                <i class="bi bi-calendar2-plus" style="font-size: 2.5rem; opacity: 0.5;"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-xxl-3">
                    <div class="card stat-card bg-warning text-dark h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-uppercase mb-1" style="font-size: 0.8rem; letter-spacing: 1px;">Doanh thu tháng này</h6>
                                    <h2 class="mb-0">45.8M đ</h2>
                                </div>
                                <i class="bi bi-currency-dollar" style="font-size: 2.5rem; opacity: 0.5;"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-xxl-3">
                    <div class="card stat-card bg-danger text-white h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-uppercase mb-1" style="font-size: 0.8rem; letter-spacing: 1px;">Đang sử dụng dịch vụ</h6>
                                    <h2 class="mb-0">8</h2>
                                </div>
                                <i class="bi bi-cup-hot" style="font-size: 2.5rem; opacity: 0.5;"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="mt-5 p-5 bg-white border rounded shadow-sm text-center" style="border-radius: 16px;">
                <i class="bi bi-gear-wide-connected text-muted" style="font-size: 4rem;"></i>
                <h3 class="mt-3">Hệ thống đang được phát triển</h3>
                <p class="text-muted">Các tính năng quản lý chi tiết sẽ được phát triển ở những bước tiếp theo theo đúng thứ tự quy trình.</p>
            </div>
        </main>
    </div>
</div>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
