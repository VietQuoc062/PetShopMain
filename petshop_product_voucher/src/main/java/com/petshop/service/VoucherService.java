package com.petshop.service;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

import com.petshop.dao.VoucherDAO;
import com.petshop.model.Voucher;

public class VoucherService {
    private VoucherDAO voucherDAO;
    public VoucherService() { this.voucherDAO = new VoucherDAO(); }

    public List<Voucher> getAllVouchers() throws SQLException { return voucherDAO.getAllVouchers(); }
    public Voucher getVoucherById(int id) throws SQLException { return voucherDAO.getVoucherById(id); }

    public void addVoucher(Voucher voucher) throws SQLException {
        if (voucher.getCode() == null || voucher.getCode().isEmpty()) throw new IllegalArgumentException("Voucher code cannot be empty");
        LocalDateTime s = voucher.getStartDate();
        LocalDateTime e = voucher.getEndDate();
        if (s != null && e != null && s.isAfter(e)) throw new IllegalArgumentException("Start date must be before end date");
        voucherDAO.addVoucher(voucher);
    }

    public void updateVoucher(Voucher voucher) throws SQLException {
        if (voucher.getCode() == null || voucher.getCode().isEmpty()) throw new IllegalArgumentException("Voucher code cannot be empty");
        voucherDAO.updateVoucher(voucher);
    }

    public void deleteVoucher(int id) throws SQLException {
        if (id <= 0) throw new IllegalArgumentException("Invalid voucher ID");
        voucherDAO.deleteVoucher(id);
    }
}