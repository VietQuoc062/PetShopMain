package business;

import java.io.Serializable;
import java.text.NumberFormat;
import java.util.Locale;

public class LineItem implements Serializable {

    private Product product;
    private int quantity;

    public LineItem() {}

    public LineItem(Product product, int quantity) {  // [FIX] constructor tiện
        this.product = product;
        this.quantity = quantity;
    }

    public void setProduct(Product product) { this.product = product; }
    public Product getProduct() { return product; }

    public void setQuantity(int quantity) { this.quantity = quantity; }
    public int getQuantity() { return quantity; }

    public double getTotal() {
        if (product == null) return 0.0; // [FIX] tránh NullPointer
        return product.getPrice() * quantity;
    }

    public String getTotalCurrencyFormat() { // [FIX] format VN
        NumberFormat currency = NumberFormat.getCurrencyInstance(new Locale("vi","VN"));
        return currency.format(getTotal());
    }
}
