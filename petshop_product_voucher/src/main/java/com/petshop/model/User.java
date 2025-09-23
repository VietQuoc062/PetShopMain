package com.petshop.model;
import org.mindrot.jbcrypt.BCrypt;

public class User {
    private int id;
    private String name;
    private String passwordHash;
    private boolean isActive;

    // Phương thức mã hóa password từ plain text
    public void setPassword(String plainPassword) {
        this.passwordHash = BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }
    
    public boolean checkPassword(String plainPassword) {
        if (this.passwordHash == null) return false;
        return BCrypt.checkpw(plainPassword, this.passwordHash);
    }
    
    // Phương thức set trực tiếp hash (CHỈ GIỮ LẠI MỘT PHƯƠNG THỨC NÀY)
    public void setPasswordHash(String hash) { 
        this.passwordHash = hash; 
    }
    
    public String getPasswordHash() { 
        return passwordHash; 
    }
    
    public boolean login(String providedPassword) {
        return checkPassword(providedPassword) && this.isActive;
    }
    
    public User() {}
    
    public User(int id, String name, String password, boolean isActive) {
        this.id = id;
        this.name = name;
        this.passwordHash = password;
        this.isActive = isActive;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return passwordHash;
    }

    // XÓA HOÀN TOÀN phương thức setPassword(String) ở đây
    // KHÔNG được có phương thức nào tên setPasswordHash nữa

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public void logout() {
        System.out.println("User logged out: " + this.name);
    }

    public void updateInfo(String newName) {
        this.name = newName;
    }

    public boolean changePassword(String oldPassword, String newPassword) {
        if (checkPassword(oldPassword)) {
            setPassword(newPassword); // Sử dụng BCrypt
            return true;
        }
        return false;
    }
}