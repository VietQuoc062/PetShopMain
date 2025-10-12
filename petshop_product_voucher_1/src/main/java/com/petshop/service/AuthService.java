package com.petshop.service;

import com.petshop.dao.AccountDAO;
import com.petshop.model.Account;

public class AuthService {
    private AccountDAO accountDAO;

    public AuthService() {
        this.accountDAO = new AccountDAO();
    }

    public Account login(String username, String password) {
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            return null;
        }
        
        return accountDAO.authenticate(username.trim(), password);
    }

    public boolean hasAdminAccess(Account account) {
        return account != null && account.isOwner();
    }

    public boolean hasStaffAccess(Account account) {
        return account != null && (account.isOwner() || account.isStaff());
    }
}
