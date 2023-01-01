/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.ConvenientEntity;
import java.util.List;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Administrator
 */
@Repository
public interface ConvenientRepository extends JpaRepository<ConvenientEntity, Long> {

    @Query("SELECT DISTINCT c FROM ConvenientEntity c LEFT JOIN FETCH c.roomCategorys")
    List<ConvenientEntity> getConvenientsAndPaging(Pageable pageable);
}
