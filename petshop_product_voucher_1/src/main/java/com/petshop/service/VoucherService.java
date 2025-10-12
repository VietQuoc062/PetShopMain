package com.petshop.service;

import java.util.List;

import com.petshop.dao.VoucherDAO;
import com.petshop.model.Promotion;

public class VoucherService {
    private VoucherDAO voucherDAO;
    public VoucherService() { this.voucherDAO = new VoucherDAO(); }

    public List<Promotion> getAllVouchers() { return voucherDAO.getAllVouchers(); }
    public Promotion getVoucherById(int id) { return voucherDAO.getVoucherById(id); }

    public Promotion addVoucher(Promotion voucher) { return voucherDAO.addVoucher(voucher); }

    public Promotion updateVoucher(Promotion voucher) { return voucherDAO.updateVoucher(voucher); }

    public void deleteVoucher(int id) { voucherDAO.deleteVoucher(id); }

    public List<Promotion> getVouchersPaginated(int offset, int limit) { 
        return voucherDAO.getVouchersPaginated(offset, limit); 
    }
    
    public int getTotalVoucherCount() { 
        return voucherDAO.getTotalVoucherCount(); 
    }
}