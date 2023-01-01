/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.AccountEntity;
import java.util.List;
import java.util.Set;

/**
 *
 * @author Administrator
 */
public interface AccountService {

    public List<AccountEntity> getAccounts();

    public List<AccountEntity> getAccounts(int index, int size);

    public boolean addAccount(AccountEntity account);

    public AccountEntity getAccount(long id);

    public AccountEntity getAccount(String email);

    public void saveAccount(AccountEntity account);

    public List<AccountEntity> findByName(String name);

    public List<AccountEntity> findByEmail(String email);

    public Set<AccountEntity> getCustomers();

    public Set<AccountEntity> getStaffs();

    public List<AccountEntity> getCustomers(int page, int size);

    public List<AccountEntity> getStaffs(int page, int size);

    public void updateAccount(AccountEntity account);

    public void deleteAccount(long id);
}
