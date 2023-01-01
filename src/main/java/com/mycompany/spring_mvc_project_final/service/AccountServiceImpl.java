/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.AccountEntity;
import com.mycompany.spring_mvc_project_final.entities.RoleEntity;
import com.mycompany.spring_mvc_project_final.enums.Role;
import com.mycompany.spring_mvc_project_final.enums.UserStatus;
import com.mycompany.spring_mvc_project_final.repository.AccountRepository;
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
public class AccountServiceImpl implements AccountService {

    @Autowired
    private AccountRepository accountRepository;

    @Override
    public List<AccountEntity> getAccounts(int index, int size) {
        List<AccountEntity> accounts = accountRepository.getAccountsAndPaging(PageRequest.of(index, size));
        if (accounts != null) {
            return accounts;
        }

        return new ArrayList<>();
    }

    @Override
    public boolean addAccount(AccountEntity account) {
        if (accountRepository.findByEmailLike(account.getEmail()) != null) {
            return false;
        } else {
            account.setStatus(UserStatus.ACTIVE);
            account.getUserRoles().add(new RoleEntity());
            account.setCreateDate(new Date());
            accountRepository.save(account);
            return true;
        }
    }

    @Override
    public void updateAccount(AccountEntity account) {
        accountRepository.save(account);
    }

    @Override
    public void deleteAccount(long id) {
        accountRepository.deleteById(id);
    }

    @Override
    public AccountEntity getAccount(long id) {
        return accountRepository.findById(id).get();
    }

    @Override
    public void saveAccount(AccountEntity account) {
        account.getUserRoles().add(new RoleEntity());
        account.setCreateDate(new Date());
        accountRepository.save(account);
    }

    @Override
    public List<AccountEntity> findByName(String name) {
        List<AccountEntity> accounts = accountRepository.findByNameContaining("%"+name+"%");
        if (accounts != null) {
            return accounts;
        }

        return new ArrayList<>();
    }

    @Override
    public List<AccountEntity> findByEmail(String email) {
        List<AccountEntity> accounts = accountRepository.findByEmailContaining("%"+email+"%");
        if (accounts != null) {
            return accounts;
        }

        return new ArrayList<>();
    }

    @Override
    public AccountEntity getAccount(String email) {
        return accountRepository.findByEmailLike(email);
    }

    @Override
    public Set<AccountEntity> getCustomers() {
        return accountRepository.findByUserRoles_Role(Role.ROLE_USER);
    }

    @Override
    public Set<AccountEntity> getStaffs() {
        return accountRepository.findByUserRoles_Role(Role.ROLE_RECIPTION);
    }

    @Override
    public List<AccountEntity> getCustomers(int i, int i1) {
        return accountRepository.findByUserRoles_Role(Role.ROLE_USER, PageRequest.of(i, i1));
    }

    @Override
    public List<AccountEntity> getStaffs(int i, int i1) {
        return accountRepository.findByUserRoles_Role(Role.ROLE_RECIPTION, PageRequest.of(i, i1));
    }

    @Override
    public List<AccountEntity> getAccounts() {
        List<AccountEntity> accounts = accountRepository.findAll();
        if (accounts != null) {
            return accounts;
        }

        return new ArrayList<>();
    }

}
