package business;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Cart implements Serializable {
    private List<LineItem> items;

    public Cart() { items = new ArrayList<>(); }

    public List<LineItem> getItems() { return items; }

    public int getItemCount() { return items.size(); } // số loại sản phẩm
    public int getTotalQuantity() {  // tổng số lượng sản phẩm
        int total = 0;
        for (LineItem item : items) total += item.getQuantity();
        return total;
    }
    public double getTotalAmount() { // tổng tiền
        double total = 0.0;
        for (LineItem item : items) total += item.getTotal();
        return total;
    }

    public void addItem(LineItem item) {
        if (item == null || item.getProduct() == null) return;
        String code = item.getProduct().getCode();
        int quantity = item.getQuantity();
        for (LineItem cartItem : items) {
            if (cartItem.getProduct().getCode().equals(code)) {
                cartItem.setQuantity(cartItem.getQuantity() + quantity);
                return;
            }
        }
        if (quantity > 0) items.add(item);
    }

    public void updateItem(String productCode, int quantity) {  // [FIX] dùng productCode
        if (productCode == null || productCode.isEmpty()) return;
        for (LineItem cartItem : items) {
            if (cartItem.getProduct().getCode().equals(productCode)) {
                if (quantity > 0) cartItem.setQuantity(quantity);
                else items.remove(cartItem);
                return;
            }
        }
    }

    public void removeItem(String productCode) {  // [FIX] dùng productCode
        if (productCode == null || productCode.isEmpty()) return;
        items.removeIf(cartItem -> cartItem.getProduct().getCode().equals(productCode));
    }
}
