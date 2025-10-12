package com.petshop.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

import com.petshop.model.Item;
import com.petshop.model.Product;
import com.petshop.service.ItemService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/items/*")
public class AdminItemServlet extends HttpServlet {
    private ItemService itemService;
    
    public void init() { 
        itemService = new ItemService(); 
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) action = "/";
        
        try {
            switch (action) {
                case "/new": showNewForm(request, response); break;
                case "/insert": insertItem(request, response); break;
                case "/delete": deleteItem(request, response); break;
                case "/edit": showEditForm(request, response); break;
                case "/update": updateItem(request, response); break;
                default: listItem(request, response); break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        } catch (IllegalArgumentException ex) {
            request.setAttribute("error", ex.getMessage());
            request.setAttribute("currentPage", "items");
            request.getRequestDispatcher("/WEB-INF/views/admin/items/list.jsp").forward(request, response);
        }
    }

    private void listItem(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        // Get page parameter, default to 1
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        int pageSize = 10;
        int offset = (page - 1) * pageSize;
        
        int totalItems = itemService.getTotalItemCount();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        
        List<Item> listItem = itemService.getItemsPaginated(offset, pageSize);
        
        request.setAttribute("listItem", listItem);
        request.setAttribute("currentPage", "items");
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/items/list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> products = itemService.getAllProducts();
        request.setAttribute("listProducts", products);
        request.setAttribute("currentPage", "items");
        request.getRequestDispatcher("/WEB-INF/views/admin/items/add.jsp").forward(request, response);
    }

    private void insertItem(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String imageUrl = request.getParameter("imageUrl");
        String status = request.getParameter("status");
        String description = request.getParameter("description");
        String productIdStr = request.getParameter("productID");

        try {
            BigDecimal price = new BigDecimal(priceStr);
            Integer productID = null;
            if (productIdStr != null && !productIdStr.trim().isEmpty()) {
                productID = Integer.parseInt(productIdStr);
            }

            Item newItem = new Item();
            newItem.setName(name);
            newItem.setPrice(price);
            newItem.setImageUrl(imageUrl);
            newItem.setStatus(status);
            newItem.setDescription(description);
            newItem.setProductID(productID);
            
            itemService.addItem(newItem);
            response.sendRedirect(request.getContextPath() + "/admin/items/list?message=add_success");
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/items/new?error=invalid_input");
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Item existingItem = itemService.getItemById(id);
        List<Product> products = itemService.getAllProducts();
        
        request.setAttribute("item", existingItem);
        request.setAttribute("listProducts", products);
        request.setAttribute("currentPage", "items");
        request.getRequestDispatcher("/WEB-INF/views/admin/items/edit.jsp").forward(request, response);
    }

    private void updateItem(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        request.setCharacterEncoding("UTF-8");
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        BigDecimal price = new BigDecimal(request.getParameter("price"));
        String imageUrl = request.getParameter("imageUrl");
        String status = request.getParameter("status");
        String description = request.getParameter("description");
        Integer productID = null;
        if (request.getParameter("productID") != null && !request.getParameter("productID").trim().isEmpty()) {
            productID = Integer.parseInt(request.getParameter("productID"));
        }

        Item item = new Item();
        item.setItemID(id);
        item.setName(name);
        item.setPrice(price);
        item.setImageUrl(imageUrl);
        item.setStatus(status);
        item.setDescription(description);
        item.setProductID(productID);
        
        itemService.updateItem(item);
        response.sendRedirect(request.getContextPath() + "/admin/items/list?message=update_success");
    }

    private void deleteItem(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        itemService.deleteItem(id);
        response.sendRedirect(request.getContextPath() + "/admin/items/list?message=delete_success");
    }
}
