package com.petshop.service;

import java.util.List;

import com.petshop.dao.ItemDAO;
import com.petshop.model.Item;
import com.petshop.model.Product;

public class ItemService {
    private ItemDAO itemDAO;
    
    public ItemService() { 
        this.itemDAO = new ItemDAO(); 
    }

    public List<Item> getAllItems() { 
        return itemDAO.getAllItems(); 
    }
    
    public List<Item> getItemsPaginated(int offset, int limit) { 
        return itemDAO.getItemsPaginated(offset, limit); 
    }
    
    public int getTotalItemCount() { 
        return itemDAO.getTotalItemCount(); 
    }
    
    public Item getItemById(int id) { 
        return itemDAO.getItemById(id); 
    }

    public Item addItem(Item item) { 
        return itemDAO.addItem(item); 
    }

    public Item updateItem(Item item) { 
        return itemDAO.updateItem(item); 
    }

    public void deleteItem(int id) { 
        itemDAO.deleteItem(id); 
    }
    
    public List<Product> getAllProducts() {
        return itemDAO.getAllProducts();
    }
}
