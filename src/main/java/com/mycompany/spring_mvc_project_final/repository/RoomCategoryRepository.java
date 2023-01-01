/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.RoomCategoryEntity;
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
public interface RoomCategoryRepository extends JpaRepository<RoomCategoryEntity, Long> {

    @Query("Select DISTINCT  p FROM RoomCategoryEntity p LEFT JOIN FETCH p.images where p.name like %?1%"
            + "and p.price >?2 ")
    Set<RoomCategoryEntity> searchNameAndPrice(String name, double price);

    @Query("SELECT DISTINCT c FROM RoomCategoryEntity c LEFT JOIN FETCH c.rooms r LEFT JOIN FETCH c.convenients LEFT JOIN FETCH r.bookingDetails")
    List<RoomCategoryEntity> getCategoriesAndPaging(Pageable pageable);
}
