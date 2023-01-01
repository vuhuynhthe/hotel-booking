/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.ServiceBookingEntity;
import java.util.List;

/**
 *
 * @author win
 */
public interface ServiceBookingService {

    public List<ServiceBookingEntity> getServices();

    public ServiceBookingEntity getService(long id);

    public void saveServiceBooking(ServiceBookingEntity serviceBK);
}
