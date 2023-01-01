/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.RoomEntity;
import com.mycompany.spring_mvc_project_final.enums.RoomStatus;
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
public interface RoomRepository extends JpaRepository<RoomEntity, Long> {

    Set<RoomEntity> findByRoomCategory_IdLike(long id);

    RoomEntity findByRoomNumberLike(String roomNumber);

    @Query("SELECT r FROM RoomEntity r WHERE r.id NOT IN(SELECT r.id "
            + "FROM BookingDetailEntity bd JOIN bd.booking b JOIN bd.room r "
            + "WHERE b.checkin IN(?1,?2) OR b.checkout IN(?1,?2)) AND r.roomCategory.id = ?3")
    Set<RoomEntity> findRoomAvaiable(Date d1, Date d2, long id);

    Set<RoomEntity> findByStatusLike(RoomStatus status);

    @Query("SELECT DISTINCT r FROM RoomEntity r LEFT JOIN FETCH r.bookingDetails bdt LEFT JOIN FETCH bdt.serviceBookings LEFT JOIN FETCH bdt.visitors")
    List<RoomEntity> getRoomAndPaging(Pageable pageable);
}
