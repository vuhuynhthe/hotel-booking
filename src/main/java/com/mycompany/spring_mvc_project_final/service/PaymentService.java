/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.PaymentEntity;
import java.util.List;

/**
 *
 * @author Administrator
 */
public interface PaymentService {

    public List<PaymentEntity> getPayments();

    public void savePayment(PaymentEntity payment);
}
