/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.ServiceEntity;
import java.util.List;

/**
 *
 * @author Administrator
 */
public interface ServiceService {

    public List<ServiceEntity> getServices();

    public List<ServiceEntity> getServices(int page, int size);

    public void addService(ServiceEntity service);

    public void updateService(ServiceEntity service);

    public ServiceEntity getService(long id);
    
    public void deleteService(long id);
}
