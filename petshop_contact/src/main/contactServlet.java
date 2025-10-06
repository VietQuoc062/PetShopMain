import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Thông tin database
    private static final String DB_URL = "jdbc:mysql://localhost:3306/contact_db";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set encoding để hiển thị tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // Lấy dữ liệu từ form
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String message = request.getParameter("message");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Kết nối database
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Câu lệnh SQL để insert dữ liệu
            String sql = "INSERT INTO contacts (name, email, phone, message, created_at) VALUES (?, ?, ?, ?, NOW())";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, phone);
            pstmt.setString(4, message);

            // Thực thi câu lệnh
            int result = pstmt.executeUpdate();

            if (result > 0) {
                // Thành công
                response.getWriter().println("<html><head><meta charset='UTF-8'></head><body>");
                response.getWriter().println("<h2>Gửi tin nhắn thành công!</h2>");
                response.getWriter().println("<p>Cảm ơn bạn đã liên hệ. Chúng tôi sẽ phản hồi sớm nhất.</p>");
                response.getWriter().println("<a href='contact.html'>Quay lại</a>");
                response.getWriter().println("</body></html>");
            } else {
                // Thất bại
                response.getWriter().println("<html><head><meta charset='UTF-8'></head><body>");
                response.getWriter().println("<h2>Có lỗi xảy ra!</h2>");
                response.getWriter().println("<p>Vui lòng thử lại.</p>");
                response.getWriter().println("<a href='contact.html'>Quay lại</a>");
                response.getWriter().println("</body></html>");
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi: Không tìm thấy MySQL Driver!");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi database: " + e.getMessage());
        } finally {
            // Đóng kết nối
            try {
                if (pstmt != null)
                    pstmt.close();
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}