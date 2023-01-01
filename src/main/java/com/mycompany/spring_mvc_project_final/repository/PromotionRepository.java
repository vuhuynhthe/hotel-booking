/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import java.util.List;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

/**
 *
 * @author win
 */
@Repository
public interface PromotionRepository extends JpaRepository<PromotionEntity, Long> {

    PromotionEntity findByCode(String code);

    @Query("SELECT DISTINCT p FROM PromotionEntity p LEFT JOIN FETCH p.bookings b")
    List<PromotionEntity> getPromotionsAndPaging(Pageable pageable);
}
