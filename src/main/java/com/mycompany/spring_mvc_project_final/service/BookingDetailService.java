/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.BookingDetailEntity;
import java.util.List;

/**
 *
 * @author Administrator
 */
public interface BookingDetailService {

    public List<BookingDetailEntity> getBookingDetails();

    public BookingDetailEntity getBookingDetail(long id);

    public List<BookingDetailEntity> getBookingDetailByBookingId(long id);

    public void save(BookingDetailEntity bookingDetail);
}
