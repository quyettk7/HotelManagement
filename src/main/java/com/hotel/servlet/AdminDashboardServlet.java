package com.hotel.servlet;

import com.hotel.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("currentUser");
        String roleName = user.getRoleName();

        if (roleName == null || (!roleName.equalsIgnoreCase("Admin") && 
                                 roleName.equalsIgnoreCase("Customer"))) {
            // Customers should not access admin dashboard
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        // Render admin dashboard view
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
