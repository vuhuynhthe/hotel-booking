/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.FeedbackEntity;
import java.util.List;

/**
 *
 * @author Administrator
 */
public interface FeedBackService {

    public List<FeedbackEntity> getFeedBack();

    public void save(FeedbackEntity feed);

    public FeedbackEntity getEmail(String email);
    
    public List<FeedbackEntity> getTop5();
}
