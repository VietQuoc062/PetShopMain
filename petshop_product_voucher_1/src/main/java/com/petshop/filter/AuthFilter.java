package com.petshop.filter;

import java.io.IOException;

import com.petshop.model.Account;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/admin/*")
public class AuthFilter implements Filter {

    public void init(FilterConfig filterConfig) throws ServletException {}

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        Account account = null;
        if (session != null) {
            account = (Account) session.getAttribute("account");
        }

        // Check if user is logged in and has admin access
        if (account == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }

        String requestURI = httpRequest.getRequestURI();
        String method = httpRequest.getMethod();

        // Owner can do everything
        if (account.isOwner()) {
            chain.doFilter(request, response);
            return;
        }

        // Staff can only view (GET requests)
        if (account.isStaff()) {
            if ("GET".equals(method) && !requestURI.contains("/delete")) {
                chain.doFilter(request, response);
                return;
            } else {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền thực hiện thao tác này!");
                return;
            }
        }

        // Customer cannot access admin area
        if (account.isCustomer()) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/access-denied");
            return;
        }

        // Unknown role - deny access
        httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập khu vực này!");
    }

    public void destroy() {}
}
