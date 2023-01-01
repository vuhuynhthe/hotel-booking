/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.BookingDetailEntity;
import com.mycompany.spring_mvc_project_final.repository.BookingDetailRepository;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author Administrator
 */
@Service
public class BookingDetailServiceImpl implements BookingDetailService {

    @Autowired
    private BookingDetailRepository bookingDetailRepository;

    @Override
    public List<BookingDetailEntity> getBookingDetails() {
        List<BookingDetailEntity> bookingDetails = bookingDetailRepository.findAll();
        if (bookingDetails != null) {
            return bookingDetails;
        }
        return new ArrayList<>();
    }

    @Override
    public BookingDetailEntity getBookingDetail(long id) {
        return bookingDetailRepository.findById(id).get();
    }

    @Override
    public List<BookingDetailEntity> getBookingDetailByBookingId(long id) {
        List<BookingDetailEntity> bookingDetails = bookingDetailRepository.findByBooking_IdLike(id);
        if (bookingDetails != null) {
            return bookingDetails;
        }
        return new ArrayList<>();
    }

    @Override
    public void save(BookingDetailEntity bookingDetail) {
        bookingDetailRepository.save(bookingDetail);
    }
}
