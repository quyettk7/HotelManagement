<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Phòng | Luxury Hotel</title>
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
        .table-responsive {
            border-radius: 12px;
            overflow: hidden;
        }
        .badge-status-active {
            background-color: rgba(25, 135, 84, 0.1);
            color: #198754;
            border: 1px solid rgba(25, 135, 84, 0.2);
        }
        .badge-status-inactive {
            background-color: rgba(220, 53, 69, 0.1);
            color: #dc3545;
            border: 1px solid rgba(220, 53, 69, 0.2);
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
                <h1 class="h2">Quản lý Phòng</h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <a href="${pageContext.request.contextPath}/admin/rooms?action=add" class="btn btn-primary">
                        <i class="bi bi-plus-circle me-1"></i> Thêm phòng mới
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
            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert" style="border-radius: 10px;">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> ${sessionScope.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="error" scope="session"/>
            </c:if>
            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert" style="border-radius: 10px;">
                    <i class="bi bi-check-circle-fill me-2"></i> ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty sessionScope.message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert" style="border-radius: 10px;">
                    <i class="bi bi-check-circle-fill me-2"></i> ${sessionScope.message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="message" scope="session"/>
            </c:if>

            <!-- Search Bar -->
            <div class="card p-3 mb-4">
                <div class="row g-3">
                    <div class="col-md-8 col-lg-9">
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
                            <input type="text" id="searchInput" class="form-control border-start-0" placeholder="Tìm kiếm theo Số phòng, Tên phòng, Vị trí...">
                        </div>
                    </div>
                    <div class="col-md-4 col-lg-3">
                        <select class="form-select" id="statusFilter">
                            <option value="">Tất cả trạng thái</option>
                            <option value="1">Kích hoạt</option>
                            <option value="0">Tắt</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Room List Table -->
            <div class="card p-4">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0" id="roomsTable">
                        <thead class="table-dark">
                            <tr>
                                <th scope="col" style="width: 80px;">Mã</th>
                                <th scope="col" style="width: 120px;">Số phòng</th>
                                <th scope="col">Tên phòng</th>
                                <th scope="col">Loại phòng</th>
                                <th scope="col">Giá một đêm</th>
                                <th scope="col" style="width: 100px;">Diện tích</th>
                                <th scope="col" style="width: 100px;">Số giường</th>
                                <th scope="col">Vị trí (Khu vực)</th>
                                <th scope="col" style="width: 120px;">Trạng thái</th>
                                <th scope="col" style="width: 120px; text-align: center;">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${roomList}">
                                <tr data-status="${item.status ? '1' : '0'}">
                                    <td><strong>#${item.roomId}</strong></td>
                                    <td><span class="badge bg-dark px-3 py-2 fs-6 room-number">${item.roomNumber}</span></td>
                                    <td><strong class="room-name">${item.roomName}</strong></td>
                                    <td><span class="badge bg-info text-dark">${item.categoryName}</span></td>
                                    <td>
                                        <strong class="text-primary">
                                            <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                        </strong>
                                    </td>
                                    <td>${item.acreage} m²</td>
                                    <td>${item.bed} giường</td>
                                    <td class="room-area">${item.area}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.status}">
                                                <span class="badge badge-status-active"><i class="bi bi-check2 me-1"></i>Kích hoạt</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-status-inactive"><i class="bi bi-x-circle me-1"></i>Tắt</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-group" role="group">
                                            <a href="${pageContext.request.contextPath}/admin/rooms?action=edit&id=${item.roomId}" class="btn btn-sm btn-outline-primary" title="Sửa">
                                                <i class="bi bi-pencil-square"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/rooms?action=delete&id=${item.roomId}" 
                                               class="btn btn-sm btn-outline-danger" 
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa phòng này? Toàn bộ ảnh liên quan cũng sẽ bị xóa.');" title="Xóa">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty roomList}">
                                <tr>
                                    <td colspan="10" class="text-center py-4 text-muted">Không có phòng nào.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</div>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Search and Filter JS -->
<script>
    const searchInput = document.getElementById('searchInput');
    const statusFilter = document.getElementById('statusFilter');
    const roomsTable = document.getElementById('roomsTable');
    const rows = roomsTable.getElementsByTagName('tbody')[0].getElementsByTagName('tr');

    function filterTable() {
        const searchText = searchInput.value.toLowerCase().trim();
        const selectedStatus = statusFilter.value;

        for (let i = 0; i < rows.length; i++) {
            const row = rows[i];
            if (row.cells.length <= 1) continue; // Skip empty row message

            const roomNumber = row.querySelector('.room-number').textContent.toLowerCase();
            const roomName = row.querySelector('.room-name').textContent.toLowerCase();
            const roomArea = row.querySelector('.room-area').textContent.toLowerCase();
            const status = row.getAttribute('data-status');

            const matchesSearch = roomNumber.includes(searchText) || roomName.includes(searchText) || roomArea.includes(searchText);
            const matchesStatus = selectedStatus === "" || status === selectedStatus;

            if (matchesSearch && matchesStatus) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        }
    }

    searchInput.addEventListener('keyup', filterTable);
    statusFilter.addEventListener('change', filterTable);
</script>
</body>
</html>
