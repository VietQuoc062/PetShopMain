package com.petweb.model;

public class Pet {
    private int id;
    private String name;
    private String alias;
    private String origin;
    private String type;
    private String furType;
    private String colors;
    private String features;
    private double weight;
    private String ageRange;
    private String breedingAge;
    private int littersPerYear;
    private String imageUrl;

    public Pet() {
    }

    public Pet(int id, String name, String alias, String origin, String type, String furType, 
               String colors, String features, double weight, String ageRange, 
               String breedingAge, int littersPerYear, String imageUrl) {
        this.id = id;
        this.name = name;
        this.alias = alias;
        this.origin = origin;
        this.type = type;
        this.furType = furType;
        this.colors = colors;
        this.features = features;
        this.weight = weight;
        this.ageRange = ageRange;
        this.breedingAge = breedingAge;
        this.littersPerYear = littersPerYear;
        this.imageUrl = imageUrl;
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

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getFurType() {
        return furType;
    }

    public void setFurType(String furType) {
        this.furType = furType;
    }

    public String getColors() {
        return colors;
    }

    public void setColors(String colors) {
        this.colors = colors;
    }

    public String getFeatures() {
        return features;
    }

    public void setFeatures(String features) {
        this.features = features;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public String getAgeRange() {
        return ageRange;
    }

    public void setAgeRange(String ageRange) {
        this.ageRange = ageRange;
    }

    public String getBreedingAge() {
        return breedingAge;
    }

    public void setBreedingAge(String breedingAge) {
        this.breedingAge = breedingAge;
    }

    public int getLittersPerYear() {
        return littersPerYear;
    }

    public void setLittersPerYear(int littersPerYear) {
        this.littersPerYear = littersPerYear;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}