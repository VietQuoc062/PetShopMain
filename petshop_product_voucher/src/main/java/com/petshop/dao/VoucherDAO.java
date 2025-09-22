package com.petshop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.petshop.model.Voucher;
import com.petshop.util.DatabaseUtil;

public class VoucherDAO {

    public List<Voucher> getAllVouchers() throws SQLException {
        List<Voucher> vouchers = new ArrayList<>();
        String SELECT_ALL_VOUCHERS = "SELECT * FROM vouchers ORDER BY id DESC";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_ALL_VOUCHERS);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                vouchers.add(mapResultSetToVoucher(rs));
            }
        }
        return vouchers;
    }

    public Voucher getVoucherById(int id) throws SQLException {
        Voucher voucher = null;
        String SQL = "SELECT * FROM vouchers WHERE id = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(SQL)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) voucher = mapResultSetToVoucher(rs);
            }
        }
        return voucher;
    }

    public void addVoucher(Voucher voucher) throws SQLException {
        String INSERT_SQL = "INSERT INTO vouchers (code, description, discount_amount, min_order_value, start_date, end_date, active) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(INSERT_SQL)) {
            connection.setAutoCommit(false);
            ps.setString(1, voucher.getCode());
            ps.setString(2, voucher.getDescription());
            ps.setBigDecimal(3, voucher.getDiscountAmount());
            ps.setBigDecimal(4, voucher.getMinOrderValue());
            ps.setTimestamp(5, voucher.getStartDate() == null ? null : Timestamp.valueOf(voucher.getStartDate()));
            ps.setTimestamp(6, voucher.getEndDate() == null ? null : Timestamp.valueOf(voucher.getEndDate()));
            ps.setBoolean(7, voucher.isActive());
            ps.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            throw e;
        }
    }

    public void updateVoucher(Voucher voucher) throws SQLException {
        String UPDATE_SQL = "UPDATE vouchers SET code=?, description=?, discount_amount=?, min_order_value=?, start_date=?, end_date=?, active=? WHERE id=?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(UPDATE_SQL)) {
            connection.setAutoCommit(false);
            ps.setString(1, voucher.getCode());
            ps.setString(2, voucher.getDescription());
            ps.setBigDecimal(3, voucher.getDiscountAmount());
            ps.setBigDecimal(4, voucher.getMinOrderValue());
            ps.setTimestamp(5, voucher.getStartDate() == null ? null : Timestamp.valueOf(voucher.getStartDate()));
            ps.setTimestamp(6, voucher.getEndDate() == null ? null : Timestamp.valueOf(voucher.getEndDate()));
            ps.setBoolean(7, voucher.isActive());
            ps.setInt(8, voucher.getId());
            ps.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            throw e;
        }
    }

    public void deleteVoucher(int id) throws SQLException {
        String DELETE_SQL = "DELETE FROM vouchers WHERE id = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(DELETE_SQL)) {
            connection.setAutoCommit(false);
            ps.setInt(1, id);
            ps.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            throw e;
        }
    }

    private Voucher mapResultSetToVoucher(ResultSet rs) throws SQLException {
        Voucher voucher = new Voucher();
        voucher.setId(rs.getInt("id"));
        voucher.setCode(rs.getString("code"));
        voucher.setDescription(rs.getString("description"));
        voucher.setDiscountAmount(rs.getBigDecimal("discount_amount"));
        voucher.setMinOrderValue(rs.getBigDecimal("min_order_value"));
        Timestamp s = rs.getTimestamp("start_date");
        Timestamp e = rs.getTimestamp("end_date");
        voucher.setStartDate(s == null ? null : s.toLocalDateTime());
        voucher.setEndDate(e == null ? null : e.toLocalDateTime());
        voucher.setActive(rs.getBoolean("active"));
        return voucher;
    }
}