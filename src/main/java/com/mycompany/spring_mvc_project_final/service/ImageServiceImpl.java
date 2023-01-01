/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.ImageEntity;
import com.mycompany.spring_mvc_project_final.repository.ImageRepository;
import java.util.HashSet;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author win
 */
@Service
public class ImageServiceImpl implements ImageService {

    @Autowired
    private ImageRepository imagerepository;

    @Override
    public Set<ImageEntity> getImageById(Long id) {
        Set<ImageEntity> images = imagerepository.findByRoomCategoryId_Id(id);
        if (!images.isEmpty()) {
            return (Set<ImageEntity>) images;
        }
        return new HashSet<>();
    }

    @Override
    public void saveImage(ImageEntity image) {
        imagerepository.save(image);
    }
}
