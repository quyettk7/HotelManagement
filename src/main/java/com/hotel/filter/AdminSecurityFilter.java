package com.hotel.filter;

import com.hotel.entity.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/admin/*")
public class AdminSecurityFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        // Check if user is logged in
        if (session == null || session.getAttribute("currentUser") == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }

        // Check user role
        User user = (User) session.getAttribute("currentUser");
        String roleName = user.getRoleName();

        if (roleName == null || (!roleName.equalsIgnoreCase("Admin") && 
                                 !roleName.equalsIgnoreCase("Manager") && 
                                 !roleName.equalsIgnoreCase("Staff"))) {
            // Non-admin/staff/manager users (like Customers) cannot access admin section
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/index.jsp");
            return;
        }

        // Allow request to proceed
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}
