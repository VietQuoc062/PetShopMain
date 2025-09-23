package com.petweb.servlet;

import java.io.IOException;
import com.petweb.model.Pet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/pet-detail")
public class PetDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // In a real application, you would get the pet ID from the request
        // and fetch the pet details from a database
        String idParam = request.getParameter("id");
        int petId = (idParam != null) ? Integer.parseInt(idParam) : 1;
        
        // Create empty Pet object - will be populated from database later
        Pet pet = new Pet();
        // Initialize with empty/default values
        pet.setId(petId);
        pet.setName("");
        pet.setAlias("");
        pet.setOrigin("");
        pet.setType("");
        pet.setFurType("");
        pet.setColors("");
        pet.setFeatures("");
        pet.setWeight(0.0);
        pet.setAgeRange("");
        pet.setBreedingAge("");
        pet.setLittersPerYear(0);
        pet.setImageUrl("");
        
        request.setAttribute("pet", pet);
        request.getRequestDispatcher("/petDetail.jsp").forward(request, response);
    }
}