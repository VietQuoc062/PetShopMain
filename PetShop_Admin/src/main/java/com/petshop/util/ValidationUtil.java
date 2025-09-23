package com.petshop.util;

import java.util.regex.Pattern;

public class ValidationUtil {
    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[a-zA-Z0-9_]{3,50}$");
    private static final Pattern PASSWORD_PATTERN = Pattern.compile("^.{4,}$");
    private static final Pattern ROLE_PATTERN = Pattern.compile("^(ADMIN|MANAGER)$");
    
    private ValidationUtil() {}
    
    public static boolean isValidUsername(String username) {
        return username != null && USERNAME_PATTERN.matcher(username.trim()).matches();
    }
    
    public static boolean isValidPassword(String password) {
        return password != null && PASSWORD_PATTERN.matcher(password).matches();
    }
    
    public static boolean isValidRole(String role) {
        return role != null && ROLE_PATTERN.matcher(role.trim().toUpperCase()).matches();
    }
}