/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.RoomCategoryEntity;
import java.util.List;

/**
 *
 * @author Administrator
 */
public interface CategoryRoomService {
    
    public List<RoomCategoryEntity> getCategories();
    
    public List<RoomCategoryEntity> getCategories(int index, int size);
    
    public RoomCategoryEntity getCategory(long Id);
    
    public void addRoomCategory(RoomCategoryEntity category);
    
    public void updateRoomCategory(RoomCategoryEntity category);
    
    public void deleteRoomCategory(long id);
    
    public void saveRoomCategory(RoomCategoryEntity roomCategoryEntity);
}
