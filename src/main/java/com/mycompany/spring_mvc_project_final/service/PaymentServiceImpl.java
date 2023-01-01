/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.PaymentEntity;
import com.mycompany.spring_mvc_project_final.repository.PaymentRepository;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author Administrator
 */
@Service
public class PaymentServiceImpl implements PaymentService {

    @Autowired
    private PaymentRepository paymentRepository;

    @Override
    public List<PaymentEntity> getPayments() {
        List<PaymentEntity> payments = paymentRepository.findAll();
        if (payments != null) {
            return payments;
        }
        return new ArrayList<>();
    }

    @Override
    public void savePayment(PaymentEntity payment) {
        paymentRepository.save(payment);
    }
}
