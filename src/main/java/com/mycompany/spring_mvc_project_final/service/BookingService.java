/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.BookingEntity;
import java.util.Date;
import java.util.List;
import java.util.Set;

/**
 *
 * @author Administrator
 */
public interface BookingService {

    public List<BookingEntity> getBookings();

    public List<BookingEntity> getBookings(int page, int size);

    public BookingEntity getBooking(long id);

    public BookingEntity getBookingByEmail(String email);

    public BookingEntity getBookingByIdCard(String idCard);

    public List<BookingEntity> getBookingByBookingDate(Date date);

    public List<BookingEntity> getBookingByStatus(String status);

    public BookingEntity getByCode(String code);

    public Set<BookingEntity> getBookingByAccount(long id);

    public void addBooking(BookingEntity booking);

    public void updateBooking(BookingEntity booking);

    public List<BookingEntity> findBookingByCheckin(Date date);

    public List<BookingEntity> findBookingByCheckout(Date date);

    public List<BookingEntity> findBookingByEmail(String email);

    public List<BookingEntity> getBookingByMonth(int month);

    public List<BookingEntity> getBookingByDay(int day);

    public void deleteBooking(long id);
    
    public BookingEntity getNewBookingByEmail(String email);
}
