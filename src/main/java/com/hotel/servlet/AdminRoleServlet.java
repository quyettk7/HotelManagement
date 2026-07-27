package com.hotel.servlet;

import com.hotel.entity.Role;
import com.hotel.service.RoleService;
import com.hotel.service.impl.RoleServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/roles")
public class AdminRoleServlet extends HttpServlet {

    private final RoleService roleService = new RoleServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteRole(request, response);
                break;
            case "list":
            default:
                listRoles(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("roleId");
        String roleName = request.getParameter("roleName");
        String description = request.getParameter("description");
        String statusStr = request.getParameter("status");

        if (roleName != null) roleName = roleName.trim();
        if (description != null) description = description.trim();

        // Server-side validation
        if (roleName == null || roleName.isEmpty()) {
            request.setAttribute("error", "Tên vai trò không được để trống.");
            listRoles(request, response);
            return;
        }

        boolean status = "1".equals(statusStr) || "true".equalsIgnoreCase(statusStr);
        int roleId = 0;
        if (idStr != null && !idStr.isEmpty()) {
            roleId = Integer.parseInt(idStr);
        }

        Role role = new Role(roleId, roleName, description, status);
        boolean success;

        if (roleId == 0) {
            success = roleService.createRole(role);
            if (!success) {
                request.setAttribute("error", "Không thể thêm vai trò. Tên vai trò có thể đã tồn tại.");
            } else {
                request.setAttribute("message", "Thêm vai trò mới thành công.");
            }
        } else {
            success = roleService.updateRole(role);
            if (!success) {
                request.setAttribute("error", "Không thể cập nhật vai trò.");
            } else {
                request.setAttribute("message", "Cập nhật vai trò thành công.");
            }
        }

        // Return to list
        response.sendRedirect(request.getContextPath() + "/admin/roles");
    }

    private void listRoles(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Role> list = roleService.getAllRoles();
        request.setAttribute("roleList", list);
        request.getRequestDispatcher("/admin/role-list.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            Role role = roleService.getRoleById(id);
            if (role != null) {
                request.setAttribute("role", role);
            }
        }
        listRoles(request, response);
    }

    private void deleteRole(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            boolean success = roleService.deleteRole(id);
            if (!success) {
                request.getSession().setAttribute("error", "Không thể xóa vai trò này do ràng buộc dữ liệu.");
            } else {
                request.getSession().setAttribute("message", "Xóa vai trò thành công.");
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/roles");
    }
}
