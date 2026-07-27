package com.hotel.servlet;

import com.hotel.entity.Room;
import com.hotel.entity.RoomCategory;
import com.hotel.entity.RoomImage;
import com.hotel.service.RoomCategoryService;
import com.hotel.service.RoomService;
import com.hotel.service.impl.RoomCategoryServiceImpl;
import com.hotel.service.impl.RoomServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/rooms")
public class AdminRoomServlet extends HttpServlet {

    private final RoomService roomService = new RoomServiceImpl();
    private final RoomCategoryService categoryService = new RoomCategoryServiceImpl();

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
                deleteRoom(request, response);
                break;
            case "delete-image":
                deleteImage(request, response);
                break;
            case "list":
            default:
                listRooms(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String subAction = request.getParameter("subAction");
        if ("add-image".equals(subAction)) {
            addRoomImage(request, response);
            return;
        }

        String roomIdStr = request.getParameter("roomId");
        String categoryIdStr = request.getParameter("categoryId");
        String roomNumber = request.getParameter("roomNumber");
        String roomName = request.getParameter("roomName");
        String priceStr = request.getParameter("price");
        String acreageStr = request.getParameter("acreage");
        String bedStr = request.getParameter("bed");
        String area = request.getParameter("area");
        String description = request.getParameter("description");
        String statusStr = request.getParameter("status");

        if (roomNumber != null) roomNumber = roomNumber.trim();
        if (roomName != null) roomName = roomName.trim();
        if (area != null) area = area.trim();
        if (description != null) description = description.trim();

        // Validation
        if (roomNumber == null || roomNumber.isEmpty() ||
            categoryIdStr == null || categoryIdStr.isEmpty() ||
            priceStr == null || priceStr.isEmpty()) {
            
            request.setAttribute("error", "Vui lòng điền đầy đủ các trường bắt buộc.");
            prepareFormLists(request);
            request.getRequestDispatcher("/admin/room-form.jsp").forward(request, response);
            return;
        }

        int categoryId = Integer.parseInt(categoryIdStr);
        double price;
        double acreage = 0;
        int bed = 1;
        try {
            price = Double.parseDouble(priceStr);
            if (acreageStr != null && !acreageStr.isEmpty()) {
                acreage = Double.parseDouble(acreageStr);
            }
            if (bedStr != null && !bedStr.isEmpty()) {
                bed = Integer.parseInt(bedStr);
            }
            if (price < 0 || acreage < 0 || bed <= 0) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu Số lượng, Diện tích hoặc Giá phòng không hợp lệ.");
            prepareFormLists(request);
            request.getRequestDispatcher("/admin/room-form.jsp").forward(request, response);
            return;
        }

        boolean status = "1".equals(statusStr) || "true".equalsIgnoreCase(statusStr);
        int roomId = 0;
        if (roomIdStr != null && !roomIdStr.isEmpty()) {
            roomId = Integer.parseInt(roomIdStr);
        }

        Room room = new Room(roomId, categoryId, roomNumber, roomName, price, acreage, bed, area, description, status, null, null);
        boolean success;

        if (roomId == 0) {
            success = roomService.createRoom(room);
            if (success) {
                request.getSession().setAttribute("message", "Thêm phòng mới thành công.");
            } else {
                request.getSession().setAttribute("error", "Thêm phòng thất bại. Số phòng có thể đã tồn tại.");
            }
        } else {
            success = roomService.updateRoom(room);
            if (success) {
                request.getSession().setAttribute("message", "Cập nhật phòng thành công.");
            } else {
                request.getSession().setAttribute("error", "Cập nhật phòng thất bại.");
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/rooms");
    }

    private void listRooms(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Room> list = roomService.getAllRooms();
        request.setAttribute("roomList", list);
        request.getRequestDispatcher("/admin/room-list.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        prepareFormLists(request);
        request.getRequestDispatcher("/admin/room-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            Room room = roomService.getRoomById(id);
            if (room != null) {
                request.setAttribute("room", room);
                List<RoomImage> imagesList = roomService.getImagesByRoomId(id);
                request.setAttribute("imagesList", imagesList);
            }
        }
        prepareFormLists(request);
        request.getRequestDispatcher("/admin/room-form.jsp").forward(request, response);
    }

    private void deleteRoom(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            boolean success = roomService.deleteRoom(id);
            if (success) {
                request.getSession().setAttribute("message", "Xóa phòng thành công.");
            } else {
                request.getSession().setAttribute("error", "Không thể xóa phòng này do có dữ liệu đặt phòng liên kết.");
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/rooms");
    }

    private void addRoomImage(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String roomIdStr = request.getParameter("roomId");
        String imageUrl = request.getParameter("imageUrl");
        String isMainStr = request.getParameter("isMain");
        String sortOrderStr = request.getParameter("sortOrder");

        if (roomIdStr != null && !roomIdStr.isEmpty() && imageUrl != null && !imageUrl.trim().isEmpty()) {
            int roomId = Integer.parseInt(roomIdStr);
            boolean isMain = "1".equals(isMainStr) || "true".equalsIgnoreCase(isMainStr);
            int sortOrder = 1;
            if (sortOrderStr != null && !sortOrderStr.isEmpty()) {
                sortOrder = Integer.parseInt(sortOrderStr);
            }

            RoomImage image = new RoomImage(0, roomId, imageUrl.trim(), isMain, sortOrder);
            boolean success = roomService.addRoomImage(image);
            if (success) {
                request.getSession().setAttribute("message", "Thêm ảnh phòng thành công.");
            } else {
                request.getSession().setAttribute("error", "Không thể thêm ảnh phòng.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/rooms?action=edit&id=" + roomId);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/rooms");
        }
    }

    private void deleteImage(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String imageIdStr = request.getParameter("id");
        String roomIdStr = request.getParameter("roomId");
        if (imageIdStr != null && !imageIdStr.isEmpty() && roomIdStr != null && !roomIdStr.isEmpty()) {
            int imageId = Integer.parseInt(imageIdStr);
            int roomId = Integer.parseInt(roomIdStr);
            boolean success = roomService.removeRoomImage(imageId);
            if (success) {
                request.getSession().setAttribute("message", "Xóa ảnh phòng thành công.");
            } else {
                request.getSession().setAttribute("error", "Không thể xóa ảnh phòng.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/rooms?action=edit&id=" + roomId);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/rooms");
        }
    }

    private void prepareFormLists(HttpServletRequest request) {
        List<RoomCategory> categoryList = categoryService.getAllCategories();
        request.setAttribute("categoryList", categoryList);
    }
}
