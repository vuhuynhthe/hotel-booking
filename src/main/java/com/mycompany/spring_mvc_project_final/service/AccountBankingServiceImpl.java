/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.AccountBankingEntity;
import com.mycompany.spring_mvc_project_final.repository.AccountBankingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author win
 */
@Service
public class AccountBankingServiceImpl implements AccountBankingService{
    
    @Autowired
    private AccountBankingRepository accountBankingRepository;
    
    @Override
    public void saveAccBank(AccountBankingEntity accBank){
        accountBankingRepository.save(accBank);
    }
    
    @Override
    public AccountBankingEntity getAccountBankingByCartNumber(String cartNumber){
        return accountBankingRepository.findByCardNumberLike(cartNumber);
    }
}
