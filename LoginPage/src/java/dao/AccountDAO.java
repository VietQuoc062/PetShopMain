package dao;

import model.Account;
import java.sql.*;

public class AccountDAO {

    private String jdbcURL = "jdbc:sqlserver://DESKTOP-U17J0TA:1433;databaseName=LapTrinhWeb;encrypt=false;";
    private String jdbcUser = "sa";
    private String jdbcPass = "123456";

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);
    }

    // Tạo tài khoản mới
    public boolean insertAccount(Account acc) {
        String sql = "INSERT INTO accounts(id, username, password, role) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, acc.getId());
            ps.setString(2, acc.getUsername());
            ps.setString(3, acc.getPassword());
            ps.setString(4, acc.getRole());
            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Kiểm tra đăng nhập
    public Account findAccountByIdentifier(String identifier, String password) {
    String sql = """
        SELECT a.* FROM accounts a
        LEFT JOIN users u ON a.id = u.account_id
        WHERE (a.username = ? OR u.email = ? OR u.phone = ?) AND a.password = ?
        """;
    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, identifier);
        ps.setString(2, identifier);
        ps.setString(3, identifier);
        ps.setString(4, password);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Account acc = new Account();
            acc.setId(rs.getString("id"));
            acc.setUsername(rs.getString("username"));
            acc.setPassword(rs.getString("password"));
            acc.setRole(rs.getString("role"));
            return acc;
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}


    // Sinh mã accountId tự động (ví dụ: CUS001)
    public String generateAccountId(String role) {
        String prefix = switch (role) {
            case "Customer" -> "CUS";
            case "Staff"    -> "STA";
            case "Owner"    -> "OWN";
            default         -> "ACC";
        };

        String sql = "SELECT COUNT(*) AS total FROM accounts WHERE role = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, role);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("total") + 1;
                return prefix + String.format("%03d", count); // ví dụ: CUS001
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return prefix + "001"; // fallback nếu lỗi
    }
}