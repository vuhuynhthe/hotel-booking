/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.RoomCategoryEntity;
import com.mycompany.spring_mvc_project_final.repository.RoomCategoryRepository;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

/**
 *
 * @author Administrator
 */
@Service
public class CategoryRoomServiceImpl implements CategoryRoomService {

    @Autowired
    private RoomCategoryRepository roomCategoryRepository;

    @Override
    public List<RoomCategoryEntity> getCategories(int index, int size) {
        List<RoomCategoryEntity> categories = roomCategoryRepository.getCategoriesAndPaging(PageRequest.of(index, size));
        if (categories != null) {
            return categories;
        }
        return new ArrayList<>();
    }

    @Override
    public List<RoomCategoryEntity> getCategories() {
        List<RoomCategoryEntity> categories = roomCategoryRepository.findAll();
        if (categories != null) {
            return categories;
        }
        return new ArrayList<>();
    }

    @Override
    public RoomCategoryEntity getCategory(long Id) {
        return roomCategoryRepository.findById(Id).get();
    }

    public Set<RoomCategoryEntity> searchNameAndPrice(String name, double price) {
        return roomCategoryRepository.searchNameAndPrice(name, price);
    }

    @Override
    public void addRoomCategory(RoomCategoryEntity category) {
        category.setCreateDate(new Date());
        roomCategoryRepository.save(category);
    }

    @Override
    public void updateRoomCategory(RoomCategoryEntity category) {
        category.setConvenients(roomCategoryRepository.findById(category.getId()).get().getConvenients());
        roomCategoryRepository.save(category);
    }

    @Override
    public void deleteRoomCategory(long id) {
        roomCategoryRepository.deleteById(id);
    }

    @Override
    public void saveRoomCategory(RoomCategoryEntity roomCategoryEntity) {
        roomCategoryRepository.save(roomCategoryEntity);
    }

}
