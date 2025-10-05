package com.petshop.model;

public class Product {
    private int id;
    private String name;
    private String petType;
    private int price;
    private String img;

    public Product(int id, String name, String petType, int price, String img) {
        this.id = id;
        this.name = name;
        this.petType = petType;
        this.price = price;
        this.img = img;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public String getPetType() { return petType; }
    public int getPrice() { return price; }
    public String getImg() { return img; }
}
