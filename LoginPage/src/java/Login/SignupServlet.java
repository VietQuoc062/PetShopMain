package Login;

import dao.AccountDAO;
import dao.UserDAO;
import model.Account;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class SignupServlet extends HttpServlet {
    private AccountDAO accountDAO = new AccountDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = "Customer"; // mặc định là khách hàng
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        String accountId = accountDAO.generateAccountId(role);
        Account acc = new Account(accountId, username, password, role);
        User user = new User(accountId, firstName, lastName, gender, email, phone, address);

        boolean accCreated = accountDAO.insertAccount(acc);
        boolean userCreated = userDAO.insertUser(user);

        if (accCreated && userCreated) {
            request.setAttribute("mess", "Đăng ký thành công, hãy đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Đăng ký thất bại! Tài khoản hoặc email đã tồn tại.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
    }
}