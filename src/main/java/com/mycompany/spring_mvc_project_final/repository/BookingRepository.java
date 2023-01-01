/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.BookingEntity;
import java.util.Date;
import java.util.List;
import java.util.Set;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Administrator
 */
@Repository
public interface BookingRepository extends JpaRepository<BookingEntity, Long> {

    BookingEntity findByEmailLike(String email);

    List<BookingEntity> findByBookingDateLike(Date date);

    List<BookingEntity> findByCheckinLike(Date date);

    List<BookingEntity> findByCheckoutLike(Date date);

    @Query("SELECT DISTINCT b FROM BookingEntity b JOIN FETCH b.bookingDetails bdt JOIN FETCH b.payments p WHERE b.email = ?1")
    List<BookingEntity> findByEmail(String email);

    @Query("SELECT b FROM BookingEntity b INNER JOIN FETCH b.bookingDetails bdt WHERE b.id = ?1")
    BookingEntity getBooking(long id);

    List<BookingEntity> findByStatusLike(String status);

    BookingEntity findByCodeLike(String code);

    Set<BookingEntity> findByAccount_IdLike(Long id);

    @Query("SELECT DISTINCT b FROM BookingEntity b LEFT JOIN FETCH b.bookingDetails bdt LEFT JOIN FETCH b.payments p WHERE ?1 = MONTH(b.checkout)")
    List<BookingEntity> findByMonth(int month);

    @Query("SELECT DISTINCT b FROM BookingEntity b LEFT JOIN FETCH b.bookingDetails bdt LEFT JOIN FETCH b.payments p WHERE ?1 = DAY(b.checkout)")
    List<BookingEntity> findByDay(int day);

    BookingEntity findTop1ByEmailLikeOrderByIdDesc(String email);

    @Query("SELECT DISTINCT b FROM BookingEntity b LEFT JOIN FETCH b.payments p")
    List<BookingEntity> getBookingsAndPaging(Pageable pageable);
}
