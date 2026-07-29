<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Quản lý Đặt phòng | Luxury Hotel</title>
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css"
                    rel="stylesheet">
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

                    .sidebar .nav-link:hover,
                    .sidebar .nav-link.active {
                        color: #fff;
                        background-color: rgba(255, 255, 255, 0.1);
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
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
                    }

                    .table-responsive {
                        border-radius: 12px;
                        overflow: hidden;
                    }

                    .stat-card {
                        border-radius: 12px;
                        padding: 20px;
                        color: white;
                    }

                    .stat-card .stat-number {
                        font-size: 2rem;
                        font-weight: 700;
                    }

                    .stat-card .stat-label {
                        font-size: 0.85rem;
                        opacity: 0.9;
                    }

                    /* Status badges */
                    .badge-pending {
                        background-color: rgba(255, 193, 7, 0.15);
                        color: #d4a017;
                        border: 1px solid rgba(255, 193, 7, 0.3);
                        padding: 5px 10px;
                        border-radius: 20px;
                        font-size: 0.78rem;
                    }

                    .badge-confirmed {
                        background-color: rgba(13, 110, 253, 0.1);
                        color: #0d6efd;
                        border: 1px solid rgba(13, 110, 253, 0.3);
                        padding: 5px 10px;
                        border-radius: 20px;
                        font-size: 0.78rem;
                    }

                    .badge-staying {
                        background-color: rgba(25, 135, 84, 0.1);
                        color: #198754;
                        border: 1px solid rgba(25, 135, 84, 0.3);
                        padding: 5px 10px;
                        border-radius: 20px;
                        font-size: 0.78rem;
                    }

                    .badge-checkedout {
                        background-color: rgba(108, 117, 125, 0.1);
                        color: #6c757d;
                        border: 1px solid rgba(108, 117, 125, 0.3);
                        padding: 5px 10px;
                        border-radius: 20px;
                        font-size: 0.78rem;
                    }

                    .badge-cancelled {
                        background-color: rgba(220, 53, 69, 0.1);
                        color: #dc3545;
                        border: 1px solid rgba(220, 53, 69, 0.3);
                        padding: 5px 10px;
                        border-radius: 20px;
                        font-size: 0.78rem;
                    }

                    .search-box {
                        border-radius: 8px;
                        border: 1px solid #dee2e6;
                        padding: 8px 15px;
                    }

                    .search-box:focus {
                        border-color: #D4AF37;
                        box-shadow: 0 0 0 0.2rem rgba(212, 175, 55, 0.15);
                        outline: none;
                    }

                    .table thead th {
                        background-color: #212529;
                        color: #fff;
                        border: none;
                        padding: 14px 12px;
                        font-weight: 500;
                        font-size: 0.85rem;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                    }

                    .table tbody tr {
                        transition: background-color 0.15s;
                    }

                    .table tbody tr:hover {
                        background-color: rgba(212, 175, 55, 0.04);
                    }
                </style>
            </head>

            <body>
                <!-- Navigation Bar -->
                <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="#"><i class="bi bi-houses-fill me-2"></i>LUXURY HOTEL</a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNav">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                            <ul class="navbar-nav align-items-center">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle text-light" href="#" role="button"
                                        data-bs-toggle="dropdown">
                                        <i class="bi bi-person-circle me-1"></i>${sessionScope.currentUser.fullName}
                                        (${sessionScope.currentUser.roleName})
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <li>
                                            <hr class="dropdown-divider">
                                        </li>
                                        <li><a class="dropdown-item text-danger"
                                                href="${pageContext.request.contextPath}/logout"><i
                                                    class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <div class="container-fluid">
                    <div class="row">
                        <!-- Sidebar -->
                        <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse">
                            <div class="position-sticky pt-3">
                                <ul class="nav flex-column">
                                    <li class="nav-item"><a class="nav-link"
                                            href="${pageContext.request.contextPath}/admin/dashboard"><i
                                                class="bi bi-speedometer2"></i> Dashboard</a></li>
                                    <li class="nav-item"><a class="nav-link"
                                            href="${pageContext.request.contextPath}/admin/users"><i
                                                class="bi bi-people"></i> Quản lý User</a></li>
                                    <li class="nav-item"><a class="nav-link"
                                            href="${pageContext.request.contextPath}/admin/roles"><i
                                                class="bi bi-shield-lock"></i> Quản lý Vai trò</a></li>
                                    <li class="nav-item"><a class="nav-link"
                                            href="${pageContext.request.contextPath}/admin/room-categories"><i
                                                class="bi bi-grid-3x3-gap"></i> Quản lý Loại phòng</a></li>
                                    <li class="nav-item"><a class="nav-link"
                                            href="${pageContext.request.contextPath}/admin/rooms"><i
                                                class="bi bi-door-closed"></i> Quản lý Phòng</a></li>
                                    <li class="nav-item"><a class="nav-link active"
                                            href="${pageContext.request.contextPath}/admin/bookings"><i
                                                class="bi bi-calendar-check"></i> Quản lý Đặt phòng</a></li>
                                    <li class="nav-item"><a class="nav-link" href="#"><i class="bi bi-receipt"></i> Quản
                                            lý Hóa đơn</a></li>
                                </ul>
                            </div>
                        </nav>
                        <!-- Main Content -->
                        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
                            <div
                                class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                                <h1 class="h2"><i class="bi bi-calendar-check me-2 text-warning"></i>Quản lý Đặt phòng
                                </h1>
                            </div>
                            <!-- Flash Messages -->
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger alert-dismissible fade show" style="border-radius:10px;"
                                    role="alert">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>
                            <c:if test="${not empty message}">
                                <div class="alert alert-success alert-dismissible fade show" style="border-radius:10px;"
                                    role="alert">
                                    <i class="bi bi-check-circle-fill me-2"></i>${message}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>
                            <!-- Summary Stats -->
                            <div class="row g-3 mb-4">
                                <div class="col-sm-6 col-lg-3">
                                    <div class="stat-card" style="background: linear-gradient(135deg,#667eea,#764ba2);">
                                        <div class="stat-number" id="totalCount">0</div>
                                        <div class="stat-label"><i class="bi bi-list-ul me-1"></i>Tổng đặt phòng</div>
                                    </div>
                                </div>
                                <div class="col-sm-6 col-lg-3">
                                    <div class="stat-card" style="background: linear-gradient(135deg,#f093fb,#f5576c);">
                                        <div class="stat-number" id="pendingCount">0</div>
                                        <div class="stat-label"><i class="bi bi-hourglass-split me-1"></i>Chờ xác nhận
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6 col-lg-3">
                                    <div class="stat-card" style="background: linear-gradient(135deg,#4facfe,#00f2fe);">
                                        <div class="stat-number" id="confirmedCount">0</div>
                                        <div class="stat-label"><i class="bi bi-check2-circle me-1"></i>Đã xác nhận
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6 col-lg-3">
                                    <div class="stat-card" style="background: linear-gradient(135deg,#43e97b,#38f9d7);">
                                        <div class="stat-number" id="stayingCount">0</div>
                                        <div class="stat-label"><i class="bi bi-house-door me-1"></i>Đang ở</div>
                                    </div>
                                </div>
                            </div>
                            <!-- Search + Filter Bar -->
                            <div class="card p-3 mb-4">
                                <div class="row g-3 align-items-center">
                                    <div class="col-md-5">
                                        <input type="text" id="searchInput" class="form-control search-box"
                                            placeholder="🔍 Tìm theo mã đặt phòng, khách hàng, email...">
                                    </div>
                                    <div class="col-md-3">
                                        <select id="statusFilter" class="form-select" style="border-radius:8px;">
                                            <option value="">-- Tất cả trạng thái --</option>
                                            <c:forEach var="s" items="${validStatuses}">
                                                <option value="${s}">${s}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <button class="btn btn-outline-secondary w-100" onclick="clearFilters()">
                                            <i class="bi bi-x-circle me-1"></i>Xóa lọc
                                        </button>
                                    </div>
                                    <div class="col-md-2 text-end">
                                        <span class="text-muted small" id="resultCount"></span>
                                    </div>
                                </div>
                            </div>
                            <!-- Booking Table -->
                            <div class="card">
                                <div class="card-body p-0">
                                    <div class="table-responsive">
                                        <table class="table table-hover align-middle mb-0" id="bookingTable">
                                            <thead>
                                                <tr>
                                                    <th>Mã ĐP</th>
                                                    <th>Khách hàng</th>
                                                    <th>Nhận phòng</th>
                                                    <th>Trả phòng</th>
                                                    <th>Người lớn</th>
                                                    <th>Tổng tiền</th>
                                                    <th>Trạng thái</th>
                                                    <th style="width:180px;">Cập nhật trạng thái</th>
                                                    <th style="width:80px; text-align:center;">Chi tiết</th>
                                                </tr>
                                            </thead>
                                            <tbody id="bookingTableBody">
                                                <c:forEach var="bk" items="${bookingList}">
                                                    <tr data-status="${bk.status}"
                                                        data-search="${bk.bookingCode} ${bk.userFullName} ${bk.userEmail}">
                                                        <td>
                                                            <strong class="text-primary">${bk.bookingCode}</strong>
                                                            <br><small class="text-muted">#${bk.bookingId}</small>
                                                        </td>
                                                        <td>
                                                            <strong>${bk.userFullName}</strong>
                                                            <br><small class="text-muted">${bk.userEmail}</small>
                                                        </td>
                                                        <td>
                                                            <fmt:formatDate value="${bk.checkIn}"
                                                                pattern="dd/MM/yyyy" />
                                                        </td>
                                                        <td>
                                                            <fmt:formatDate value="${bk.checkOut}"
                                                                pattern="dd/MM/yyyy" />
                                                        </td>
                                                        <td class="text-center">${bk.adult}<c:if
                                                                test="${bk.children > 0}"> + ${bk.children} trẻ</c:if>
                                                        </td>
                                                        <td>
                                                            <strong class="text-success">
                                                                <fmt:formatNumber value="${bk.totalAmount}"
                                                                    type="currency" currencySymbol="đ"
                                                                    maxFractionDigits="0" />
                                                            </strong>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${bk.status == 'Chờ xác nhận'}"><span
                                                                        class="badge-pending"><i
                                                                            class="bi bi-hourglass-split me-1"></i>${bk.status}</span>
                                                                </c:when>
                                                                <c:when test="${bk.status == 'Đã xác nhận'}"><span
                                                                        class="badge-confirmed"><i
                                                                            class="bi bi-check2 me-1"></i>${bk.status}</span>
                                                                </c:when>
                                                                <c:when test="${bk.status == 'Đang ở'}"><span
                                                                        class="badge-staying"><i
                                                                            class="bi bi-house-door me-1"></i>${bk.status}</span>
                                                                </c:when>
                                                                <c:when test="${bk.status == 'Đã trả phòng'}"><span
                                                                        class="badge-checkedout"><i
                                                                            class="bi bi-box-arrow-right me-1"></i>${bk.status}</span>
                                                                </c:when>
                                                                <c:when test="${bk.status == 'Đã hủy'}"><span
                                                                        class="badge-cancelled"><i
                                                                            class="bi bi-x-circle me-1"></i>${bk.status}</span>
                                                                </c:when>
                                                                <c:otherwise><span
                                                                        class="badge bg-secondary">${bk.status}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <form method="POST"
                                                                action="${pageContext.request.contextPath}/admin/bookings"
                                                                class="d-flex gap-1"
                                                                onsubmit="return confirmStatusChange(this)">
                                                                <input type="hidden" name="subAction"
                                                                    value="updateStatus">
                                                                <input type="hidden" name="bookingId"
                                                                    value="${bk.bookingId}">
                                                                <input type="hidden" name="redirect" value="list">
                                                                <select name="status" class="form-select form-select-sm"
                                                                    style="font-size:0.78rem;">
                                                                    <c:forEach var="s" items="${validStatuses}">
                                                                        <option value="${s}" ${bk.status==s ? 'selected'
                                                                            : '' }>${s}</option>
                                                                    </c:forEach>
                                                                </select>
                                                                <button type="submit" class="btn btn-sm btn-primary"
                                                                    title="Lưu">
                                                                    <i class="bi bi-check-lg"></i>
                                                                </button>
                                                            </form>
                                                        </td>
                                                        <td class="text-center">
                                                            <a href="${pageContext.request.contextPath}/admin/bookings?action=detail&id=${bk.bookingId}"
                                                                class="btn btn-sm btn-outline-primary"
                                                                title="Xem chi tiết">
                                                                <i class="bi bi-eye"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                <c:if test="${empty bookingList}">
                                                    <tr>
                                                        <td colspan="9" class="text-center py-5 text-muted">
                                                            <i class="bi bi-calendar-x"
                                                                style="font-size:2rem;display:block;margin-bottom:10px;"></i>
                                                            Chưa có đặt phòng nào.
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </main>
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    const rows = Array.from(document.querySelectorAll('#bookingTableBody tr[data-status]'));
                    // === Stats ===
                    function updateStats() {
                        const visible = rows.filter(r => r.style.display !== 'none');
                        document.getElementById('totalCount').textContent = visible.length;
                        document.getElementById('pendingCount').textContent = visible.filter(r => r.dataset.status === 'Chờ xác nhận').length;
                        document.getElementById('confirmedCount').textContent = visible.filter(r => r.dataset.status === 'Đã xác nhận').length;
                        document.getElementById('stayingCount').textContent = visible.filter(r => r.dataset.status === 'Đang ở').length;
                        document.getElementById('resultCount').textContent = `Hiển thị ${visible.length} / ${rows.length} kết quả`;
                    }
                    // === Search + Filter ===
                    function applyFilters() {
                        const q = document.getElementById('searchInput').value.toLowerCase().trim();
                        const s = document.getElementById('statusFilter').value;
                        rows.forEach(row => {
                            const text = (row.dataset.search || '').toLowerCase();
                            const status = row.dataset.status || '';
                            const matchQ = !q || text.includes(q);
                            const matchS = !s || status === s;
                            row.style.display = (matchQ && matchS) ? '' : 'none';
                        });
                        updateStats();
                    }
                    document.getElementById('searchInput').addEventListener('input', applyFilters);
                    document.getElementById('statusFilter').addEventListener('change', applyFilters);
                    function clearFilters() {
                        document.getElementById('searchInput').value = '';
                        document.getElementById('statusFilter').value = '';
                        applyFilters();
                    }
                    function confirmStatusChange(form) {
                        const sel = form.querySelector('select[name="status"]');
                        return confirm(`Bạn có chắc muốn đổi trạng thái thành "${sel.value}"?`);
                    }
                    // Init stats on load
                    updateStats();
                </script>
            </body>

            </html>