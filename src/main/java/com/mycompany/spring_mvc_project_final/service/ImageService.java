/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.ImageEntity;
import java.util.Set;

/**
 *
 * @author Administrator
 */
public interface ImageService {

    public Set<ImageEntity> getImageById(Long id);

    public void saveImage(ImageEntity image);
}
