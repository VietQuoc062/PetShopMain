package cart;

import java.io.*;

import business.Cart;
import business.LineItem;
import business.Product;
import data.ProductDB;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class CartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String url= "/index.jsp";
        ServletContext sc = getServletContext();
        String action = request.getParameter("action");
        if ( action == null){
            action = "cart";
        }

        HttpSession session = request.getSession(); //Lay session 
            Cart cart = (Cart) session.getAttribute("cart");
            if(cart == null){
                cart = new Cart();
            }

        if (action.equals("shop")) {
                url = "/index.jsp";    // the "index" page
        }
        else if (action.equals("add")){
            String productId = request.getParameter("productId");
            System.out.println("ProductId from request: " + productId);
            String Quantity = request.getParameter("modalProductQuantity");

            int quantity=1;
            try{
                quantity = Integer.parseInt(Quantity);
                if (quantity <0){
                    quantity =1;
                }
            }
            catch (NumberFormatException nfe){
                quantity =1 ;
            }

            // Lấy sản phẩm từ DB dựa vào productId
            ProductDB db = new ProductDB();
            Product product = db.getProductById(productId);
            System.out.println("Product from DB: " + product);
            if (product != null) {
                LineItem lineItem = new LineItem(product, quantity);
                cart.addItem(lineItem);
                  // --- DEBUG: kiểm tra giỏ hàng sau khi thêm ---
            System.out.println("Cart size after add: " + cart.getItems().size());
            for (LineItem li : cart.getItems()) {
                System.out.println(li.getProduct().getCode() + " x " + li.getQuantity());
            }
                session.setAttribute("cart", cart);
                request.setAttribute("message", "Sản phẩm đã được thêm vào giỏ!");
            } 

            url = "/index.jsp";
            sc.getRequestDispatcher(url).forward(request, response);

        }
        else if (action.equals("cart")){
            // HttpSession session = request.getSession();
            // Cart cart = (Cart) session.getAttribute("cart");
            // if (cart == null) {
            //         cart = new Cart();
            // }
            url = "/cart.jsp";
        }
        else if (action.equals("update")) {
            // lấy productCode và quantity từ form
            String productCode = request.getParameter("productCode");
            String quantityStr = request.getParameter("quantity");

            int quantity = 1;
            try {
                quantity = Integer.parseInt(quantityStr);
                if (quantity < 0) quantity = 1;
            } catch (NumberFormatException e) {
                quantity = 1;
            }

            cart.updateItem(productCode, quantity);
            session.setAttribute("cart", cart);
            url = "/cart.jsp";
        }
        else if ("remove".equals(action)) {
            String code = request.getParameter("productCode");
            cart.removeItem(code);
        }
        sc.getRequestDispatcher(url)
                .forward(request, response);

    }
    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }    
}
