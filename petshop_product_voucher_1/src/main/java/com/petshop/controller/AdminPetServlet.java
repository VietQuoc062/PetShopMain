package com.petshop.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.petshop.model.Item;
import com.petshop.model.Pet;
import com.petshop.service.PetService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/pets/*")
public class AdminPetServlet extends HttpServlet {
    private PetService petService;
    
    public void init() { 
        petService = new PetService(); 
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) action = "/";
        
        try {
            switch (action) {
                case "/new": showNewForm(request, response); break;
                case "/insert": insertPet(request, response); break;
                case "/delete": deletePet(request, response); break;
                case "/edit": showEditForm(request, response); break;
                case "/update": updatePet(request, response); break;
                default: listPet(request, response); break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        } catch (IllegalArgumentException ex) {
            request.setAttribute("error", ex.getMessage());
            request.setAttribute("currentPage", "pets");
            request.getRequestDispatcher("/WEB-INF/views/admin/pets/list.jsp").forward(request, response);
        }
    }

    private void listPet(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        // Get page parameter, default to 1
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        int pageSize = 10;
        int offset = (page - 1) * pageSize;
        
        int totalItems = petService.getTotalPetCount();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        
        List<Pet> listPet = petService.getPetsPaginated(offset, pageSize);
        
        request.setAttribute("listPet", listPet);
        request.setAttribute("currentPage", "pets");
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/pets/list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Item> items = petService.getAllItems();
        request.setAttribute("listItems", items);
        request.setAttribute("currentPage", "pets");
        request.getRequestDispatcher("/WEB-INF/views/admin/pets/add.jsp").forward(request, response);
    }

    private void insertPet(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        request.setCharacterEncoding("UTF-8");
        String species = request.getParameter("species");
        String breed = request.getParameter("breed");
        String ageStr = request.getParameter("age");
        String gender = request.getParameter("gender");
        String itemIdStr = request.getParameter("itemID");

        try {
            Integer age = Integer.parseInt(ageStr);
            Integer itemID = Integer.parseInt(itemIdStr);

            Pet newPet = new Pet();
            newPet.setSpecies(species);
            newPet.setBreed(breed);
            newPet.setAge(age);
            newPet.setGender(gender);
            newPet.setItemID(itemID);
            
            petService.addPet(newPet);
            response.sendRedirect(request.getContextPath() + "/admin/pets/list?message=add_success");
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/pets/new?error=invalid_input");
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Pet existingPet = petService.getPetById(id);
        List<Item> items = petService.getAllItems();
        
        request.setAttribute("pet", existingPet);
        request.setAttribute("listItems", items);
        request.setAttribute("currentPage", "pets");
        request.getRequestDispatcher("/WEB-INF/views/admin/pets/edit.jsp").forward(request, response);
    }

    private void updatePet(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        request.setCharacterEncoding("UTF-8");
        int id = Integer.parseInt(request.getParameter("id"));
        String species = request.getParameter("species");
        String breed = request.getParameter("breed");
        Integer age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        Integer itemID = Integer.parseInt(request.getParameter("itemID"));

        Pet pet = new Pet();
        pet.setPetID(id);
        pet.setSpecies(species);
        pet.setBreed(breed);
        pet.setAge(age);
        pet.setGender(gender);
        pet.setItemID(itemID);
        
        petService.updatePet(pet);
        response.sendRedirect(request.getContextPath() + "/admin/pets/list?message=update_success");
    }

    private void deletePet(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        petService.deletePet(id);
        response.sendRedirect(request.getContextPath() + "/admin/pets/list?message=delete_success");
    }
}
