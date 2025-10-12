package com.petshop.service;

import java.util.List;

import com.petshop.dao.PetDAO;
import com.petshop.model.Item;
import com.petshop.model.Pet;

public class PetService {
    private PetDAO petDAO;
    
    public PetService() { 
        this.petDAO = new PetDAO(); 
    }

    public List<Pet> getAllPets() { 
        return petDAO.getAllPets(); 
    }
    
    public List<Pet> getPetsPaginated(int offset, int limit) { 
        return petDAO.getPetsPaginated(offset, limit); 
    }
    
    public int getTotalPetCount() { 
        return petDAO.getTotalPetCount(); 
    }
    
    public Pet getPetById(int id) { 
        return petDAO.getPetById(id); 
    }

    public Pet addPet(Pet pet) { 
        return petDAO.addPet(pet); 
    }

    public Pet updatePet(Pet pet) { 
        return petDAO.updatePet(pet); 
    }

    public void deletePet(int id) { 
        petDAO.deletePet(id); 
    }
    
    public List<Item> getAllItems() {
        return petDAO.getAllItems();
    }
}
