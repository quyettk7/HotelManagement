package com.hotel.servlet;

import com.hotel.entity.RoomCategory;
import com.hotel.service.RoomCategoryService;
import com.hotel.service.impl.RoomCategoryServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/room-categories")
public class AdminRoomCategoryServlet extends HttpServlet {

    private final RoomCategoryService categoryService = new RoomCategoryServiceImpl();

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
                deleteCategory(request, response);
                break;
            case "list":
            default:
                listCategories(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("categoryId");
        String categoryName = request.getParameter("categoryName");
        String description = request.getParameter("description");
        String basePriceStr = request.getParameter("basePrice");
        String maxPeopleStr = request.getParameter("maxPeople");
        String statusStr = request.getParameter("status");

        if (categoryName != null) categoryName = categoryName.trim();
        if (description != null) description = description.trim();

        // Validation
        if (categoryName == null || categoryName.isEmpty() ||
            basePriceStr == null || basePriceStr.isEmpty() ||
            maxPeopleStr == null || maxPeopleStr.isEmpty()) {
            
            request.setAttribute("error", "Vui lòng nhập đầy đủ các trường bắt buộc.");
            listCategories(request, response);
            return;
        }

        double basePrice;
        int maxPeople;
        try {
            basePrice = Double.parseDouble(basePriceStr);
            maxPeople = Integer.parseInt(maxPeopleStr);
            if (basePrice < 0 || maxPeople <= 0) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Giá phòng hoặc Số người tối đa không hợp lệ.");
            listCategories(request, response);
            return;
        }

        boolean status = "1".equals(statusStr) || "true".equalsIgnoreCase(statusStr);
        int categoryId = 0;
        if (idStr != null && !idStr.isEmpty()) {
            categoryId = Integer.parseInt(idStr);
        }

        RoomCategory category = new RoomCategory(categoryId, categoryName, description, basePrice, maxPeople, status, null);
        boolean success;

        if (categoryId == 0) {
            success = categoryService.createCategory(category);
            if (success) {
                request.getSession().setAttribute("message", "Thêm danh mục phòng mới thành công.");
            } else {
                request.getSession().setAttribute("error", "Thêm danh mục phòng thất bại. Tên danh mục có thể đã tồn tại.");
            }
        } else {
            success = categoryService.updateCategory(category);
            if (success) {
                request.getSession().setAttribute("message", "Cập nhật danh mục phòng thành công.");
            } else {
                request.getSession().setAttribute("error", "Cập nhật danh mục phòng thất bại.");
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/room-categories");
    }

    private void listCategories(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<RoomCategory> list = categoryService.getAllCategories();
        request.setAttribute("categoryList", list);
        request.getRequestDispatcher("/admin/room-category-list.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            RoomCategory category = categoryService.getCategoryById(id);
            if (category != null) {
                request.setAttribute("category", category);
            }
        }
        listCategories(request, response);
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            boolean success = categoryService.deleteCategory(id);
            if (success) {
                request.getSession().setAttribute("message", "Xóa danh mục phòng thành công.");
            } else {
                request.getSession().setAttribute("error", "Không thể xóa danh mục phòng này do có các phòng đang liên kết.");
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/room-categories");
    }
}
