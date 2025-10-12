package com.petweb.model;

import jakarta.persistence.*;

@Entity
@Table(name = "Pet")
public class Pet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "PetID")
    private int petId;
    
    @Column(name = "ItemID", nullable = false)
    private int itemId;
    
    @Column(name = "Species")
    private String species;
    
    @Column(name = "Breed")
    private String breed;
    
    @Column(name = "Age")
    private int age;
    
    @Column(name = "Gender")
    private String gender;
    
    // Relationship với Item
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ItemID", insertable = false, updatable = false)
    private Item item;

    // Constructor mặc định
    public Pet() {
    }

    // Constructor không có ID
    public Pet(int itemId, String species, String breed, int age, String gender) {
        this.itemId = itemId;
        this.species = species;
        this.breed = breed;
        this.age = age;
        this.gender = gender;
    }

    // Getters and Setters
    public int getPetId() {
        return petId;
    }

    public void setPetId(int petId) {
        this.petId = petId;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public String getSpecies() {
        return species;
    }

    public void setSpecies(String species) {
        this.species = species;
    }

    public String getBreed() {
        return breed;
    }

    public void setBreed(String breed) {
        this.breed = breed;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    // Helper methods để lấy thông tin từ Item
    public String getName() {
        return item != null ? item.getName() : "";
    }
    
    public String getImageUrl() {
        return item != null ? item.getImageUrl() : "";
    }
    
    public String getDescription() {
        return item != null ? item.getDescription() : "";
    }
    
    public double getPrice() {
        return item != null ? item.getPrice().doubleValue() : 0.0;
    }

    @Override
    public String toString() {
        return "Pet{" +
                "petId=" + petId +
                ", itemId=" + itemId +
                ", species='" + species + '\'' +
                ", breed='" + breed + '\'' +
                ", age=" + age +
                ", gender='" + gender + '\'' +
                '}';
    }
}