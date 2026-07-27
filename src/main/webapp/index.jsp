<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ | Luxury Hotel</title>
    <!-- Google Fonts - Inter & Playfair Display -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,400&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-gold: #D4AF37;
            --primary-gold-hover: #AA7C11;
            --bg-dark: #121212;
            --text-light: #F3F4F6;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #fcfcfc;
            color: #333;
        }

        /* Hero Section */
        .hero-section {
            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.7)), 
                        url('https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=1920&q=80') no-repeat center center;
            background-size: cover;
            height: 70vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            text-align: center;
        }

        .hero-title {
            font-family: 'Playfair Display', serif;
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 20px;
            letter-spacing: 1px;
        }

        .hero-subtitle {
            font-size: 1.2rem;
            text-transform: uppercase;
            letter-spacing: 4px;
            color: var(--primary-gold);
            margin-bottom: 30px;
        }

        /* Navbar Customization */
        .navbar {
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .navbar-brand {
            font-family: 'Playfair Display', serif;
            font-weight: 700;
            color: var(--primary-gold) !important;
            letter-spacing: 1px;
        }

        .btn-gold {
            background-color: var(--primary-gold);
            color: #000;
            font-weight: 600;
            border: none;
            transition: all 0.3s ease;
        }

        .btn-gold:hover {
            background-color: var(--primary-gold-hover);
            color: #000;
            transform: translateY(-2px);
        }

        .btn-outline-gold {
            border: 2px solid var(--primary-gold);
            color: var(--primary-gold);
            font-weight: 600;
            background: transparent;
            transition: all 0.3s ease;
        }

        .btn-outline-gold:hover {
            background-color: var(--primary-gold);
            color: #000;
        }
    </style>
</head>
<body>

<!-- Header Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">
            <i class="bi bi-houses-fill me-2"></i>LUXURY HOTEL
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav align-items-center gap-3">
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a>
                </li>
                <c:choose>
                    <c:when test="${not empty currentUser}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-light" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="bi bi-person-circle me-1"></i> Xin chào, ${currentUser.fullName}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><span class="dropdown-item-text text-muted">Vai trò: ${currentUser.roleName}</span></li>
                                <c:if test="${currentUser.roleName eq 'Admin' or currentUser.roleName eq 'Manager' or currentUser.roleName eq 'Staff'}">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2 me-2"></i>Dashboard Admin</a></li>
                                </c:if>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="btn btn-outline-gold px-4" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<header class="hero-section">
    <div class="container">
        <p class="hero-subtitle">Trải nghiệm kỳ nghỉ xa hoa & đẳng cấp</p>
        <h1 class="hero-title">Chào mừng đến với Luxury Hotel</h1>
        <div class="d-flex justify-content-center gap-3 mt-4">
            <c:choose>
                <c:when test="${not empty currentUser}">
                    <c:if test="${currentUser.roleName eq 'Admin' or currentUser.roleName eq 'Manager' or currentUser.roleName eq 'Staff'}">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-gold btn-lg px-4 py-2">Vào trang quản trị <i class="bi bi-arrow-right-short"></i></a>
                    </c:if>
                    <c:if test="${currentUser.roleName eq 'Customer'}">
                        <a href="#" class="btn btn-gold btn-lg px-4 py-2">Đặt phòng ngay <i class="bi bi-calendar2-check ms-1"></i></a>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-gold btn-lg px-5 py-3">Bắt đầu ngay</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>

<!-- Main Info Section -->
<section class="container my-5 py-4">
    <div class="row text-center g-4">
        <div class="col-md-4">
            <div class="p-3">
                <i class="bi bi-shield-check text-warning" style="font-size: 3rem;"></i>
                <h4 class="mt-3">Dịch vụ đẳng cấp 5 sao</h4>
                <p class="text-muted">Đội ngũ nhân viên chuyên nghiệp sẵn sàng phục vụ quý khách 24/7 với chất lượng tốt nhất.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="p-3">
                <i class="bi bi-gem text-warning" style="font-size: 3rem;"></i>
                <h4 class="mt-3">Phòng nghỉ sang trọng</h4>
                <p class="text-muted">Hệ thống phòng nghỉ đa dạng, thiết kế hiện đại, view đẹp và đầy đủ tiện nghi cao cấp.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="p-3">
                <i class="bi bi-tags text-warning" style="font-size: 3rem;"></i>
                <h4 class="mt-3">Ưu đãi hấp dẫn</h4>
                <p class="text-muted">Nhiều chương trình khuyến mãi, voucher giảm giá đặc quyền dành cho khách hàng VIP.</p>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="bg-dark text-light py-4 mt-auto">
    <div class="container text-center">
        <p class="mb-1">&copy; 2026 Luxury Hotel System. Bảo lưu mọi quyền.</p>
        <p class="text-muted small">Thiết kế chuẩn MVC & JDBC thuần kết nối cơ sở dữ liệu SQL Server.</p>
    </div>
</footer>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>