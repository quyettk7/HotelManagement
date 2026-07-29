<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Chi tiết Đặt phòng ${booking.bookingCode} | Luxury Hotel</title>
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

                    .info-label {
                        font-size: 0.8rem;
                        color: #6c757d;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                        margin-bottom: 4px;
                    }

                    .info-value {
                        font-size: 1rem;
                        font-weight: 500;
                        color: #212529;
                    }

                    .timeline-bar {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        border-radius: 12px;
                        padding: 20px 25px;
                        color: white;
                        margin-bottom: 24px;
                    }

                    .timeline-bar .date-block {
                        text-align: center;
                    }

                    .timeline-bar .date-block .date {
                        font-size: 1.5rem;
                        font-weight: 700;
                    }

                    .timeline-bar .date-block .label {
                        font-size: 0.75rem;
                        opacity: 0.85;
                    }

                    .timeline-bar .arrow {
                        flex: 1;
                        text-align: center;
                        font-size: 1.5rem;
                        opacity: 0.7;
                    }

                    .status-badge-lg {
                        font-size: 0.9rem;
                        padding: 8px 18px;
                        border-radius: 20px;
                    }

                    /* Table */
                    .table thead th {
                        background-color: #212529;
                        color: #fff;
                        border: none;
                        padding: 12px;
                        font-size: 0.82rem;
                        text-transform: uppercase;
                    }

                    /* Edit form section */
                    .section-header {
                        font-size: 0.8rem;
                        color: #6c757d;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                        border-bottom: 2px solid #f0f0f0;
                        padding-bottom: 8px;
                        margin-bottom: 16px;
                    }
                </style>
            </head>

            <body>
                <!-- Navigation Bar -->
                <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="#"><i class="bi bi-houses-fill me-2"></i>LUXURY HOTEL</a>
                        <div class="collapse navbar-collapse justify-content-end">
                            <ul class="navbar-nav align-items-center">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle text-light" href="#" role="button"
                                        data-bs-toggle="dropdown">
                                        <i class="bi bi-person-circle me-1"></i>${sessionScope.currentUser.fullName}
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
                            <!-- Breadcrumb + Back -->
                            <div class="d-flex align-items-center gap-3 pt-3 pb-2 mb-3 border-bottom">
                                <a href="${pageContext.request.contextPath}/admin/bookings"
                                    class="btn btn-outline-secondary btn-sm">
                                    <i class="bi bi-arrow-left me-1"></i>Danh sách
                                </a>
                                <h1 class="h4 mb-0"><i class="bi bi-calendar-check me-2 text-warning"></i>
                                    Chi tiết Đặt phòng — <strong>${booking.bookingCode}</strong>
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
                            <!-- Timeline bar: check-in → check-out -->
                            <div class="timeline-bar">
                                <div class="date-block">
                                    <div class="label"><i class="bi bi-box-arrow-in-down-right me-1"></i>NHẬN PHÒNG
                                    </div>
                                    <div class="date">
                                        <fmt:formatDate value="${booking.checkIn}" pattern="dd/MM/yyyy" />
                                    </div>
                                </div>
                                <div class="arrow">
                                    <i class="bi bi-arrow-right-circle-fill" style="font-size:2rem;"></i>
                                    <div style="font-size:0.75rem; margin-top:4px;">
                                        <%-- Calculate nights via EL not possible; shown statically --%>
                                            Khoảng thời gian lưu trú
                                    </div>
                                </div>
                                <div class="date-block">
                                    <div class="label"><i class="bi bi-box-arrow-up-right me-1"></i>TRẢ PHÒNG</div>
                                    <div class="date">
                                        <fmt:formatDate value="${booking.checkOut}" pattern="dd/MM/yyyy" />
                                    </div>
                                </div>
                                <div class="ms-auto text-end">
                                    <div class="label">TỔNG TIỀN</div>
                                    <div class="date" style="color:#ffd700;">
                                        <fmt:formatNumber value="${booking.totalAmount}" type="currency"
                                            currencySymbol="đ" maxFractionDigits="0" />
                                    </div>
                                </div>
                            </div>
                            <div class="row g-4">
                                <!-- LEFT: Info + Rooms -->
                                <div class="col-lg-7">
                                    <!-- Booking Info Card -->
                                    <div class="card p-4 mb-4">
                                        <div class="section-header"><i class="bi bi-info-circle me-2"></i>Thông tin Đặt
                                            phòng</div>
                                        <div class="row g-3">
                                            <div class="col-6">
                                                <div class="info-label">Mã đặt phòng</div>
                                                <div class="info-value text-primary fw-bold">${booking.bookingCode}
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="info-label">Ngày đặt</div>
                                                <div class="info-value">
                                                    <fmt:formatDate value="${booking.bookingDate}"
                                                        pattern="dd/MM/yyyy HH:mm" />
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="info-label">Khách hàng</div>
                                                <div class="info-value">${booking.userFullName}</div>
                                                <div class="text-muted small">${booking.userEmail}</div>
                                                <div class="text-muted small">${booking.userPhone}</div>
                                            </div>
                                            <div class="col-6">
                                                <div class="info-label">Số người</div>
                                                <div class="info-value">
                                                    <i class="bi bi-person-fill me-1"></i>${booking.adult} người lớn
                                                    <c:if test="${booking.children > 0}">
                                                        + <i class="bi bi-person-fill me-1"></i>${booking.children} trẻ
                                                        em
                                                    </c:if>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="info-label">Voucher</div>
                                                <div class="info-value">
                                                    <c:choose>
                                                        <c:when test="${not empty booking.voucherCode}">
                                                            <span class="badge bg-warning text-dark"><i
                                                                    class="bi bi-tag-fill me-1"></i>${booking.voucherCode}</span>
                                                        </c:when>
                                                        <c:otherwise><span class="text-muted">Không có</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="info-label">Trạng thái hiện tại</div>
                                                <div class="info-value">
                                                    <c:choose>
                                                        <c:when test="${booking.status == 'Chờ xác nhận'}"><span
                                                                class="badge bg-warning text-dark status-badge-lg">${booking.status}</span>
                                                        </c:when>
                                                        <c:when test="${booking.status == 'Đã xác nhận'}"><span
                                                                class="badge bg-primary status-badge-lg">${booking.status}</span>
                                                        </c:when>
                                                        <c:when test="${booking.status == 'Đang ở'}"><span
                                                                class="badge bg-success status-badge-lg">${booking.status}</span>
                                                        </c:when>
                                                        <c:when test="${booking.status == 'Đã trả phòng'}"><span
                                                                class="badge bg-secondary status-badge-lg">${booking.status}</span>
                                                        </c:when>
                                                        <c:when test="${booking.status == 'Đã hủy'}"><span
                                                                class="badge bg-danger status-badge-lg">${booking.status}</span>
                                                        </c:when>
                                                        <c:otherwise><span
                                                                class="badge bg-secondary status-badge-lg">${booking.status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            <c:if test="${not empty booking.note}">
                                                <div class="col-12">
                                                    <div class="info-label">Ghi chú</div>
                                                    <div class="info-value">${booking.note}</div>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                    <!-- Room Details Card -->
                                    <div class="card p-4">
                                        <div class="section-header"><i class="bi bi-door-closed me-2"></i>Chi tiết Phòng
                                            đặt</div>
                                        <c:choose>
                                            <c:when test="${not empty details}">
                                                <div class="table-responsive">
                                                    <table class="table table-hover align-middle mb-0">
                                                        <thead>
                                                            <tr>
                                                                <th>Phòng</th>
                                                                <th>Loại</th>
                                                                <th>Đơn giá</th>
                                                                <th>Số lượng</th>
                                                                <th>Thành tiền</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="d" items="${details}">
                                                                <tr>
                                                                    <td>
                                                                        <strong>${d.roomNumber}</strong>
                                                                        <br><small
                                                                            class="text-muted">${d.roomName}</small>
                                                                    </td>
                                                                    <td><span
                                                                            class="badge bg-light text-dark">${d.categoryName}</span>
                                                                    </td>
                                                                    <td>
                                                                        <fmt:formatNumber value="${d.price}"
                                                                            type="currency" currencySymbol="đ"
                                                                            maxFractionDigits="0" />
                                                                    </td>
                                                                    <td class="text-center">${d.quantity}</td>
                                                                    <td>
                                                                        <strong class="text-success">
                                                                            <fmt:formatNumber value="${d.total}"
                                                                                type="currency" currencySymbol="đ"
                                                                                maxFractionDigits="0" />
                                                                        </strong>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                        <tfoot>
                                                            <tr class="table-dark">
                                                                <td colspan="4" class="text-end fw-bold">Tổng cộng:</td>
                                                                <td class="fw-bold text-warning">
                                                                    <fmt:formatNumber value="${booking.totalAmount}"
                                                                        type="currency" currencySymbol="đ"
                                                                        maxFractionDigits="0" />
                                                                </td>
                                                            </tr>
                                                        </tfoot>
                                                    </table>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <p class="text-muted text-center py-3"><i
                                                        class="bi bi-inbox me-2"></i>Chưa có thông tin phòng chi tiết.
                                                </p>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <!-- RIGHT: Actions -->
                                <div class="col-lg-5">
                                    <!-- Quick Status Update -->
                                    <div class="card p-4 mb-4">
                                        <div class="section-header"><i class="bi bi-arrow-repeat me-2"></i>Cập nhật
                                            Trạng thái</div>
                                        <form method="POST" action="${pageContext.request.contextPath}/admin/bookings"
                                            onsubmit="return confirm('Xác nhận đổi trạng thái?')">
                                            <input type="hidden" name="subAction" value="updateStatus">
                                            <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                            <input type="hidden" name="redirect" value="detail">
                                            <div class="mb-3">
                                                <label class="form-label fw-semibold">Trạng thái mới</label>
                                                <select name="status" class="form-select">
                                                    <c:forEach var="s" items="${validStatuses}">
                                                        <option value="${s}" ${booking.status==s ? 'selected' : '' }>
                                                            ${s}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="d-grid">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="bi bi-save me-2"></i>Lưu trạng thái
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                    <!-- Edit Booking Info -->
                                    <div class="card p-4 mb-4">
                                        <div class="section-header"><i class="bi bi-pencil-square me-2"></i>Chỉnh sửa
                                            Thông tin</div>
                                        <form method="POST" action="${pageContext.request.contextPath}/admin/bookings">
                                            <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                            <input type="hidden" name="userId" value="${booking.userId}">
                                            <div class="mb-3">
                                                <label class="form-label">Ngày nhận phòng <span
                                                        class="text-danger">*</span></label>
                                                <input type="date" class="form-control" name="checkIn"
                                                    value="<fmt:formatDate value='${booking.checkIn}' pattern='yyyy-MM-dd'/>"
                                                    required>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Ngày trả phòng <span
                                                        class="text-danger">*</span></label>
                                                <input type="date" class="form-control" name="checkOut"
                                                    value="<fmt:formatDate value='${booking.checkOut}' pattern='yyyy-MM-dd'/>"
                                                    required>
                                            </div>
                                            <div class="row g-2 mb-3">
                                                <div class="col-6">
                                                    <label class="form-label">Người lớn <span
                                                            class="text-danger">*</span></label>
                                                    <input type="number" class="form-control" name="adult" min="1"
                                                        value="${booking.adult}" required>
                                                </div>
                                                <div class="col-6">
                                                    <label class="form-label">Trẻ em</label>
                                                    <input type="number" class="form-control" name="children" min="0"
                                                        value="${booking.children}">
                                                </div>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Tổng tiền (đ)</label>
                                                <input type="number" class="form-control" name="totalAmount" min="0"
                                                    step="1000" value="${booking.totalAmount}">
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Trạng thái</label>
                                                <select class="form-select" name="status">
                                                    <c:forEach var="s" items="${validStatuses}">
                                                        <option value="${s}" ${booking.status==s ? 'selected' : '' }>
                                                            ${s}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Ghi chú</label>
                                                <textarea class="form-control" name="note"
                                                    rows="2">${booking.note}</textarea>
                                            </div>
                                            <div class="d-grid">
                                                <button type="submit" class="btn btn-outline-primary">
                                                    <i class="bi bi-pencil me-2"></i>Cập nhật thông tin
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                    <!-- Danger Zone: Delete -->
                                    <div class="card p-4 border border-danger border-opacity-25">
                                        <div class="section-header text-danger"><i
                                                class="bi bi-exclamation-triangle me-2"></i>Vùng nguy hiểm</div>
                                        <p class="text-muted small">Xóa đặt phòng sẽ xóa cả tất cả chi tiết phòng liên
                                            kết. Thao tác này không thể hoàn tác.</p>
                                        <a href="${pageContext.request.contextPath}/admin/bookings?action=delete&id=${booking.bookingId}"
                                            class="btn btn-outline-danger w-100"
                                            onclick="return confirm('Bạn có chắc chắn muốn XÓA đặt phòng ${booking.bookingCode}? Thao tác này không thể hoàn tác!')">
                                            <i class="bi bi-trash me-2"></i>Xóa đặt phòng này
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </main>
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    // Date validation: checkOut must be after checkIn
                    const checkInInput = document.querySelector('input[name="checkIn"]');
                    const checkOutInput = document.querySelector('input[name="checkOut"]');
                    if (checkInInput && checkOutInput) {
                        function validateDates() {
                            if (checkInInput.value && checkOutInput.value) {
                                if (checkOutInput.value <= checkInInput.value) {
                                    checkOutInput.setCustomValidity('Ngày trả phòng phải sau ngày nhận phòng');
                                } else {
                                    checkOutInput.setCustomValidity('');
                                }
                            }
                        }
                        checkInInput.addEventListener('change', validateDates);
                        checkOutInput.addEventListener('change', validateDates);
                    }
                </script>
            </body>

            </html>