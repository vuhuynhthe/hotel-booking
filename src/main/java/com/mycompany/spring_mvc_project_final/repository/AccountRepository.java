/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.AccountEntity;
import com.mycompany.spring_mvc_project_final.enums.Role;
import com.mycompany.spring_mvc_project_final.enums.UserStatus;
import java.util.List;
import java.util.Set;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface AccountRepository extends JpaRepository<AccountEntity, Long> {

    AccountEntity findByEmailLikeAndStatusLike(String email,
            UserStatus status);

    AccountEntity findByEmailLike(String email);
    
    @Query("SELECT DISTINCT a FROM AccountEntity a LEFT JOIN FETCH a.bookings WHERE a.name LIKE ?1")
    List<AccountEntity> findByNameContaining(String name);
    
    @Query("SELECT DISTINCT a FROM AccountEntity a LEFT JOIN FETCH a.bookings WHERE a.email LIKE ?1")
    List<AccountEntity> findByEmailContaining(String email);

    Set<AccountEntity> findByUserRoles_Role(Role role);

    List<AccountEntity> findByUserRoles_Role(Role role, Pageable pageable);

    @Query("SELECT DISTINCT a FROM AccountEntity a LEFT JOIN FETCH a.bookings")
    List<AccountEntity> getAccountsAndPaging(Pageable pageable);
}
