<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty user ? 'Cập nhật Người dùng' : 'Thêm người dùng mới'} | Luxury Hotel</title>
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/users">
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/rooms">
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
                <h1 class="h2">${not empty user ? 'Cập nhật Người dùng' : 'Thêm người dùng mới'}</h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-secondary">
                        <i class="bi bi-arrow-left me-1"></i> Quay lại danh sách
                    </a>
                </div>
            </div>

            <!-- Error Notifications -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert" style="border-radius: 10px;">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div id="js-alert" class="alert alert-danger d-none" style="border-radius: 10px;">
                <i class="bi bi-exclamation-triangle-fill me-2"></i> <span id="js-alert-message"></span>
            </div>

            <div class="card p-4">
                <form action="${pageContext.request.contextPath}/admin/users" method="POST" id="userForm" novalidate>
                    <input type="hidden" name="userId" value="${user.userId}">
                    
                    <div class="row g-3">
                        <!-- Group 1: General Info -->
                        <div class="col-md-6">
                            <label for="fullName" class="form-label">Họ và tên <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="fullName" name="fullName" value="${user.fullName}" required>
                        </div>

                        <div class="col-md-6">
                            <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" id="email" name="email" value="${user.email}" required>
                        </div>

                        <div class="col-md-6">
                            <label for="phone" class="form-label">Số điện thoại</label>
                            <input type="text" class="form-control" id="phone" name="phone" value="${user.phone}">
                        </div>

                        <div class="col-md-6">
                            <label for="password" class="form-label">
                                Mật khẩu <c:if test="${empty user}"><span class="text-danger">*</span></c:if>
                            </label>
                            <input type="password" class="form-control" id="password" name="password" 
                                   placeholder="${not empty user ? 'Bỏ trống nếu không muốn đổi mật khẩu' : 'Mật khẩu đăng nhập'}">
                        </div>

                        <div class="col-md-6">
                            <label for="roleId" class="form-label">Vai trò <span class="text-danger">*</span></label>
                            <select class="form-select" id="roleId" name="roleId" required>
                                <option value="">-- Chọn vai trò --</option>
                                <c:forEach var="role" items="${roleList}">
                                    <option value="${role.roleId}" <c:if test="${user.roleId == role.roleId}">selected</c:if>>${role.roleName}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label d-block">Giới tính</label>
                            <div class="form-check form-check-inline mt-2">
                                <input class="form-check-input" type="radio" name="gender" id="genderMale" value="true" <c:if test="${user.gender eq true}">checked</c:if>>
                                <label class="form-check-label" for="genderMale">Nam</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="genderFemale" value="false" <c:if test="${user.gender eq false}">checked</c:if>>
                                <label class="form-check-label" for="genderFemale">Nữ</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="genderOther" value="" <c:if test="${empty user.gender}">checked</c:if>>
                                <label class="form-check-label" for="genderOther">Khác</label>
                            </div>
                        </div>

                        <!-- Group 2: Personal Details -->
                        <div class="col-md-6">
                            <label for="dateOfBirth" class="form-label">Ngày sinh</label>
                            <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" value="${user.dateOfBirth}">
                        </div>

                        <div class="col-md-6">
                            <label for="cccd" class="form-label">Số CCCD / Hộ chiếu</label>
                            <input type="text" class="form-control" id="cccd" name="cccd" value="${user.cccd}">
                        </div>

                        <div class="col-md-6">
                            <label for="nationality" class="form-label">Quốc tịch</label>
                            <input type="text" class="form-control" id="nationality" name="nationality" value="${not empty user.nationality ? user.nationality : 'Việt Nam'}">
                        </div>

                        <div class="col-md-6">
                            <label for="address" class="form-label">Địa chỉ</label>
                            <input type="text" class="form-control" id="address" name="address" value="${user.address}">
                        </div>

                        <div class="col-md-12">
                            <label class="form-label">Trạng thái tài khoản</label>
                            <div class="form-check form-switch mt-1">
                                <input class="form-check-input" type="checkbox" id="status" name="status" value="true"
                                       <c:if test="${empty user || user.status}">checked</c:if>>
                                <label class="form-check-label" for="status">Kích hoạt hoạt động (Cho phép đăng nhập)</label>
                            </div>
                        </div>

                        <div class="col-12 mt-4">
                            <button type="submit" class="btn btn-primary px-4 py-2 me-2">
                                <i class="bi bi-save me-1"></i> Lưu thông tin
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-secondary px-4 py-2">
                                Hủy bỏ
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </main>
    </div>
</div>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Client-side Validation JS -->
<script>
    const userForm = document.getElementById('userForm');
    const jsAlert = document.getElementById('js-alert');
    const jsAlertMessage = document.getElementById('js-alert-message');

    userForm.addEventListener('submit', function (event) {
        let fullName = document.getElementById('fullName').value.trim();
        let email = document.getElementById('email').value.trim();
        let roleId = document.getElementById('roleId').value;
        let password = document.getElementById('password').value;
        let userId = '${user.userId}';
        
        let errorMsg = '';

        if (fullName === '') {
            errorMsg = 'Họ và tên không được để trống.';
        } else if (email === '') {
            errorMsg = 'Email không được để trống.';
        } else if (!validateEmail(email)) {
            errorMsg = 'Định dạng email không hợp lệ.';
        } else if (userId === '' && password.trim() === '') {
            // Password required only for new users
            errorMsg = 'Mật khẩu không được để trống khi thêm người dùng mới.';
        } else if (roleId === '') {
            errorMsg = 'Vui lòng chọn vai trò.';
        }

        if (errorMsg !== '') {
            event.preventDefault();
            jsAlertMessage.textContent = errorMsg;
            jsAlert.classList.remove('d-none');
            window.scrollTo({ top: 0, behavior: 'smooth' });
        } else {
            jsAlert.classList.add('d-none');
        }
    });

    function validateEmail(email) {
        const re = /^[A-Za-z0-9+_.-]+@(.+)$/;
        return re.test(email);
    }
</script>
</body>
</html>
