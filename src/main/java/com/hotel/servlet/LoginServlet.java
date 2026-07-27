package com.hotel.servlet;

import com.hotel.entity.User;
import com.hotel.service.UserService;
import com.hotel.service.impl.UserServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the login page
        request.getRequestDispatcher("/common/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate input data
        if (email != null) {
            email = email.trim();
        }
        if (password != null) {
            password = password.trim();
        }

        if (email == null || email.isEmpty()) {
            request.setAttribute("error", "Email không được để trống.");
            request.getRequestDispatcher("/common/login.jsp").forward(request, response);
            return;
        }

        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("error", "Định dạng email không hợp lệ.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/common/login.jsp").forward(request, response);
            return;
        }

        if (password == null || password.isEmpty()) {
            request.setAttribute("error", "Mật khẩu không được để trống.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/common/login.jsp").forward(request, response);
            return;
        }

        // Authenticate user
        User user = userService.login(email, password);

        if (user == null) {
            request.setAttribute("error", "Email hoặc mật khẩu không chính xác.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/common/login.jsp").forward(request, response);
            return;
        }

        // Check account status
        if (!user.isStatus()) {
            request.setAttribute("error", "Tài khoản của bạn đã bị khóa.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/common/login.jsp").forward(request, response);
            return;
        }

        // Authentication successful, store user in session
        HttpSession session = request.getSession();
        session.setAttribute("currentUser", user);

        // Redirect based on role
        String roleName = user.getRoleName();
        if (roleName != null && (roleName.equalsIgnoreCase("Admin") || 
                                 roleName.equalsIgnoreCase("Manager") || 
                                 roleName.equalsIgnoreCase("Staff"))) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}
