package com.hotel.servlet;

import com.hotel.entity.Role;
import com.hotel.entity.User;
import com.hotel.service.RoleService;
import com.hotel.service.UserService;
import com.hotel.service.impl.RoleServiceImpl;
import com.hotel.service.impl.UserServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

    private final UserService userService = new UserServiceImpl();
    private final RoleService roleService = new RoleServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteUser(request, response);
                break;
            case "list":
            default:
                listUsers(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userIdStr = request.getParameter("userId");
        String roleIdStr = request.getParameter("roleId");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String genderStr = request.getParameter("gender");
        String dateOfBirthStr = request.getParameter("dateOfBirth");
        String cccd = request.getParameter("cccd");
        String address = request.getParameter("address");
        String nationality = request.getParameter("nationality");
        String statusStr = request.getParameter("status");

        // Trim values
        if (fullName != null) fullName = fullName.trim();
        if (email != null) email = email.trim();
        if (phone != null) phone = phone.trim();
        if (password != null) password = password.trim();
        if (cccd != null) cccd = cccd.trim();
        if (address != null) address = address.trim();
        if (nationality != null) nationality = nationality.trim();

        // Validation
        if (fullName == null || fullName.isEmpty() ||
            email == null || email.isEmpty() ||
            roleIdStr == null || roleIdStr.isEmpty()) {
            
            request.setAttribute("error", "Vui lòng nhập đầy đủ các trường bắt buộc (Họ tên, Email, Vai trò).");
            prepareFormLists(request);
            request.getRequestDispatcher("/admin/user-form.jsp").forward(request, response);
            return;
        }

        int userId = 0;
        if (userIdStr != null && !userIdStr.isEmpty()) {
            userId = Integer.parseInt(userIdStr);
        }

        // For new users, password is required
        if (userId == 0 && (password == null || password.isEmpty())) {
            request.setAttribute("error", "Mật khẩu là bắt buộc khi tạo người dùng mới.");
            prepareFormLists(request);
            request.getRequestDispatcher("/admin/user-form.jsp").forward(request, response);
            return;
        }

        int roleId = Integer.parseInt(roleIdStr);
        Boolean gender = null;
        if (genderStr != null && !genderStr.isEmpty()) {
            gender = "1".equals(genderStr) || "true".equalsIgnoreCase(genderStr);
        }

        Date dateOfBirth = null;
        if (dateOfBirthStr != null && !dateOfBirthStr.isEmpty()) {
            try {
                dateOfBirth = Date.valueOf(dateOfBirthStr);
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Định dạng ngày sinh không hợp lệ (phải là YYYY-MM-DD).");
                prepareFormLists(request);
                request.getRequestDispatcher("/admin/user-form.jsp").forward(request, response);
                return;
            }
        }

        boolean status = "1".equals(statusStr) || "true".equalsIgnoreCase(statusStr);

        User user;
        if (userId != 0) {
            // Update mode: if password field is empty, preserve the old password
            User oldUser = userService.getUserById(userId);
            if (oldUser == null) {
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }
            if (password == null || password.isEmpty()) {
                password = oldUser.getPassword();
            }
            user = new User(userId, roleId, fullName, email, phone, password, gender, dateOfBirth, cccd, address, nationality, status, oldUser.getCreatedAt(), null);
        } else {
            // Insert mode
            user = new User(0, roleId, fullName, email, phone, password, gender, dateOfBirth, cccd, address, nationality, status, null, null);
        }

        boolean success;
        if (userId == 0) {
            success = userService.createUser(user);
            if (success) {
                request.getSession().setAttribute("message", "Thêm người dùng mới thành công.");
            } else {
                request.getSession().setAttribute("error", "Thêm người dùng thất bại. Email, Số điện thoại hoặc CCCD có thể đã tồn tại.");
            }
        } else {
            success = userService.updateUser(user);
            if (success) {
                request.getSession().setAttribute("message", "Cập nhật người dùng thành công.");
            } else {
                request.getSession().setAttribute("error", "Cập nhật người dùng thất bại. Email, Số điện thoại hoặc CCCD có thể bị trùng lặp.");
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> list = userService.getAllUsers();
        request.setAttribute("userList", list);
        request.getRequestDispatcher("/admin/user-list.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        prepareFormLists(request);
        request.getRequestDispatcher("/admin/user-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            User user = userService.getUserById(id);
            if (user != null) {
                request.setAttribute("user", user);
            }
        }
        prepareFormLists(request);
        request.getRequestDispatcher("/admin/user-form.jsp").forward(request, response);
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            // Protect current logged-in user from self-deletion
            User currentUser = (User) request.getSession().getAttribute("currentUser");
            if (currentUser != null && currentUser.getUserId() == id) {
                request.getSession().setAttribute("error", "Bạn không thể tự xóa tài khoản của chính mình!");
            } else {
                boolean success = userService.deleteUser(id);
                if (success) {
                    request.getSession().setAttribute("message", "Xóa người dùng thành công.");
                } else {
                    request.getSession().setAttribute("error", "Không thể xóa người dùng này do có dữ liệu liên kết trong hệ thống.");
                }
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }

    private void prepareFormLists(HttpServletRequest request) {
        List<Role> roleList = roleService.getAllRoles();
        request.setAttribute("roleList", roleList);
    }
}
