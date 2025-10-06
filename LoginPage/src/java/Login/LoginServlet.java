package Login;

import dao.AccountDAO;
import dao.UserDAO;
import model.Account;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    private AccountDAO accountDAO = new AccountDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String identifier = request.getParameter("identifier");
        String password = request.getParameter("password");

        // Tìm tài khoản theo username, email hoặc phone
        Account acc = accountDAO.findAccountByIdentifier(identifier, password);
        if (acc != null) {
            User user = userDAO.getUserByAccountId(acc.getId());

            HttpSession session = request.getSession();
            session.setAttribute("account", acc);
            session.setAttribute("user", user);

            response.sendRedirect("welcome.jsp");
        } else {
            request.setAttribute("error", "Thông tin đăng nhập không đúng");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}