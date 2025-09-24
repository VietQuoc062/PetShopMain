package Login;

import dao.UserDAO;
import model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class SignupServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User newUser = new User(firstName, lastName, phone, email, password, "user");

        if (userDAO.insertUser(newUser)) {
            request.setAttribute("mess", "Đăng ký thành công, hãy đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Đăng ký thất bại! Email hoặc Phone đã tồn tại.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
    }
}
