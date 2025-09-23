package com.petshop.servlet;

import com.petshop.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    private List<Product> products;

    @Override
    public void init() throws ServletException {
        products = new ArrayList<>();
        products.add(new Product(1,"Tabby","cat",1190000,"https://via.placeholder.com/100"));
        products.add(new Product(2,"Golden","cat",990000,"https://via.placeholder.com/100"));
        products.add(new Product(3,"Texudo","cat",399000,"https://via.placeholder.com/100"));
        products.add(new Product(4,"Pug","dog",4490000,"https://via.placeholder.com/100"));
        products.add(new Product(5,"Pitbull","dog",299000,"https://via.placeholder.com/100"));
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String petType = req.getParameter("petType");
    String minStr = req.getParameter("min");
    String maxStr = req.getParameter("max");

    int min = 0;
    int max = Integer.MAX_VALUE;

    try {
        if (minStr != null && !minStr.isEmpty()) min = Integer.parseInt(minStr);
        if (maxStr != null && !maxStr.isEmpty()) max = Integer.parseInt(maxStr);
    } catch (NumberFormatException e) {
        // giữ nguyên min/max mặc định
    }

    final int minF = min;
    final int maxF = max;
    final String petTypeF = petType;

    List<Product> filtered = products.stream()
            .filter(p -> (petTypeF == null || "all".equalsIgnoreCase(petTypeF) 
                          || p.getPetType().equalsIgnoreCase(petTypeF)))
            .filter(p -> p.getPrice() >= minF && p.getPrice() <= maxF)
            .collect(Collectors.toList());

    req.setAttribute("products", filtered);
    req.getRequestDispatcher("/products.html").forward(req, resp);
}

}
