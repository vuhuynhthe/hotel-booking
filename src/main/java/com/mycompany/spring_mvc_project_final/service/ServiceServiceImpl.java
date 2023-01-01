/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.ServiceEntity;
import com.mycompany.spring_mvc_project_final.repository.ServiceRepository;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

/**
 *
 * @author Administrator
 */
@Service
public class ServiceServiceImpl implements ServiceService {

    @Autowired
    private ServiceRepository serviceRepository;

    @Override
    public List<ServiceEntity> getServices(int page, int size) {
        List<ServiceEntity> services = serviceRepository.getServiceAndPaging(PageRequest.of(page, size));
        if (services != null) {
            return services;
        }
        return new ArrayList<>();
    }

    @Override
    public List<ServiceEntity> getServices() {
        List<ServiceEntity> services = serviceRepository.findAll();
        if (services != null) {
            return services;
        }
        return new ArrayList<>();
    }

    @Override
    public ServiceEntity getService(long id) {
        return serviceRepository.findById(id).get();
    }

    @Override
    public void addService(ServiceEntity service) {
        service.setCreateDate(new Date());
        serviceRepository.save(service);
    }

    @Override
    public void updateService(ServiceEntity service) {
        serviceRepository.save(service);
    }

    @Override
    public void deleteService(long id) {
        serviceRepository.deleteById(id);
    }

}
