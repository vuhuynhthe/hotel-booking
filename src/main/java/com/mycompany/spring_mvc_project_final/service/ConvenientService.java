/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.ConvenientEntity;
import java.util.List;

/**
 *
 * @author Administrator
 */
public interface ConvenientService {
    
    public List<ConvenientEntity> getConvenients();
    
    public List<ConvenientEntity> getConvenients(int page, int size);
    
    public void saveConvenient(ConvenientEntity convenient);
    
    public ConvenientEntity getConvenient(long id);
    
    public void deleteConvenient(long id);
}
