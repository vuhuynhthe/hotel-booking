/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.ServiceBookingEntity;
import com.mycompany.spring_mvc_project_final.repository.ServiceBookingRepository;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author win
 */
@Service
public class ServiceBookingServiceImpl implements ServiceBookingService {

    @Autowired
    private ServiceBookingRepository serviceBookingRepository;

    @Override
    public void saveServiceBooking(ServiceBookingEntity serviceBK) {
        serviceBookingRepository.save(serviceBK);
    }

    @Override
    public List<ServiceBookingEntity> getServices() {
        List<ServiceBookingEntity> serviceBookings = serviceBookingRepository.findAll();
        if (serviceBookings != null) {
            return serviceBookings;
        }
        return new ArrayList<>();
    }

    @Override
    public ServiceBookingEntity getService(long id) {
        return serviceBookingRepository.findById(id).get();
    }
}
