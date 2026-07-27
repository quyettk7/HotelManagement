<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập | Luxury Hotel Management System</title>
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
            --card-bg: rgba(26, 26, 26, 0.75);
            --text-light: #F3F4F6;
            --text-muted: #9CA3AF;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(rgba(18, 18, 18, 0.6), rgba(18, 18, 18, 0.8)), 
                        url('https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1920&q=80') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-light);
            margin: 0;
            overflow-x: hidden;
        }

        .login-container {
            width: 100%;
            max-width: 480px;
            padding: 20px;
        }

        .login-card {
            background: var(--card-bg);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);
            padding: 40px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px 0 rgba(212, 175, 55, 0.15);
        }

        .brand-logo {
            text-align: center;
            margin-bottom: 30px;
        }

        .brand-logo i {
            font-size: 3rem;
            color: var(--primary-gold);
            filter: drop-shadow(0 0 10px rgba(212, 175, 55, 0.3));
        }

        .hotel-title {
            font-family: 'Playfair Display', serif;
            font-weight: 700;
            letter-spacing: 1px;
            color: var(--text-light);
            margin-top: 10px;
        }

        .hotel-subtitle {
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 3px;
            color: var(--primary-gold);
            font-weight: 500;
        }

        .form-label {
            font-weight: 500;
            font-size: 0.9rem;
            color: var(--text-light);
            margin-bottom: 8px;
        }

        .input-group-text {
            background-color: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: var(--text-muted);
            border-radius: 10px 0 0 10px;
        }

        .form-control {
            background-color: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: var(--text-light);
            border-radius: 0 10px 10px 0;
            padding: 12px 16px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            background-color: rgba(255, 255, 255, 0.08);
            border-color: var(--primary-gold);
            box-shadow: 0 0 0 0.25rem rgba(212, 175, 55, 0.25);
            color: var(--text-light);
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.3);
        }

        .form-control:focus + .input-group-text {
            border-color: var(--primary-gold);
        }

        .btn-login {
            background: linear-gradient(135deg, var(--primary-gold) 0%, var(--primary-gold-hover) 100%);
            border: none;
            color: #000;
            font-weight: 600;
            padding: 12px;
            border-radius: 10px;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            text-transform: uppercase;
            box-shadow: 0 4px 15px rgba(212, 175, 55, 0.2);
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(212, 175, 55, 0.4);
            background: linear-gradient(135deg, #e5be49 0%, #bd8c18 100%);
            color: #000;
        }

        .btn-login:active {
            transform: translateY(0);
        }

        .error-alert {
            background-color: rgba(220, 53, 69, 0.2);
            border: 1px solid rgba(220, 53, 69, 0.4);
            color: #f8d7da;
            border-radius: 10px;
            font-size: 0.9rem;
            padding: 12px 16px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .error-alert i {
            font-size: 1.1rem;
        }

        .footer-text {
            text-align: center;
            margin-top: 25px;
            font-size: 0.85rem;
            color: var(--text-muted);
        }

        .footer-text a {
            color: var(--primary-gold);
            text-decoration: none;
            transition: color 0.2s ease;
        }

        .footer-text a:hover {
            color: #fff;
            text-decoration: underline;
        }

        /* Show/Hide password toggle */
        .password-toggle {
            cursor: pointer;
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            z-index: 10;
            color: var(--text-muted);
            transition: color 0.2s ease;
        }

        .password-toggle:hover {
            color: var(--text-light);
        }

        .password-container {
            position: relative;
        }
    </style>
</head>
<body>

<div class="login-container">
    <div class="login-card">
        <div class="brand-logo">
            <i class="bi bi-houses-fill"></i>
            <h1 class="hotel-title">LUXURY HOTEL</h1>
            <p class="hotel-subtitle">Hệ thống quản lý</p>
        </div>

        <!-- Server-side Error Message -->
        <c:if test="${not empty error}">
            <div class="error-alert">
                <i class="bi bi-exclamation-triangle-fill"></i>
                <div>${error}</div>
            </div>
        </c:if>

        <!-- Client-side Error Alert Container -->
        <div id="js-error-alert" class="error-alert d-none">
            <i class="bi bi-exclamation-triangle-fill"></i>
            <div id="js-error-message"></div>
        </div>

        <form id="loginForm" action="${pageContext.request.contextPath}/login" method="POST" novalidate>
            <div class="mb-4">
                <label for="email" class="form-label">Email</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                    <input type="email" class="form-control" id="email" name="email" 
                           placeholder="name@hotel.com" value="${email}" required>
                </div>
            </div>

            <div class="mb-4">
                <label for="password" class="form-label">Mật khẩu</label>
                <div class="input-group password-container">
                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                    <input type="password" class="form-control" id="password" name="password" 
                           placeholder="••••••••" style="border-radius: 0 10px 10px 0; padding-right: 45px;" required>
                    <i class="bi bi-eye password-toggle" id="togglePassword"></i>
                </div>
            </div>

            <div class="d-grid gap-2 mt-4">
                <button class="btn btn-login btn-block" type="submit">
                    Đăng nhập <i class="bi bi-arrow-right-short"></i>
                </button>
            </div>
        </form>

        <div class="footer-text">
            <p>&copy; 2026 Luxury Hotel. All rights reserved.</p>
            <p><a href="#">Quên mật khẩu?</a> | Trợ giúp: <a href="tel:02263888888">02263888888</a></p>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Toggle Password Visibility
    const togglePassword = document.querySelector('#togglePassword');
    const password = document.querySelector('#password');

    togglePassword.addEventListener('click', function () {
        const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
        password.setAttribute('type', type);
        this.classList.toggle('bi-eye');
        this.classList.toggle('bi-eye-slash');
    });

    // Client-side Validation
    const loginForm = document.getElementById('loginForm');
    const jsErrorAlert = document.getElementById('js-error-alert');
    const jsErrorMessage = document.getElementById('js-error-message');

    loginForm.addEventListener('submit', function (event) {
        let emailVal = document.getElementById('email').value.trim();
        let passwordVal = document.getElementById('password').value.trim();
        let errorMsg = '';

        // Hide server-side error if exists
        const serverError = document.querySelector('.error-alert:not(#js-error-alert)');
        if (serverError) {
            serverError.classList.add('d-none');
        }

        // Validate
        if (emailVal === '') {
            errorMsg = 'Email không được để trống.';
        } else if (!validateEmail(emailVal)) {
            errorMsg = 'Định dạng email không hợp lệ.';
        } else if (passwordVal === '') {
            errorMsg = 'Mật khẩu không được để trống.';
        }

        if (errorMsg !== '') {
            event.preventDefault(); // Prevent form submission
            jsErrorMessage.textContent = errorMsg;
            jsErrorAlert.classList.remove('d-none');
            // Shake effect on card
            const card = document.querySelector('.login-card');
            card.style.animation = 'shake 0.4s ease';
            setTimeout(() => { card.style.animation = ''; }, 400);
        } else {
            jsErrorAlert.classList.add('d-none');
        }
    });

    function validateEmail(email) {
        const re = /^[A-Za-z0-9+_.-]+@(.+)$/;
        return re.test(email);
    }
</script>

<!-- CSS Animation for shaking login card -->
<style>
    @keyframes shake {
        0%, 100% { transform: translateX(0) translateY(-5px); }
        25% { transform: translateX(-6px) translateY(-5px); }
        75% { transform: translateX(6px) translateY(-5px); }
    }
</style>
</body>
</html>
