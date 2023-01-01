/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.AccountBankingEntity;

/**
 *
 * @author Administrator
 */
public interface AccountBankingService {

    public void saveAccBank(AccountBankingEntity accBank);

    public AccountBankingEntity getAccountBankingByCartNumber(String cartNumber);
}
