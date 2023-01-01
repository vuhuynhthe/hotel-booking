/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.utils;

import com.mycompany.spring_mvc_project_final.entities.RoleEntity;
import com.mycompany.spring_mvc_project_final.enums.Role;
import java.util.Set;

/**
 *
 * @author Administrator
 */
public class AdminUtils {

    public static RoleEntity getRoleAdmin() {
        RoleEntity role = new RoleEntity();
        role.setRole(Role.ROLE_ADMIN);
        return role;
    }
    
    public static RoleEntity getRoleManager() {
        RoleEntity role = new RoleEntity();
        role.setRole(Role.ROLE_MANAGER);
        return role;
    }
    
    public static RoleEntity getRoleReciption() {
        RoleEntity role = new RoleEntity();
        role.setRole(Role.ROLE_RECIPTION);
        return role;
    }
    
    public static RoleEntity getRoleUser() {
        RoleEntity role = new RoleEntity();
        role.setRole(Role.ROLE_USER);
        return role;
    }
    
    public static boolean checkContainsRoleAdmin(Set<RoleEntity> roles){
        for(RoleEntity role : roles){
            if(role.getRole() == getRoleAdmin().getRole()){
                return true;
            }
        }
        return false;
    }
    
    public static boolean checkContainsRoleManager(Set<RoleEntity> roles){
        for(RoleEntity role : roles){
            if(role.getRole() == getRoleManager().getRole()){
                return true;
            }
        }
        return false;
    }
    
    public static boolean checkContainsRoleReciption(Set<RoleEntity> roles){
        for(RoleEntity role : roles){
            if(role.getRole() == getRoleReciption().getRole()){
                return true;
            }
        }
        return false;
    }
    
    public static boolean checkContainsRoleUser(Set<RoleEntity> roles){
        for(RoleEntity role : roles){
            if(role.getRole() == getRoleUser().getRole()){
                return true;
            }
        }
        return false;
    }
}
