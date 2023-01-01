/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

/**
 *
 * @author Administrator
 */
@Service
public class EmailService {
    
    @Autowired
    private JavaMailSender emailSender;
    
    public void sendSimpleMessage(
      String to, String subject, String text) {
        
        SimpleMailMessage message = new SimpleMailMessage(); 
        message.setFrom("learn.java.279@gmail.com");
        message.setTo(to); 
        message.setSubject(subject); 
        message.setText(text);
        emailSender.send(message);
    }
}
