package com.example.Model;

public class Product {
    private int id;
    private String name;
    private double price;
    private int rating;

    public Product() {}

    public Product(int id, String name, double price, int rating) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.rating = rating;
    }

    // Getter & Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getImage() {
        throw new UnsupportedOperationException("Unimplemented method 'getImage'");
    }
}
