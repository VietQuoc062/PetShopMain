package business;

import java.io.Serializable;
import java.text.NumberFormat;
import java.util.Locale;

public class Product implements Serializable {
    private String code;
    private String name;
    private Double price;

    public Product() {
        code = "";
        name = "";
        price = 0.0;  // [FIX] dùng 0.0 cho Double
    }

    public Product(String code, String name, double price) { // [FIX] constructor tiện
        this.code = code;
        this.price = price;
        this.name = name;
    }

    public void setCode(String code) { this.code = code; }
    public String getCode() { return code; }

    public void setName(String name) { this.name = name; }
    public String getName() { return name; }

    public void setPrice(double price) { this.price = price; }
    public double getPrice() { return price; }



    public String getPriceCurrencyFormat() {  // [FIX] format VN
        NumberFormat currency = NumberFormat.getCurrencyInstance(new Locale("vi","VN"));
        return currency.format(price);
    }
}
