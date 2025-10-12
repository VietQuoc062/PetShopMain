package com.petshop.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "Pet")
public class Pet {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "PetID")
    private Integer petID;

    @Column(name = "Species", length = 100)
    private String species;

    @Column(name = "Breed", length = 100)
    private String breed;

    @Column(name = "Age")
    private Integer age;

    @Column(name = "Gender", length = 10)
    private String gender;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ItemID", nullable = false)
    private Item item;

    // Constructors
    public Pet() {}

    public Pet(Integer petID, String species, String breed, Integer age, String gender, Item item) {
        this.petID = petID;
        this.species = species;
        this.breed = breed;
        this.age = age;
        this.gender = gender;
        this.item = item;
    }

    // Getters and Setters
    public Integer getPetID() { return petID; }
    public void setPetID(Integer petID) { this.petID = petID; }

    public String getSpecies() { return species; }
    public void setSpecies(String species) { this.species = species; }

    public String getBreed() { return breed; }
    public void setBreed(String breed) { this.breed = breed; }

    public Integer getAge() { return age; }
    public void setAge(Integer age) { this.age = age; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public Item getItem() { return item; }
    public void setItem(Item item) { this.item = item; }

    // Helper methods for JSP/EL
    public Integer getId() { return petID; }
    public void setId(Integer id) { this.petID = id; }

    public Integer getItemID() {
        return item != null ? item.getItemID() : null;
    }

    public void setItemID(Integer itemID) {
        if (itemID != null) {
            Item newItem = new Item();
            newItem.setItemID(itemID);
            this.item = newItem;
        } else {
            this.item = null;
        }
    }
}
