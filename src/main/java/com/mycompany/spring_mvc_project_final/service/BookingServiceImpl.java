/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.BookingEntity;
import com.mycompany.spring_mvc_project_final.repository.BookingRepository;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

/**
 *
 * @author Administrator
 */
@Service
public class BookingServiceImpl implements BookingService {

    @Autowired
    private BookingRepository bookingRepository;

    @Override
    public List<BookingEntity> getBookings() {
        List<BookingEntity> bookings = bookingRepository.findAll();
        if (bookings != null) {
            return bookings;
        }
        return new ArrayList<>();
    }

    @Override
    public List<BookingEntity> getBookings(int page, int size) {
        List<BookingEntity> bookings = bookingRepository.getBookingsAndPaging(PageRequest.of(page, size));
        if (bookings != null) {
            return bookings;
        }
        return new ArrayList<>();
    }

    @Override
    public BookingEntity getBooking(long id) {
        return bookingRepository.getBooking(id);
    }

    @Override
    public BookingEntity getBookingByEmail(String email) {
        return bookingRepository.findByEmailLike(email);
    }

    @Override
    public BookingEntity getBookingByIdCard(String idCard) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<BookingEntity> getBookingByBookingDate(Date date) {
        List<BookingEntity> bookings = bookingRepository.findByBookingDateLike(date);
        if (bookings != null) {
            return bookings;
        }
        return new ArrayList<>();
    }

    @Override
    public List<BookingEntity> getBookingByStatus(String status) {
        List<BookingEntity> bookings = bookingRepository.findByStatusLike(status);
        if (bookings != null) {
            return bookings;
        }
        return new ArrayList<>();
    }

    @Override
    public BookingEntity getByCode(String code) {
        return bookingRepository.findByCodeLike(code);
    }

    @Override
    public Set<BookingEntity> getBookingByAccount(long id) {
        return bookingRepository.findByAccount_IdLike(id);
    }

    @Override
    public void addBooking(BookingEntity booking) {
        booking.setBookingDate(new Date());
        bookingRepository.save(booking);
    }

    @Override
    public void updateBooking(BookingEntity booking) {
        bookingRepository.save(booking);
    }

    @Override
    public List<BookingEntity> findBookingByCheckin(Date date) {
        List<BookingEntity> bookings = bookingRepository.findByCheckinLike(date);
        if (bookings != null) {
            return bookings;
        }
        return new ArrayList<>();
    }

    @Override
    public List<BookingEntity> findBookingByCheckout(Date date) {
        List<BookingEntity> bookings = bookingRepository.findByCheckoutLike(date);
        if (bookings != null) {
            return bookings;
        }
        return new ArrayList<>();
    }

    @Override
    public List<BookingEntity> findBookingByEmail(String email) {
        List<BookingEntity> bookings = bookingRepository.findByEmail(email);
        if (bookings != null) {
            return bookings;
        }
        return new ArrayList<>();
    }

    @Override
    public List<BookingEntity> getBookingByMonth(int month) {
        List<BookingEntity> bookings = bookingRepository.findByMonth(month);
        if (bookings != null) {
            return bookings;
        }
        return new ArrayList<>();
    }

    @Override
    public List<BookingEntity> getBookingByDay(int day) {
        List<BookingEntity> bookings = bookingRepository.findByDay(day);
        if (bookings != null) {
            return bookings;
        }
        return new ArrayList<>();
    }

    @Override
    public void deleteBooking(long id) {
        bookingRepository.deleteById(id);
    }

    @Override
    public BookingEntity getNewBookingByEmail(String email) {
        return bookingRepository.findTop1ByEmailLikeOrderByIdDesc(email);
    }
}
