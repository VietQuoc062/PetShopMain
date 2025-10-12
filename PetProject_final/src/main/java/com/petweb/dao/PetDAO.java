package com.petweb.dao;

import com.petweb.model.Pet;
import java.sql.*;

public class PetDAO {
    
    public Pet getPetByItemId(int itemId) {
        String sql = "SELECT PetID, ItemID, Species, Breed, Age, Gender " +
                    "FROM Pet WHERE ItemID = ?";
        String url = "jdbc:sqlserver://.;databaseName=master;trustServerCertificate=true";
        
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            return null;
        }
        
        try (Connection conn = DriverManager.getConnection(url, "sa", "123");
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, itemId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Pet pet = new Pet();
                pet.setItemId(rs.getInt("ItemID"));
                pet.setSpecies(rs.getString("Species"));
                pet.setBreed(rs.getString("Breed"));
                pet.setAge(rs.getInt("Age"));
                pet.setGender(rs.getString("Gender"));
                return pet;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null; // Null means this Item is not a Pet
    }
}